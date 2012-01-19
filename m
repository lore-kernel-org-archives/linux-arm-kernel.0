From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 19 Jan 2012 17:31:33 +0000
Subject: [PATCH v6 6/9] ARM: vexpress: Motherboard RS1 memory map support
In-Reply-To: <4F184900.8050901@citrix.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-7-git-send-email-pawel.moll@arm.com>
 <4F047FE1.5030002@citrix.com>
 <1326979266.32197.60.camel@hornet.cambridge.arm.com>
 <4F184900.8050901@citrix.com>
Message-ID: <1326994293.13748.9.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-01-19 at 16:46 +0000, David Vrabel wrote:
> > It does for me:
> > 
> > # zcat /proc/config.gz | grep EARLY_PRINTK
> > CONFIG_EARLY_PRINTK=y
> > # cat /proc/device-tree/motherboard/arm,v2m-memory-map && echo
> > rs1     
> > #
> 
> earlyprintk needs to be on the kernel command line to enable it.
> Without this option it will work fine.

# cat /proc/cmdline
console=ttyAMA0,38400 earlyprintk rootwait root=/dev/mmcblk0p2 mmci.fmax=12000000 debug

I'll investigate the matter to the bottom, though. Your kernel config
would be helpful, thanks!

> It's also a problem when running as a guest under a hypervisor as there
> won't be any stage 2 translation table entries for non-existent peripherals.
> 
> I think there needs to be someway of finding out from the DTB which UART
> to use.

Yess... The DT+earlyprintk problem was discussed several times already,
without any happy resolution so far...

Pawe?
