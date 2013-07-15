From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 15 Jul 2013 14:52:23 +0530
Subject: [PATCH 09/12] ARM: DRA7: hwmod: Create initial DRA7XX SoC data
In-Reply-To: <20130709113657.GF5523@atomide.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
 <1373355139-12487-10-git-send-email-rnayak@ti.com>
 <20130709083152.GC5523@atomide.com> <51DBE2A2.2040403@ti.com>
 <20130709113657.GF5523@atomide.com>
Message-ID: <51E3BF4F.2010803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 July 2013 05:06 PM, Tony Lindgren wrote:
>>>> +/* dma_system */
>>>> > >> +static struct omap_hwmod_irq_info dra7xx_dma_system_irqs[] = {
>>>> > >> +	{ .name = "0", .irq = 12 + DRA7XX_IRQ_GIC_START },
>>>> > >> +	{ .name = "1", .irq = 13 + DRA7XX_IRQ_GIC_START },
>>>> > >> +	{ .name = "2", .irq = 14 + DRA7XX_IRQ_GIC_START },
>>>> > >> +	{ .name = "3", .irq = 15 + DRA7XX_IRQ_GIC_START },
>>>> > >> +	{ .irq = -1 }
>>>> > >> +};
>>> > > 
>>> > > I think these should no longer be needed?
>> > 
>> > These are needed only for dma because mach-omap2/dma.c still creates
>> > devices from hmwod and which are used by plat/dma.c.
>> > These irqs for sdma exist even in the cleaned up omap4 and omap5 hmwod files.
>> > I'll try and get rid of that dependency of plat/dma on mach/dma to create devices.
> OK great.

Looks like this wouldn't be possible because drivers/dma/omap-dma.c is the one which is
probing the sdma device created using device tree. So we can't have plat-omap/dma.c probe the
same device.

>  
