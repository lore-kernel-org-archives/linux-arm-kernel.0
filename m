From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Aug 2013 10:04:33 +0200
Subject: [PATCH 3/3] ARM: i.MX: remove sdma script address arrays from
 platform data
In-Reply-To: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
References: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376985873-25776-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the sdma driver holds the address tables for i.MX25/5 they
are no longer needed in platform_data. Remove them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx25.c | 17 -----------------
 arch/arm/mach-imx/mm-imx5.c  | 14 --------------
 2 files changed, 31 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index e065c11..5211f62 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -61,25 +61,8 @@ void __init mx25_init_irq(void)
 	mxc_init_irq(MX25_IO_ADDRESS(MX25_AVIC_BASE_ADDR));
 }
 
-static struct sdma_script_start_addrs imx25_sdma_script __initdata = {
-	.ap_2_ap_addr = 729,
-	.uart_2_mcu_addr = 904,
-	.per_2_app_addr = 1255,
-	.mcu_2_app_addr = 834,
-	.uartsh_2_mcu_addr = 1120,
-	.per_2_shp_addr = 1329,
-	.mcu_2_shp_addr = 1048,
-	.ata_2_mcu_addr = 1560,
-	.mcu_2_ata_addr = 1479,
-	.app_2_per_addr = 1189,
-	.app_2_mcu_addr = 770,
-	.shp_2_per_addr = 1407,
-	.shp_2_mcu_addr = 979,
-};
-
 static struct sdma_platform_data imx25_sdma_pdata __initdata = {
 	.fw_name = "sdma-imx25.bin",
-	.script_addrs = &imx25_sdma_script,
 };
 
 static const struct resource imx25_audmux_res[] __initconst = {
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index cf193d8..051add9 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -103,22 +103,8 @@ void __init mx53_init_irq(void)
 	tzic_init_irq(MX53_IO_ADDRESS(MX53_TZIC_BASE_ADDR));
 }
 
-static struct sdma_script_start_addrs imx51_sdma_script __initdata = {
-	.ap_2_ap_addr = 642,
-	.uart_2_mcu_addr = 817,
-	.mcu_2_app_addr = 747,
-	.mcu_2_shp_addr = 961,
-	.ata_2_mcu_addr = 1473,
-	.mcu_2_ata_addr = 1392,
-	.app_2_per_addr = 1033,
-	.app_2_mcu_addr = 683,
-	.shp_2_per_addr = 1251,
-	.shp_2_mcu_addr = 892,
-};
-
 static struct sdma_platform_data imx51_sdma_pdata __initdata = {
 	.fw_name = "sdma-imx51.bin",
-	.script_addrs = &imx51_sdma_script,
 };
 
 static const struct resource imx51_audmux_res[] __initconst = {
-- 
1.8.4.rc3
