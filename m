From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 14:36:29 +0200
Subject: [PATCH v2] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
In-Reply-To: <20151007175725.GC27633@localhost>
References: <1442481219-28299-1-git-send-email-Minghuan.Lian@freescale.com>
 <20151007175725.GC27633@localhost>
Message-ID: <5274293.94FcFfK0fd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 October 2015 12:57:25 Bjorn Helgaas wrote:
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index ae873be..38fe8a8 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -105,7 +105,7 @@ config PCI_XGENE_MSI
> >  
> >  config PCI_LAYERSCAPE
> >       bool "Freescale Layerscape PCIe controller"
> > -     depends on OF && ARM
> > +     depends on OF && (ARM || ARM64)
> 
> It seems like there are a couple things going on here, and I wonder if
> you can split them out into separate patches.
> 
> 1) Making this work on ARM64 as well as on ARM.  This may be of
> interest for other DesignWare-based drivers, so if you split this out,
> maybe it would be a useful template for converting the other drivers,
> too.

The Kconfig change apparently made it into linux-next now, but it
doesn't actually build on arm64, because the dependency that was
mentioned in the cover letter [0] is not there.

	Arnd


[0] This patch is based on v4.3-rc1 and [PATCH v9 0/6]
PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
patchset from Zhou Wang.
