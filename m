From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jul 2014 23:36:23 +0200
Subject: [PATCH v2 03/12] ASoC: kirkwood: Remove unused drivers
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Message-ID: <1405028192-9623-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both kirkwood-openrd and kirkwood-t5325 drivers have been replaced
with DT based simple-card equivelents. So remove these drivers.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/kirkwood/Kconfig           |  17 -----
 sound/soc/kirkwood/Makefile          |   4 --
 sound/soc/kirkwood/kirkwood-openrd.c | 109 --------------------------------
 sound/soc/kirkwood/kirkwood-t5325.c  | 116 -----------------------------------
 4 files changed, 246 deletions(-)
 delete mode 100644 sound/soc/kirkwood/kirkwood-openrd.c
 delete mode 100644 sound/soc/kirkwood/kirkwood-t5325.c

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 06f4e8aa93ae..1f7c7ee3527a 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -15,20 +15,3 @@ config SND_KIRKWOOD_SOC_ARMADA370_DB
 	  Say Y if you want to add support for SoC audio on
 	  the Armada 370 Development Board.
 
-config SND_KIRKWOOD_SOC_OPENRD
-	tristate "SoC Audio support for Kirkwood Openrd Client"
-	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE || COMPILE_TEST)
-	depends on I2C
-	select SND_SOC_CS42L51
-	help
-	  Say Y if you want to add support for SoC audio on
-	  Openrd Client.
-
-config SND_KIRKWOOD_SOC_T5325
-	tristate "SoC Audio support for HP t5325"
-	depends on SND_KIRKWOOD_SOC && (MACH_T5325 || COMPILE_TEST) && I2C
-	select SND_SOC_ALC5623
-	help
-	  Say Y if you want to add support for SoC audio on
-	  the HP t5325 thin client.
-
diff --git a/sound/soc/kirkwood/Makefile b/sound/soc/kirkwood/Makefile
index 7c1d8fe09e6b..c36b03d8006c 100644
--- a/sound/soc/kirkwood/Makefile
+++ b/sound/soc/kirkwood/Makefile
@@ -2,10 +2,6 @@ snd-soc-kirkwood-objs := kirkwood-dma.o kirkwood-i2s.o
 
 obj-$(CONFIG_SND_KIRKWOOD_SOC) += snd-soc-kirkwood.o
 
-snd-soc-openrd-objs := kirkwood-openrd.o
-snd-soc-t5325-objs := kirkwood-t5325.o
 snd-soc-armada-370-db-objs := armada-370-db.o
 
 obj-$(CONFIG_SND_KIRKWOOD_SOC_ARMADA370_DB) += snd-soc-armada-370-db.o
-obj-$(CONFIG_SND_KIRKWOOD_SOC_OPENRD) += snd-soc-openrd.o
-obj-$(CONFIG_SND_KIRKWOOD_SOC_T5325) += snd-soc-t5325.o
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
deleted file mode 100644
index 65f2a5b9ec3b..000000000000
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
deleted file mode 100644
index 844b8415a011..000000000000
-- 
2.0.1
