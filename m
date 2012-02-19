From: axel.lin@gmail.com (Axel Lin)
Date: Sun, 19 Feb 2012 15:39:18 +0800
Subject: [PATCH 1/2] ALSA: Remove __devinit annotation for
 pxa2xx_ac97_hw_probe to fix section mismatch warning
Message-ID: <1329637158.4818.4.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes below build warning:
WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
The function pxa2xx_ac97_probe() references
the function __devinit pxa2xx_ac97_hw_probe().
This is often because pxa2xx_ac97_probe lacks a __devinit
annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/arm/pxa2xx-ac97-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 0e9e822..5e926c4 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -313,7 +313,7 @@ int pxa2xx_ac97_hw_resume(void)
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_resume);
 #endif
 
-int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
+int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 {
 	int ret;
 	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
-- 
1.7.5.4
