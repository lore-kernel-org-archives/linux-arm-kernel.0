From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 16:51:51 +0200
Subject: [PATCH v7 09/11] ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
In-Reply-To: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
References: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369925513-19329-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 74ef96e..71284c0 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -149,7 +149,8 @@ config SND_SOC_PHYCORE_AC97
 	select SND_SOC_WM9712
 	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_IMX_SSI
+	select SND_SOC_FSL_SSI if MACH_PCA100
+	select SND_SOC_IMX_SSI if MACH_PCM043
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
-- 
1.8.2.1
