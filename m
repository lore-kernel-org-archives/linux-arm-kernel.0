From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jul 2014 23:37:40 -0700
Subject: [PATCH V2 1/2] ARM: OMAP2+: DMA: remove requirement of irq for
 platform-dma driver
In-Reply-To: <1402573523-13814-2-git-send-email-r.sricharan@ti.com>
References: <1402573523-13814-1-git-send-email-r.sricharan@ti.com>
 <1402573523-13814-2-git-send-email-r.sricharan@ti.com>
Message-ID: <20140722063740.GG18374@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [140612 04:48]:
> From: Nishanth Menon <nm@ti.com>
> 
> we have currently 2 DMA drivers that try to co-exist.
> drivers/dma/omap-dma.c which registers it's own IRQ and is device tree
> aware and uses arch/arm/plat-omap/dma.c instance created by
> arch/arm/mach-omap2/dma.c to maintain channel usage (omap_request_dma).
> 
> Currently both try to register interrupts and mach-omap2/plat-omap dma.c
> attempts to use the IRQ number registered by hwmod to register it's own
> interrupt handler.
> 
> Now, there is no reasonable way of static allocating DMA irq in GIC
> SPI when we use crossbar. However, since the dma_chan structure is
> freed as a result of IRQ not being present due to devm allocation,
> maintaining information of channel by platform code fails at a later
> point in time when that region of memory is reused.
> 
> So, if hwmod does not indicate an IRQ number, then, assume that
> dma-engine will take care of the interrupt handling.

Looks OK to me, applying both into omap-for-v3.17/soc thanks.

Regards,

Tony
