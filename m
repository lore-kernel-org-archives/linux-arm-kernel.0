From: j.weitzel@phytec.de (Jan Weitzel)
Date: Wed, 13 Jul 2011 12:59:22 +0200
Subject: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
In-Reply-To: <1310554738.18446.12.camel@lws-weitzel>
References: <1310554738.18446.12.camel@lws-weitzel>
Message-ID: <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vusim is not used.

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-omap2/board-omap4pcm049.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index ad8cb46..85193ec 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -227,18 +227,6 @@ static struct platform_device pcm049_vcc_3v3_device = {
 	},
 };
 
-static struct regulator_init_data pcm049_vusim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3300000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask	 =	REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
 static struct at24_platform_data board_eeprom = {
 	.byte_len = 4096,
 	.page_size = 32,
@@ -318,9 +306,7 @@ static struct i2c_board_info __initdata pcm049_i2c_4_boardinfo[] = {
 	}
 };
 
-static struct twl4030_platform_data pcm049_twldata = {
-	.vusim		= &pcm049_vusim,
-};
+static struct twl4030_platform_data pcm049_twldatai;
 
 static int __init pcm049_i2c_init(void)
 {
-- 
1.7.0.4
