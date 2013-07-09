From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Jul 2013 04:36:57 -0700
Subject: [PATCH 09/12] ARM: DRA7: hwmod: Create initial DRA7XX SoC data
In-Reply-To: <51DBE2A2.2040403@ti.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
 <1373355139-12487-10-git-send-email-rnayak@ti.com>
 <20130709083152.GC5523@atomide.com> <51DBE2A2.2040403@ti.com>
Message-ID: <20130709113657.GF5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130709 03:21]:
> On Tuesday 09 July 2013 02:01 PM, Tony Lindgren wrote:
> > * Rajendra Nayak <rnayak@ti.com> [130709 00:39]:
> >> From: Ambresh K <ambresh@ti.com>
> > 
> >> --- /dev/null
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > ...
> > 
> >> +/* dma_system */
> >> +static struct omap_hwmod_irq_info dra7xx_dma_system_irqs[] = {
> >> +	{ .name = "0", .irq = 12 + DRA7XX_IRQ_GIC_START },
> >> +	{ .name = "1", .irq = 13 + DRA7XX_IRQ_GIC_START },
> >> +	{ .name = "2", .irq = 14 + DRA7XX_IRQ_GIC_START },
> >> +	{ .name = "3", .irq = 15 + DRA7XX_IRQ_GIC_START },
> >> +	{ .irq = -1 }
> >> +};
> > 
> > I think these should no longer be needed?
> 
> These are needed only for dma because mach-omap2/dma.c still creates
> devices from hmwod and which are used by plat/dma.c.
> These irqs for sdma exist even in the cleaned up omap4 and omap5 hmwod files.
> I'll try and get rid of that dependency of plat/dma on mach/dma to create devices.

OK great.
 
> > In general, we must move the hwmod stuff to drivers/bus and start
> > parsing the data from device tree along the lines Tero is doing
> > for the clock data.
> 
> We already have irq/dma and iospace moved to DT (some iospace info still
> exists because of non-DT drivers). With Teros patches to move clock data we
> should be able to pass the main_clk and all interface level clock info too
> from DT.

OK.

Tony
