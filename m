From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Dec 2011 21:34:34 +0200
Subject: [PATCH v3 9/9] ASoC: Kconfig: OMAP4: Enable support for PandaBoards
In-Reply-To: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1324582474-18181-10-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ASoC audio support for OMAP4 based machines with
twl6040 codec via the omap-abe-twl6040 machine driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 98410b8..47b23fe 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -99,7 +99,7 @@ config SND_OMAP_SOC_SDP3430
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
+	depends on TWL4030_CORE && SND_OMAP_SOC && ARCH_OMAP4
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
@@ -108,6 +108,8 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	  Say Y if you want to add support for SoC audio on OMAP boards using
 	  ABE and twl6040 codec. This driver currently supports:
 	  - SDP4430/Blaze boards
+	  - PandaBoard (4430)
+	  - PandaBoardES (4460)
 
 config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
-- 
1.7.8.1
