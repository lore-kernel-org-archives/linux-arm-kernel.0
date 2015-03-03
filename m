From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 3 Mar 2015 16:45:17 +0200
Subject: [PATCH 1/5] ASoC: davinci: Select SND_EDMA_SOC when SND_DAVINCI_SOC
 is enabled
In-Reply-To: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
References: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1425393921-14219-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

edma-pcm going to replace davinci-pcm as platform driver for daVinci
platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 4a328ddfa5bd..7acce887b073 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,10 +1,11 @@
 config SND_DAVINCI_SOC
 	tristate "SoC Audio for TI DAVINCI"
 	depends on ARCH_DAVINCI
+	select SND_EDMA_SOC
 
 config SND_EDMA_SOC
 	tristate "SoC Audio for Texas Instruments chips using eDMA (AM33XX/43XX)"
-	depends on SOC_AM33XX || SOC_AM43XX
+	depends on SOC_AM33XX || SOC_AM43XX || ARCH_DAVINCI
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
-- 
2.3.0
