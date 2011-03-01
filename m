From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Mar 2011 21:30:59 +0100
Subject: [PATCH 2/2] ARM: mx3/pcm043: fix build failure
In-Reply-To: <20110301203018.GY22310@pengutronix.de>
References: <20110301203018.GY22310@pengutronix.de>
Message-ID: <1299011459-18200-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit

	530aca5 (arm: mach-mx3: pcm043: add write-protect and card-detect for SD1)

assigned a non-existing member .cd_gpio in a struct esdhc_platform_data.
Though I expect this to change soon I remove it for now to unbreak the
autobuilders.

Cc: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 3a7b3c3..b5ee66e 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -227,7 +227,6 @@ static iomux_v3_cfg_t pcm043_pads[] = {
 #define AC97_GPIO_RESET	IMX_GPIO_NR(2, 0)
 
 #define SD1_GPIO_WP	IMX_GPIO_NR(2, 23)
-#define SD1_GPIO_CD	IMX_GPIO_NR(2, 24)
 
 static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 {
@@ -313,7 +312,6 @@ pcm037_nand_board_info __initconst = {
 
 static struct esdhc_platform_data sd1_pdata = {
 	.wp_gpio = SD1_GPIO_WP,
-	.cd_gpio = SD1_GPIO_CD,
 };
 
 #if defined(CONFIG_USB_ULPI)
-- 
1.7.2.3
