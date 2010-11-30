From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Tue, 30 Nov 2010 16:38:54 +0100 (CET)
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <201011291657.53316.arnd@arndb.de>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<20101129142200.GA14941@n2100.arm.linux.org.uk>
	<alpine.LNX.2.00.1011291546550.12293@localhost.localdomain>
	<201011291657.53316.arnd@arndb.de>
Message-ID: <alpine.LNX.2.00.1011301633040.9052@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 29 Nov 2010, Arnd Bergmann wrote:

> On Monday 29 November 2010, Hans Ulli Kroll wrote:
> > @@ -1164,7 +1169,7 @@ config ISA_DMA_API
> >         bool
> >  
> >  config PCI
> > -       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || 
> > ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
> > +       bool "PCI support" if MIGHT_HAVE_PCI
> >         help
> >           Find out whether you have a PCI motherboard. PCI is the name of 
> > a
> >           bus system, i.e. the way the CPU talks to the other stuff inside
> 
> This does not solve the problem that Russell mentioned: existing platforms
> select PCI unconditionally, e.g. Iop13XX, some IXP, Orion, Shark
> and more. At the very least, these would need to also select MIGHT_HAVE_PCI
> to avoid the warning.
> 

so 
select MIGHT_HAVE_PCI 
in conjunction of
select PCI
on other almost platforms 

> > index fe0c82e..f5c39a8 100644
> > --- a/arch/arm/mach-ks8695/Kconfig
> > +++ b/arch/arm/mach-ks8695/Kconfig
> > @@ -4,6 +4,7 @@ menu "Kendin/Micrel KS8695 Implementations"
> >  
> >  config MACH_KS8695
> >         +++ b/arch/arm/mach-versatile/Kconfig
> > @@ -4,6 +4,7 @@ menu "Versatile platform type"
> >  config ARCH_VERSATILE_PB
> >         bool "Support Versatile/PB platform"
> >         select CPU_ARM926T
> > +       select HAVE_PCI
> >         default y
> >         help
> >           Include support for the ARM(R) Versatile/PB platform.bool 
> 
> Typo: you certainly meant MIGHT_HAVE_PCI here.
> 

Damn, I missed this.
HAVE_PCI was my first approach to do this.

> We still need to agree on what it should be doing, but otherwise this
> is what I had in mind.
> 
> 	Arnd
> 
