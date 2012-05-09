From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Wed, 9 May 2012 17:55:20 +0530
Subject: [RFC 00/12] OMAP DMA engine conversion
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Message-ID: <CANrkHUZBPMtAqS4TwwykrOwwvH6J2WeU5cWEx_Hr66UdZdOqJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 9:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> For the full text, please see
>
> http://lists.arm.linux.org.uk/lurker/message/20120418.100954.7fa7acf8.en.html
>
> This version contains updates for some of the comments received from the
> previous round, and adds the OMAP1/2 MMC and SPI drivers to the conversion.

Tested eMMC, SD on omap4 Blaze
Tested-by: Balaji T K <balajitk@ti.com>

>
> I've also added a note to feature-removal noting that the existing APIs
> will be removed around 2013 - I'm planning January for that at the
> moment. ?Having drivers around which are unconverted blocks further work
> on the DMA engine conversion, so it's actually important that we get
> as many drivers converted as soon as possible.
>
> Anything which isn't converted will probably have its DMA code removed,
> or if that results in the driver not being usable, the driver itself
> will be removed.
>
> This series is still in RFC mode...
>
> ?Documentation/feature-removal-schedule.txt | ? 11 +
> ?arch/arm/mach-omap1/board-h2-mmc.c ? ? ? ? | ? ?1 -
> ?arch/arm/mach-omap1/board-h3-mmc.c ? ? ? ? | ? ?1 -
> ?arch/arm/mach-omap1/board-nokia770.c ? ? ? | ? ?1 -
> ?arch/arm/mach-omap2/board-n8x0.c ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-omap2/hsmmc.c ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/plat-omap/dma.c ? ? ? ? ? ? ? ? ? | ? 14 +
> ?arch/arm/plat-omap/include/plat/mmc.h ? ? ?| ? ?2 -
> ?drivers/dma/Kconfig ? ? ? ? ? ? ? ? ? ? ? ?| ? 10 +
> ?drivers/dma/Makefile ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
> ?drivers/dma/omap-dma.c ? ? ? ? ? ? ? ? ? ? | ?521 ++++++++++++++++++++++++++++
> ?drivers/dma/sa11x0-dma.c ? ? ? ? ? ? ? ? ? | ?249 ++++---------
> ?drivers/dma/virt-dma.c ? ? ? ? ? ? ? ? ? ? | ? 99 ++++++
> ?drivers/dma/virt-dma.h ? ? ? ? ? ? ? ? ? ? | ?138 ++++++++
> ?drivers/mmc/host/omap.c ? ? ? ? ? ? ? ? ? ?| ?369 +++++++++-----------
> ?drivers/mmc/host/omap_hsmmc.c ? ? ? ? ? ? ?| ?206 ++++++------
> ?drivers/spi/spi-omap2-mcspi.c ? ? ? ? ? ? ?| ?228 +++++++------
> ?17 files changed, 1268 insertions(+), 586 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
