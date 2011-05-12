From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:08:08 +0900
Subject: [PATCH 2/3] ASoC: Remove to support sound for S5P6442
In-Reply-To: <1305162489-25499-1-git-send-email-kgene.kim@samsung.com>
References: <1305162489-25499-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1305162489-25499-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to removing ARCH_S5P6442, we don't need to support
sound for S5P6442.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 sound/soc/samsung/Kconfig       |    4 ++--
 sound/soc/samsung/smdk_wm8580.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a3fdfb6..4b96b18 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_EXYNOS4
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_EXYNOS4
 	select S3C64XX_DMA if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C2410
 	help
@@ -55,7 +55,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450 || MACH_SMDK6442 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450 || MACH_SMDKV210 || MACH_SMDKC110)
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 8aacf23..3d26f66 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -249,7 +249,7 @@ static int __init smdk_audio_init(void)
 	int ret;
 	char *str;
 
-	if (machine_is_smdkc100() || machine_is_smdk6442()
+	if (machine_is_smdkc100()
 			|| machine_is_smdkv210() || machine_is_smdkc110()) {
 		smdk.num_links = 3;
 		/* Secondary is at offset SAMSUNG_I2S_SECOFF from Primary */
-- 
1.7.1
