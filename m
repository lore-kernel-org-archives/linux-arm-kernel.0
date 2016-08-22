From: pbrobinson@gmail.com (Peter Robinson)
Date: Mon, 22 Aug 2016 13:12:42 +0100
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
Message-ID: <20160822121242.18827-1-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
these if the appropriate SoC they're embedded in isn't enabled.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 sound/soc/sunxi/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 2a954bd..a2b62dc5 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -2,6 +2,7 @@ menu "Allwinner SoC Audio support"
 
 config SND_SUN4I_CODEC
 	tristate "Allwinner A10 Codec Support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
@@ -10,6 +11,7 @@ config SND_SUN4I_CODEC
 
 config SND_SUN4I_I2S
 	tristate "Allwinner A10 I2S Support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
@@ -19,7 +21,7 @@ config SND_SUN4I_I2S
 
 config SND_SUN4I_SPDIF
 	tristate "Allwinner A10 SPDIF Support"
-	depends on OF
+	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
-- 
2.9.3
