From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:05:57 +0200
Subject: [PATCH v11 4/8] ASoC: fsl: Kconfig,
 visible config items for simple card
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376924761-4054-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple sound card does not automatically select the used
chipdrivers. This patch makes them user-selectable so simple sound cards
can be used without a problem.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/Kconfig | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3a4808d..247e340 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,5 +1,11 @@
 config SND_SOC_FSL_SSI
-	tristate
+	tristate "Freescale SSI unit"
+	help
+	  Say Y here if you want tou use a Freescale SSI unit. This option is
+	  automatically selected if your board has a seperated sound card
+	  driver. If you are using one of the generic drivers, please select
+	  this manually.
+
 
 config SND_SOC_FSL_UTILS
 	tristate
@@ -109,15 +115,24 @@ config SND_SOC_IMX_SSI
 	tristate
 
 config SND_SOC_IMX_PCM_FIQ
-	tristate
+	tristate "i.MX PCM FIQ"
 	select FIQ
+	help
+	  Say Y here if you are using a generic soundcard and you have a chip
+	  that with this audio muxer. Otherwise select N.
 
 config SND_SOC_IMX_PCM_DMA
-	tristate
+	tristate "i.MX PCM DMA"
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y here if you are using a generic soundcard and you have a DMA
+	  capable SSI unit. Otherwise select N.
 
 config SND_SOC_IMX_AUDMUX
-	tristate
+	tristate "i.MX Audio muxer"
+	help
+	  Say Y here if you are using a generic soundcard and you have chip
+	  with this audio muxer. Otherwise select N.
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
-- 
1.8.4.rc3
