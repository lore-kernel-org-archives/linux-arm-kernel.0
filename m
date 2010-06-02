From: weber@corscience.de (Thomas Weber)
Date: Wed,  2 Jun 2010 13:37:45 +0200
Subject: [PATCHv2 05/11] OMAP2: Devkit8000: Remove unneeded VDVI supply
In-Reply-To: <1275478671-24563-1-git-send-email-weber@corscience.de>
References: <1275478671-24563-1-git-send-email-weber@corscience.de>
Message-ID: <1275478671-24563-6-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VDVI power supply is no longer needed in
board code with the new DSS2 interface.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 70552d8..8cc8c3b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -314,10 +314,6 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	{
-	.supply		= "vdvi",
-	.dev		= &devkit8000_lcd_device.dev,
-	},
-	{
 	.supply		= "vdds_dsi",
 	.dev		= &devkit8000_dss_device.dev,
 	}
@@ -370,7 +366,6 @@ static struct regulator_init_data devkit8000_vdac = {
 /* VPLL1 for digital video outputs */
 static struct regulator_init_data devkit8000_vpll1 = {
 	.constraints = {
-		.name			= "VDVI",
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-- 
1.7.1
