From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 09 Nov 2011 23:49:56 +0800
Subject: [PATCH] ARM: NUC900: fix a building WARNING 'Found 1 section
 mismatch'.
Message-ID: <4EBAA124.6060903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to fix a WARNING which is the "modpost: Found 1 section
mismatch(es)" for nuc900 platform.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/dev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 7a1fa6a..5b0c38a 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -422,7 +422,7 @@ struct platform_device nuc900_device_kpi = {

 /* LCD controller*/

-static struct nuc900fb_display __initdata nuc900_lcd_info[] = {
+static struct nuc900fb_display nuc900_lcd_info[] = {
 	/* Giantplus Technology GPM1040A0 320x240 Color TFT LCD */
 	[0] = {
 		.type		= LCM_DCCS_VA_SRC_RGB565,
@@ -445,7 +445,7 @@ static struct nuc900fb_display __initdata
nuc900_lcd_info[] = {
 	},
 };

-static struct nuc900fb_mach_info nuc900_fb_info __initdata = {
+static struct nuc900fb_mach_info nuc900_fb_info = {
 #if defined(CONFIG_GPM1040A0_320X240)
 	.displays		= &nuc900_lcd_info[0],
 #else
-- 
1.7.0.4
