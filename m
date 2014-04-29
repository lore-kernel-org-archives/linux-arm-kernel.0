From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 29 Apr 2014 19:18:26 +0800
Subject: [PATCH 05/15] ASoC: nuc900: export nuc900_ac97_data
In-Reply-To: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1398770316-19715-6-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The symbol "nuc900_ac97_data" is used by the nuc900_pcm driver, 
which may be a loadable module, so we should export it.

If one tries to build SND_SOC_NUC900 without SND_SOC_NUC900_AC97,
the kernel fails to link because of the reference to nuc900_ac97_data. 

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel at alsa-project.org
Cc: linux-arm-kernel at lists.infradead.org
---
 sound/soc/nuc900/Kconfig       |    1 +
 sound/soc/nuc900/nuc900-ac97.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/nuc900/Kconfig b/sound/soc/nuc900/Kconfig
index a0ed1c6..7f0c954 100644
--- a/sound/soc/nuc900/Kconfig
+++ b/sound/soc/nuc900/Kconfig
@@ -4,6 +4,7 @@
 config SND_SOC_NUC900
 	tristate "SoC Audio for NUC900 series"
 	depends on ARCH_W90X900
+	select SND_SOC_NUC900_AC97
 	help
 	  This option enables support for AC97 mode on the NUC900 SoC.
 
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 8987bf9..f2f6794 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -28,6 +28,7 @@
 
 static DEFINE_MUTEX(ac97_mutex);
 struct nuc900_audio *nuc900_ac97_data;
+EXPORT_SYMBOL_GPL(nuc900_ac97_data);
 
 static int nuc900_checkready(void)
 {
-- 
1.7.9.5
