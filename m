From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 10:02:25 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160908011535.GE13903@b29397-desktop>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3189648.KnWLgq0lTY@wuerfel> <20160908011535.GE13903@b29397-desktop>
Message-ID: <3677438.L3Nmh9fM1W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 9:15:36 AM CEST Peter Chen wrote:
> > 
> > Right, I was specifically talking about the code in chipidea here,
> > which I think is never used on the PCI bus, and how the current
> > code is broken. We can probably do better than of_dma_configure()
> > (see below), but it would be an improvement.
> 
> Chipidea is also used at PCI bus too, see drivers/usb/chipidea/ci_hdrc_pci.c
> 

Ok, I see.

The experimental patch I posted should actually handle this just fine,
as it simply assumes that dev->parent is the device used for the DMA
API in chipidea, and I think this holds true for both the PCI and the
DT based uses of this driver.

	Arnd
