From: shawnguo@kernel.org (Shawn Guo)
Date: Thu,  8 Dec 2016 16:44:14 +0800
Subject: [PATCH 1/2] ASoC: zte: spdif and i2s drivers are not zx296702 specific
Message-ID: <1481186655-8213-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

ZTE ZX SPDIF and I2S drivers can work on not only ZX296702 but also
other ZTE ZX family SoCs like ZX296718, which is an arm64 platform.
Let's make a few renaming and tweak the Kconfig a bit to get the drivers
available for other ZTE ZX platforms.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/zte/Kconfig                          | 16 ++++++++--------
 sound/soc/zte/Makefile                         |  4 ++--
 sound/soc/zte/{zx296702-i2s.c => zx-i2s.c}     |  0
 sound/soc/zte/{zx296702-spdif.c => zx-spdif.c} |  0
 4 files changed, 10 insertions(+), 10 deletions(-)
 rename sound/soc/zte/{zx296702-i2s.c => zx-i2s.c} (100%)
 rename sound/soc/zte/{zx296702-spdif.c => zx-spdif.c} (100%)

diff --git a/sound/soc/zte/Kconfig b/sound/soc/zte/Kconfig
index c47eb25e441f..6d8a90d36315 100644
--- a/sound/soc/zte/Kconfig
+++ b/sound/soc/zte/Kconfig
@@ -1,17 +1,17 @@
-config ZX296702_SPDIF
-	tristate "ZX296702 spdif"
-	depends on SOC_ZX296702 || COMPILE_TEST
+config ZX_SPDIF
+	tristate "ZTE ZX SPDIF Driver Support"
+	depends on ARCH_ZX || COMPILE_TEST
 	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to the
-	  zx296702 spdif interface
+	  ZTE ZX SPDIF interface
 
-config ZX296702_I2S
-	tristate "ZX296702 i2s"
-	depends on SOC_ZX296702 || COMPILE_TEST
+config ZX_I2S
+	tristate "ZTE ZX I2S Driver Support"
+	depends on ARCH_ZX || COMPILE_TEST
 	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to the
-	  zx296702 i2s interface
+	  ZTE ZX I2S interface
diff --git a/sound/soc/zte/Makefile b/sound/soc/zte/Makefile
index 254ed2c8c1a0..77768f5fd10c 100644
--- a/sound/soc/zte/Makefile
+++ b/sound/soc/zte/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_ZX296702_SPDIF)	+= zx296702-spdif.o
-obj-$(CONFIG_ZX296702_I2S)	+= zx296702-i2s.o
+obj-$(CONFIG_ZX_SPDIF)	+= zx-spdif.o
+obj-$(CONFIG_ZX_I2S)	+= zx-i2s.o
diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx-i2s.c
similarity index 100%
rename from sound/soc/zte/zx296702-i2s.c
rename to sound/soc/zte/zx-i2s.c
diff --git a/sound/soc/zte/zx296702-spdif.c b/sound/soc/zte/zx-spdif.c
similarity index 100%
rename from sound/soc/zte/zx296702-spdif.c
rename to sound/soc/zte/zx-spdif.c
-- 
1.9.1
