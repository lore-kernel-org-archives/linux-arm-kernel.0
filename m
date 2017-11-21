From: lukma@denx.de (Lukasz Majewski)
Date: Tue, 21 Nov 2017 15:32:03 +0100
Subject: [PATCH v2 5/6] ARM: ep93xx: ts72xx: cosmetic: Add some description to
 ts72xx code
In-Reply-To: <20171121143204.1839-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de>
Message-ID: <20171121143204.1839-6-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends readability of ts72xx.c code.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- New patch
---
 arch/arm/mach-ep93xx/ts72xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index a6e473b3dcf6..2e8fcc6e87b6 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -28,6 +28,9 @@
 #include "soc.h"
 #include "ts72xx.h"
 
+/*************************************************************************
+ * IO map
+ *************************************************************************/
 static struct map_desc ts72xx_io_desc[] __initdata = {
 	{
 		.virtual	= (unsigned long)TS72XX_OPTIONS_VIRT_BASE,
@@ -189,6 +192,9 @@ static struct platform_device ts72xx_rtc_device = {
 	.num_resources 	= ARRAY_SIZE(ts72xx_rtc_resources),
 };
 
+/*************************************************************************
+ * WATCHDOG
+ *************************************************************************/
 static struct resource ts72xx_wdt_resources[] = {
 	DEFINE_RES_MEM(TS72XX_WDT_CONTROL_PHYS_BASE, SZ_4K),
 	DEFINE_RES_MEM(TS72XX_WDT_FEED_PHYS_BASE, SZ_4K),
@@ -201,10 +207,16 @@ static struct platform_device ts72xx_wdt_device = {
 	.resource	= ts72xx_wdt_resources,
 };
 
+/*************************************************************************
+ * ETH
+ *************************************************************************/
 static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
 	.phy_id		= 1,
 };
 
+/*************************************************************************
+ * TS72XX support code
+ *************************************************************************/
 #if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
 
 /* Relative to EP93XX_CS1_PHYS_BASE */
-- 
2.11.0
