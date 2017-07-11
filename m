From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Jul 2017 15:43:20 +0100
Subject: Applied "ASoC: pxa: SND_PXA2XX_SOC should depend on HAS_DMA" to the
 asoc tree
In-Reply-To: <1499628632-15421-1-git-send-email-geert@linux-m68k.org>
Message-ID: <E1dUwNk-0005MS-82@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: pxa: SND_PXA2XX_SOC should depend on HAS_DMA

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ac1ca3ba9faae7e32f189edda14f6f147053d719 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 9 Jul 2017 21:30:32 +0200
Subject: [PATCH] ASoC: pxa: SND_PXA2XX_SOC should depend on HAS_DMA

If NO_DMA=y:

    ERROR: "bad_dma_ops" [sound/soc/pxa/snd-soc-pxa2xx.ko] undefined!
    ERROR: "bad_dma_ops" [sound/arm/snd-pxa2xx-lib.ko] undefined!
    ERROR: "dma_common_mmap" [sound/arm/snd-pxa2xx-lib.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Fixes: 73d7ee2e831f106c ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 960744e46edc..484ab3c2ad67 100644
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
2.13.2
