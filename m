From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 23 Nov 2015 23:32:57 +0200
Subject: [PATCH] ARM: OMAP: RX-51: fix a typo in log writing
Message-ID: <1448314377-28848-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a typo when registering HW RNG.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 14edcd7..ff1520b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1257,7 +1257,7 @@ static struct platform_device omap3_rom_rng_device = {
 static void __init rx51_init_omap3_rom_rng(void)
 {
 	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
-		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
+		pr_info("RX-51: Registering OMAP3 HWRNG device\n");
 		platform_device_register(&omap3_rom_rng_device);
 	}
 }
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 1dfe346..35ea6c0 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -268,7 +268,7 @@ static void __init nokia_n900_legacy_init(void)
 			pr_warn("Thumb binaries may crash randomly without this workaround\n");
 		}
 
-		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
+		pr_info("RX-51: Registering OMAP3 HWRNG device\n");
 		platform_device_register(&omap3_rom_rng_device);
 
 	}
-- 
2.4.0
