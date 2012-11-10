From: dron0gus@gmail.com (dron0gus at gmail.com)
Date: Sat, 10 Nov 2012 18:07:57 +0400
Subject: [PATCH 2/2] ARM: S3C64XX: Staticly define parent clock of "camera"
 clock
In-Reply-To: <1352556477-3700-1-git-send-email-y>
References: <1352556477-3700-1-git-send-email-y>
Message-ID: <509e6047.a766980a.0f91.14f6@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrey Gusakov <dron_gus@mail.ru>

The "camera" clock have only one parent. Define it staticly and
remove unused source clock list.

Signed-off-by: Andrey Gusakov <dron0gus@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index b2d08fa..19228f3 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -677,15 +677,6 @@ static struct clksrc_sources clkset_audio2 = {
 	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
 };
 
-static struct clk *clkset_camif_list[] = {
-	&clk_h2,
-};
-
-static struct clksrc_sources clkset_camif = {
-	.sources	= clkset_camif_list,
-	.nr_sources	= ARRAY_SIZE(clkset_camif_list),
-};
-
 static struct clk *clkset_mfc_list[] = {
 	&clk_h2,
 	&clk_mout_epll.clk,
@@ -750,10 +741,9 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "camera",
 			.ctrlbit        = S3C_CLKCON_SCLK_CAM,
 			.enable		= s3c64xx_sclk_ctrl,
+			.parent		= &clk_h2,
 		},
 		.reg_div	= { .reg = S3C_CLK_DIV0, .shift = 20, .size = 4  },
-		.reg_src	= { .reg = NULL, .shift = 0, .size = 0  },
-		.sources	= &clkset_camif,
 	}, {
 		.clk	= {
 			.name		= "sclk_mfc",
-- 
1.7.0.4
