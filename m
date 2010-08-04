From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 4 Aug 2010 12:20:35 +0530
Subject: [patch 0/2] ARM: Disable outer cache before kexec call -V3
In-Reply-To: <4C590CBD.1080305@swapp-eng.it>
References: <20100705113029.082013074@linutronix.de>,
	<4C58259A.3080404@swapp-eng.it>
	<5A47E75E594F054BAF48C5E4FC4B92AB0321623966@dbde02.ent.ti.com>
	<4C590CBD.1080305@swapp-eng.it>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C641DFD4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Andrea Paterniani [mailto:a.paterniani at swapp-eng.it]
> Sent: Wednesday, August 04, 2010 12:16 PM
> To: Gadiyar, Anand
> Cc: linux-arm-kernel at lists.infradead.org; Thomas Gleixner;
> catalin.marinas at arm.com; Shilimkar, Santosh
> Subject: Re: [patch 0/2] ARM: Disable outer cache before kexec call -V3
> 
> Il 03/08/2010 19.36, Gadiyar, Anand ha scritto:
> > Andrea Paterniani wrote:
> >
> >> Hi,
> >>       I have applied your patches to kernel 2.6.35-rc4 running on my
> beagleboard.
> >> I'm using kexec-tools-2.0.1.
> >>
> >> My u-boot bootargs is:
> >>       console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3
> rootwait ip=192.168.2.13::255.255.255.0
> >>
> >> To restart the system I type:
> >>   >  sync
> >>   >  kexec -l /boot/zImage --append="console=ttyS2,115200n8
> root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
> ip=192.168.2.13::255.255.255.0"
> >>   >  kexec -e
> >>
> >> Not every time the system restart.
> >> In some cases no output on the console after the following:
> >>       Bye!
> >>       Uncompressing Linux... done, booting the kernel.
> >>
> >> Any idea?
> >>
> >>
> > Can you try building your kernel with CONFIG_EARLY_PRINTK,
> > and add the word "earlyprintk" to your bootargs?
> >
> >
> How to enable EARLY_PRINTK for ARM architecture?
> Browsing kernel source I find arch/arm/kernel/early_printk.c but no way
> to enable CONFIG_EARLY_PRINTK from make menuconfig.
> Is there any patch to have this config option for ARM?
>
Menuconfig >
	 Kernel hacking -> 
		Kernel low-level debugging functions 
			-->Early printk (NEW)
