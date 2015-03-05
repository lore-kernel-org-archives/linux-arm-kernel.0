From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 20:17:46 +0100
Subject: [PATCH v2 5/7] ARM: at91: sama5d4: remove useless map_io
In-Reply-To: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425583068-5826-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the peripheral remapped at io_map are taken care of by their respective
drivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/sama5.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 26b718a0c235..d7593d572a77 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -89,38 +89,6 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
 	.dt_compat	= sama5_dt_board_compat,
 MACHINE_END
 
-static struct map_desc at91_io_desc[] __initdata = {
-	{
-	.virtual        = (unsigned long)AT91_ALT_IO_P2V(SAMA5D4_BASE_MPDDRC),
-	.pfn            = __phys_to_pfn(SAMA5D4_BASE_MPDDRC),
-	.length         = SZ_512,
-	.type           = MT_DEVICE,
-	},
-	{
-	.virtual        = (unsigned long)AT91_ALT_IO_P2V(SAMA5D4_BASE_PMC),
-	.pfn            = __phys_to_pfn(SAMA5D4_BASE_PMC),
-	.length         = SZ_512,
-	.type           = MT_DEVICE,
-	},
-	{ /* On sama5d4, we use USART3 as serial console */
-	.virtual        = (unsigned long)AT91_ALT_IO_P2V(SAMA5D4_BASE_USART3),
-	.pfn            = __phys_to_pfn(SAMA5D4_BASE_USART3),
-	.length         = SZ_256,
-	.type           = MT_DEVICE,
-	},
-	{ /* A bunch of peripheral with fine grained IO space */
-	.virtual        = (unsigned long)AT91_ALT_IO_P2V(SAMA5D4_BASE_SYS2),
-	.pfn            = __phys_to_pfn(SAMA5D4_BASE_SYS2),
-	.length         = SZ_2K,
-	.type           = MT_DEVICE,
-	},
-};
-
-static void __init sama5_alt_map_io(void)
-{
-	iotable_init(at91_io_desc, ARRAY_SIZE(at91_io_desc));
-}
-
 static const char *sama5_alt_dt_board_compat[] __initconst = {
 	"atmel,sama5d4",
 	NULL
@@ -128,7 +96,6 @@ static const char *sama5_alt_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
 	/* Maintainer: Atmel */
-	.map_io		= sama5_alt_map_io,
 	.init_machine	= sama5_dt_device_init,
 	.dt_compat	= sama5_alt_dt_board_compat,
 	.l2c_aux_mask	= ~0UL,
-- 
2.1.0
