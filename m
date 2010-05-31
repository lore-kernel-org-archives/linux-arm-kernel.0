From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 May 2010 10:49:54 +0200
Subject: [PATCH 2/2] i.MX ssi: Add missing Kconfig entry for Phytec boards
In-Reply-To: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
References: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1275295794-3168-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 11b4bcc..b1b33e6 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -19,3 +19,12 @@ config SND_MXC_SOC_WM1133_EV1
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
 	  PMIC board with WM8835x fitted.
+
+config SND_SOC_PHYCORE_AC97
+	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
+	depends on MACH_PCM043 || MACH_PCA100
+	select SND_MXC_SOC_SSI
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for SoC audio on Phytec phyCORE
+	  and phyCARD boards in AC97 mode
-- 
1.7.1
