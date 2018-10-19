From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 19 Oct 2018 21:58:46 +0900
Subject: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
In-Reply-To: <20181019122228.GJ30658@n2100.armlinux.org.uk>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-7-hch@lst.de>
 <20181019122228.GJ30658@n2100.armlinux.org.uk>
Message-ID: <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 9:23 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> > index a68b34183107..b185794549be 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -125,7 +125,7 @@ config MACH_ARMCORE
> >       bool "CompuLab CM-X255/CM-X270 modules"
> >       select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
> >       select IWMMXT
> > -     select MIGHT_HAVE_PCI
> > +     select HAVE_PCI
> >       select NEED_MACH_IO_H if PCI
> >       select PXA25x
> >       select PXA27x
>
> This is wrong.  "MIGHT_HAVE_PCI" is _not_ the same as "HAVE_PCI" - we
> have a bunch of platforms that mandatorily have PCI and these select
> PCI directly.  "MIGHT_HAVE_PCI" controls the _visibility_ of the PCI
> menu option, but does not prevent it being selected.  Your patch will
> cause Kconfig to complain for those which mandatorily have PCI but
> do not set HAVE_PCI.


Good catch!
But, adding a bunch of 'select HAVE_PCI' along with 'select PCI' is ugly.

Do you have any suggestion?

How about letting CONFIG_ARM to select HAVE_PCI ?

-- 
Best Regards
Masahiro Yamada
