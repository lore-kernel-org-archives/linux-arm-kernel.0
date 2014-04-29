From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 29 Apr 2014 19:18:29 +0800
Subject: [PATCH 08/15] ASoC: TTC DKB audio needs I2C 
In-Reply-To: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1398770316-19715-9-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The missing dependency can lead to build errors, so
make it explicit in Kconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel at alsa-project.org
Cc: linux-arm-kernel at lists.infradead.org
---
 sound/soc/pxa/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 6473052..6acb225 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -140,7 +140,7 @@ config SND_PXA910_SOC
 
 config SND_SOC_TTC_DKB
 	bool "SoC Audio support for TTC DKB"
-	depends on SND_PXA910_SOC && MACH_TTC_DKB
+	depends on SND_PXA910_SOC && MACH_TTC_DKB && I2C=y
 	select PXA_SSP
 	select SND_PXA_SOC_SSP
 	select SND_MMP_SOC
-- 
1.7.9.5
