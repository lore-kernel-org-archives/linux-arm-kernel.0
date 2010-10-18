From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Oct 2010 17:35:50 +0200
Subject: [PATCH 1/7] arm/versatile: move pci code to plat-versatile
In-Reply-To: <AANLkTik4StWAGR2eygMTT48Vbv-pjUjTcACBOQBMas6j@mail.gmail.com>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
	<1287072657-32477-2-git-send-email-arnd@arndb.de>
	<AANLkTik4StWAGR2eygMTT48Vbv-pjUjTcACBOQBMas6j@mail.gmail.com>
Message-ID: <201010181735.51248.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 October 2010, Linus Walleij wrote:
> 2010/10/14 Arnd Bergmann <arnd@arndb.de>:
> 
> > The Xilinx PCI macro is used on both versatile-pb and
> > realview-eb, so we should move the implementation to place
> > where it can be shared.
> 
> >  arch/arm/Kconfig                     |    5 +
> >  arch/arm/mach-versatile/Makefile     |    1 -
> >  arch/arm/mach-versatile/pci.c        |  361 ----------------------------------
> >  arch/arm/plat-versatile/Makefile     |    1 +
> >  arch/arm/plat-versatile/xilinx-pci.c |  361 ++++++++++++++++++++++++++++++++++
> 
> What about arch/arm/common?
> 
> PCI drivers seem like they could be useful for others than ARM reference
> designs too. Xilinx FPGAs are probably quite common anyway.

I don't care either way while we don't have any other users. Most likely
a new platform using the same code would need some extra tweaks so we
could just as well move it again then.

OTOH it may also be nice as a generic PCI implementation for qemu
on other platforms which don't have their own PCI. If we ever get device
tree support running, qemu could just define the PCI host on any platform
and Linux can instantiate it from the dt.

> > (...)
> > +obj-$(CONFIG_PCI_HOST_XILINX) += xilinx-pci.o
> > diff --git a/arch/arm/plat-versatile/xilinx-pci.c b/arch/arm/plat-versatile/xilinx-pci.c
> > new file mode 100644
> > index 0000000..13c7e5f
> > --- /dev/null
> > +++ b/arch/arm/plat-versatile/xilinx-pci.c
> > @@ -0,0 +1,361 @@
> > +/*
> > + *  linux/arch/arm/mach-versatile/pci.c
> 
> Hm this file path seems inappropriate why not just delete it.

Right, will do.

Thanks,

	Arnd
