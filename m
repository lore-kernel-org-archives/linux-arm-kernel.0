From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Jun 2013 23:54:50 -0700
Subject: [PATCH v12 00/11] DMA Engine support for AM33XX
In-Reply-To: <51C85958.9030502@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <20130624101903.GV5523@atomide.com> <51C85958.9030502@ti.com>
Message-ID: <20130625065450.GY5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [130624 07:42]:
> Hi Tony,
> 
> On 06/24/2013 12:19 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > For merging this series, I suggest the following sets:
> > 
> > * Joel A Fernandes <joelagnel@ti.com> [130620 14:13]:
> >>
> >> Joel A Fernandes (3):
> >>   edma: config: Enable config options for EDMA
> >>   da8xx: config: Enable MMC and FS options
> >>   ARM: davinci: Fix compiler warnings in devices-da8xx
> >>
> >> Matt Porter (8):
> >>   dmaengine: edma: Add TI EDMA device tree binding
> >>   ARM: edma: Add DT and runtime PM support to the private EDMA API
> >>   ARM: edma: Add EDMA crossbar event mux support
> >>   dmaengine: edma: enable build for AM33XX
> > 
> > Sekhar should queue the above patches, I've acked the
> > mach-omap2/Kconfig change.
> > 
> >>   spi: omap2-mcspi: add generic DMA request support to the DT binding
> >>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
> > 
> > 
> > The spi changes should get merged via the driver list.
> > 
> >>   ARM: dts: add AM33XX EDMA support
> >>   ARM: dts: add AM33XX SPI DMA support
> > 
> > Benoit should queue the .dts changes.
> 
> I'll do that, but do you consider them for 3.11?

Yes right after -rc1 if it makes the DMA work. We almost
certainly need to send few branches of fixes after -rc1 once
we find out what might have broken by the removal of the
hwmod data..

But let's stick to minimal changes for the -rc series
naturally.

Regards,

Tony
