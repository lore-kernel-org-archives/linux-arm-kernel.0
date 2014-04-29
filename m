From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 29 Apr 2014 19:18:31 +0800
Subject: [PATCH 10/15] ASoC: TLV320AIC23 and Simtec Hermes audio 
In-Reply-To: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1398770316-19715-11-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This codec requires I2C to be enabled, so any other option
that selects it should also depend on I2C.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel at alsa-project.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 sound/soc/samsung/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index b09b5a4..9fd6f62 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -116,14 +116,14 @@ config SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23
 	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
+	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX && I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_HERMES
 	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
+	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX && I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_SAMSUNG_SIMTEC
-- 
1.7.9.5
