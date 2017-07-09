From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun,  9 Jul 2017 21:30:32 +0200
Subject: [PATCH] ASoC: pxa: SND_PXA2XX_SOC should depend on HAS_DMA
Message-ID: <1499628632-15421-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If NO_DMA=y:

    ERROR: "bad_dma_ops" [sound/soc/pxa/snd-soc-pxa2xx.ko] undefined!
    ERROR: "bad_dma_ops" [sound/arm/snd-pxa2xx-lib.ko] undefined!
    ERROR: "dma_common_mmap" [sound/arm/snd-pxa2xx-lib.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Fixes: 73d7ee2e831f106c ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 960744e46edc0549..484ab3c2ad672fc8 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,6 +1,7 @@
 config SND_PXA2XX_SOC
 	tristate "SoC Audio for the Intel PXA2xx chip"
 	depends on ARCH_PXA || COMPILE_TEST
+	depends on HAS_DMA
 	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
2.7.4
