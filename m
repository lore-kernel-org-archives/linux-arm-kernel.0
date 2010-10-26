From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Oct 2010 15:56:10 +0200
Subject: [PATCH 3/7] imx: use MXxy_IO_P2V macros to setup static mappings
In-Reply-To: <86A0E76937111F4C92FABEC0A2098851051D6320@az33exm21>
References: <20101022175702.GI19834@pengutronix.de>
	<1288082996-21981-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<86A0E76937111F4C92FABEC0A2098851051D6320@az33exm21>
Message-ID: <20101026135610.GU8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dinh,

> >diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> >index bc3f30d..01dff26 100644
> >--- a/arch/arm/mach-mx5/mm.c
> >+++ b/arch/arm/mach-mx5/mm.c
> >@@ -23,33 +23,12 @@
> > /*
> >  * Define the MX51 memory map.
> >  */
> >-static struct map_desc mxc_io_desc[] __initdata = {
> >-	{
> >-		.virtual = MX51_IRAM_BASE_ADDR_VIRT,
> >-		.pfn = __phys_to_pfn(MX51_IRAM_BASE_ADDR),
> >-		.length = MX51_IRAM_SIZE,
> >-		.type = MT_DEVICE
> >-	}, {
> >-		.virtual = MX51_DEBUG_BASE_ADDR_VIRT,
> >-		.pfn = __phys_to_pfn(MX51_DEBUG_BASE_ADDR),
> >-		.length = MX51_DEBUG_SIZE,
> >-		.type = MT_DEVICE
> >-	}, {
> >-		.virtual = MX51_AIPS1_BASE_ADDR_VIRT,
> >-		.pfn = __phys_to_pfn(MX51_AIPS1_BASE_ADDR),
> >-		.length = MX51_AIPS1_SIZE,
> >-		.type = MT_DEVICE
> >-	}, {
> >-		.virtual = MX51_SPBA0_BASE_ADDR_VIRT,
> >-		.pfn = __phys_to_pfn(MX51_SPBA0_BASE_ADDR),
> >-		.length = MX51_SPBA0_SIZE,
> >-		.type = MT_DEVICE
> >-	}, {
> >-		.virtual = MX51_AIPS2_BASE_ADDR_VIRT,
> >-		.pfn = __phys_to_pfn(MX51_AIPS2_BASE_ADDR),
> >-		.length = MX51_AIPS2_SIZE,
> >-		.type = MT_DEVICE
> >-	},
> >+static struct map_desc mx51_io_desc[] __initdata = {
> >+	imx_map_entry(MX51, IRAM, MT_DEVICE),
> 
> Do you still see a need a statically map IRAM? I added the iram
> allocator functions so that users of IRAM can dynamically allocate it.
No I don't, IMHO it shouldn't have been there in the first place.  Maybe
it even *must* go away to become reliable, don't know for sure though.
But this patch is not the right one to fix it.  So if you want to send a
patch that removes unneeded mappings that's fine.  (Preferably on
mxc91231 that has more mappings than all the other SoCs.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
