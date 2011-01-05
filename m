From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Jan 2011 19:44:31 +0530
Subject: OMAP4 panda gets stuck during reboot
In-Reply-To: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
References: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
Message-ID: <45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Wednesday, January 05, 2011 7:38 PM
> To: Russell King; Tony Lindgren
> Cc: Linux ARM Kernel Mailing List; Linux OMAP Mailing List
> Subject: OMAP4 panda gets stuck during reboot
>
> Hi,
>
> It seems like there's a bug on flush_pmd_entry() for multicore ARM
> CPUs.
>
> I'm testing 2.6.37 with pandaboard and when running "reboot" it gets
> stuck on:
>
> asm("mcr	p15, 0, %0, c7, c10, 1	@ flush_pmd"
> 			: : "r" (pmd) : "cc");
>
> I added a few printk()s around the code to find the specific spot
> where
> the reset sequence was getting stuck and here's the output:
>
> [  112.497253] ===> kernel_restart (line 312)
> [  112.501525] ===> kernel_restart_prepare (line 294)
> [  112.506561] ===> device_shutdown (line 1661)
> [  112.511871] ===> device_shutdown (line 1692)
> [  112.516387] ===> sysdev_shutdown (line 323)
> [  112.520782] ===> sysdev_shutdown (line 349)
> [  112.525146] ===> kernel_restart_prepare (line 299)
> [  112.530181] Restarting system.
> [  112.533386] ===> machine_restart (line 254)
> [  112.537750] ===> machine_shutdown (line 232)
> [  112.542236] ===> machine_shutdown (line 236)
> [  112.546722] ===> arm_machine_restart (line 96)
> [  112.551391] ===> setup_mm_for_reboot (line 1059)
> [  112.556213] ===> setup_mm_for_reboot (line 1066)
> [  112.561035] ===> setup_mm_for_reboot (line 1071)
> [  112.565856] ===> flush_pmd_entry (line 522)
>
> What could it be ? Any more debugging I could do to help ?
>
This is known and seems to OMAP specific issue. Test patch and
relevant thread is here.

http://www.spinics.net/lists/arm-kernel/msg103493.html
