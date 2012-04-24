From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Apr 2012 00:29:29 +0100
Subject: [RFC 00/12] OMAP DMA engine conversion
In-Reply-To: <CANOLnOOf0znGBSSQp5B3U+1q2OJBXnB_1T0aiuma_rJZDZA08Q@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <20120424103858.GC25053@n2100.arm.linux.org.uk>
 <20120424165147.GP3739@atomide.com>
 <CANOLnOOf0znGBSSQp5B3U+1q2OJBXnB_1T0aiuma_rJZDZA08Q@mail.gmail.com>
Message-ID: <20120424232928.GB6290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 01:47:21AM +0300, Grazvydas Ignotas wrote:
> On Tue, Apr 24, 2012 at 7:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120424 03:42]:
> >> Here's another patch - for the OMAP NAND driver.
> >>
> >> One thing this doesn't do is configure up the source/destination bursts,
> >> which the old code did:
> >>
> >> ? ? ? ? ? ? ? ? ? ? ? ? omap_set_dma_dest_burst_mode(info->dma_ch,
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_DATA_BURST_16);
> >> ? ? ? ? ? ? ? ? ? ? ? ? omap_set_dma_src_burst_mode(info->dma_ch,
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_DATA_BURST_16);
> >
> > Grazvydas, care to give this patch a go?
> 
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> for:
> - SD card connected over transceiver to MMC2
> - touchscreen connected over SPI
> - NAND on GPMC in DMA mode
> Seems to be working just as they did before, except that I'm not sure
> SPI was crossing PIO threshold.

I think my testing on OMAP4430SDP with the SPI based ethernet should've
caught anything untoward there.

For the MMC2, could you say whether this was the hsmmc driver or the
older omap1/2 driver please?

Thanks.
