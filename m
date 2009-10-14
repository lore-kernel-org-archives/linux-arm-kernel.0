From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:26 +0200
Subject: [PATCH 09/10] [PATCH 04/10] ASoC: finally enable support for eXeda
	and CM-X300
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <b013b3ef99e26e493af0a8d8becf3f98502b362a.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: alsa-devel at alsa-project.org
---
 sound/soc/pxa/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index dcb3181..d4f4031 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -90,7 +90,8 @@ config SND_PXA2XX_SOC_E800
 
 config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
-	depends on SND_PXA2XX_SOC && MACH_EM_X270
+	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
+			MACH_CM_X300)
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
-- 
1.6.0.6
