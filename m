From: a.paterniani@swapp-eng.it (Andrea Paterniani)
Date: Tue, 03 Aug 2010 16:20:10 +0200
Subject: [patch 0/2] ARM: Disable outer cache before kexec call -V3
In-Reply-To: <20100705113029.082013074@linutronix.de>
References: <20100705113029.082013074@linutronix.de>
Message-ID: <4C58259A.3080404@swapp-eng.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
     I have applied your patches to kernel 2.6.35-rc4 running on my 
beagleboard.
I'm using kexec-tools-2.0.1.

My u-boot bootargs is:
     console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3 
rootwait ip=192.168.2.13::255.255.255.0

To restart the system I type:
 > sync
 > kexec -l /boot/zImage --append="console=ttyS2,115200n8 
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait 
ip=192.168.2.13::255.255.255.0"
 > kexec -e

Not every time the system restart.
In some cases no output on the console after the following:
     Bye!
     Uncompressing Linux... done, booting the kernel.

Any idea?

Regards,
Andrea



Il 05/07/2010 13.52, Thomas Gleixner ha scritto:
> The following patch series addresses the problem that the kexec code
> does not disable the outer cache before disabling the inner cache and
> jumping into the new kernel. This results in random crashes of the new
> kernel.
>
> Changes since version 2:
>
>   - Use CLEAN_INV_WAY in l2x0_flush_all according to Catalin
>
>   - Rename outer_cache_disable() to outer_disable()
>
>   - Added a  BUG_ON() when l2x0_inv_all() is called with L2 enabled.
>
> Thanks,
>
> 	tglx
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>    

-- 
