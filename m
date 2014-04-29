From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 29 Apr 2014 19:18:30 +0800
Subject: [PATCH 09/15] ASoC: Migo-R sound needs I2C
In-Reply-To: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1398770316-19715-10-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The WM8978 driver needs I2C to be enabled, so the
SND_SIU_MIGOR option also requires this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel at alsa-project.org
Cc: linux-arm-kernel at lists.infradead.org
---
 sound/soc/sh/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index ff60e11..b43fdf0 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -56,7 +56,7 @@ config SND_SH7760_AC97
 
 config SND_SIU_MIGOR
 	tristate "SIU sound support on Migo-R"
-	depends on SH_MIGOR
+	depends on SH_MIGOR && I2C
 	select SND_SOC_SH4_SIU
 	select SND_SOC_WM8978
 	help
-- 
1.7.9.5
