From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Jan 2014 17:21:11 -0800
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Message-ID: <20140108012110.GL5074@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140102 07:11]:
> The following patch series moves code to setup the DMA hardware and
> service interrupts from the hardware to the DMA engine driver.  This
> reduces the dependency on the legacy DMA implementation.
> 
> This series does not remove the channel allocation/freeing hooks which
> are used to manage the allocation of physical channels - this is the
> next step in the evolution.
> 
> The patches which move the interrupt handling are currently less than
> perfect since they're writing to ENABLE_L0 under a different spinlock,
> and hence RFC only at the moment.

Nice to see this happening. These seem to work for me based on a quick
try on omap2+, but on omap1 the build fails:

arch/arm/mach-omap1/dma.c: In function ?dma_write?:
arch/arm/mach-omap1/dma.c:186: error: ?const struct omap_dma_reg? has no member named ?size?

Regards,

Tony
