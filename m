From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 11 Jun 2015 11:06:08 +0200
Subject: [PATCH 1/2] Revert "ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai"
Message-ID: <1434013569-24745-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After discussing with the Kconfig maintainer, we found a better fiw
allowing to keep each driver as modules.

This reverts commit 0ef9dc139db2fca304ce4eadb5b8fb40d3dedb5e.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/atmel/Kconfig  | 4 ++--
 sound/soc/atmel/Makefile | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index c3152072d682..93abe4e6d596 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -9,10 +9,10 @@ config SND_ATMEL_SOC
 if SND_ATMEL_SOC
 
 config SND_ATMEL_SOC_PDC
-	bool
+	tristate
 
 config SND_ATMEL_SOC_DMA
-	bool
+	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_ATMEL_SOC_SSC
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index 4fa7ac91f972..b327e5cc8de3 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -1,8 +1,10 @@
 # AT91 Platform Support
-snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_PDC) := atmel-pcm-pdc.o
-snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o
-snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o $(snd-soc-atmel-pcm-y)
+snd-soc-atmel-pcm-pdc-objs := atmel-pcm-pdc.o
+snd-soc-atmel-pcm-dma-objs := atmel-pcm-dma.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
 
+obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
+obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
 obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
 
 # AT91 Machine Support
-- 
2.1.4
