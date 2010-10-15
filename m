From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 15 Oct 2010 23:32:11 +0800
Subject: [PATCH] arm/nuc900: delete __initdata for nuc900 lcd structures.
Message-ID: <4CB873FB.4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Delete __initdata for nuc900 lcd structures which can arise
some warning as building stage as following:

"
MODPOST vmlinux.o
WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
"

so I make this patch to fix it.

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
@@ -445,7 +445,7 @@ static struct nuc900fb_display __initdata nuc900_lcd_info[] = {
  	},
  };

-static struct nuc900fb_mach_info nuc900_fb_info __initdata = {
+static struct nuc900fb_mach_info nuc900_fb_info = {
  #if defined(CONFIG_GPM1040A0_320X240)
  	.displays		= &nuc900_lcd_info[0],
  #else
-- 
1.6.3.3
