From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 15:24:40 +0100
Subject: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <565DA47C.4000308@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VcC5uwGTp_N13q5P8MPtkhy0DFytDaXGrnoiHfnoEo8ng@mail.gmail.com>
 <565DA47C.4000308@ti.com>
Message-ID: <103520159.g0xhtFsXUi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 15:45:32 Peter Ujfalusi wrote:
> >> static struct dma_filter_map da830_edma_map[] = {
> >>         DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
> >>         DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
> >>         DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
> >>         DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
> >>         DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
> >>         DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
> >>         DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
> >>         DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
> >>         DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
> >>         DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
> >>         DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
> >>         DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
> > 
> > Does this ".2" and so prevent driver to use auto ID for platform devices?
> 
> Yes, as all the infra around the traditional board files with platform_device
> creation does. Ideally we could have 'phandle' pointing from this table to the
> device in question (or other way around), but I'm not aware of anything we can
> use.

I was thinking that we could use a pointer to the device structure, but
if you have that, you can also just read the name from it.

	Arnd
