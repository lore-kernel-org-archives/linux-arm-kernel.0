From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 19 Nov 2017 19:57:17 +0100
Subject: [PATCH] [media] c8sectpfe: DVB_C8SECTPFE should depend on HAS_DMA
Message-ID: <1511117837-24894-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/media/platform/sti/c8sectpfe/c8sectpfe.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/media/platform/sti/c8sectpfe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/Kconfig b/drivers/media/platform/sti/c8sectpfe/Kconfig
index 7420a50572d347ef..740190f8a3b606d3 100644
--- a/drivers/media/platform/sti/c8sectpfe/Kconfig
+++ b/drivers/media/platform/sti/c8sectpfe/Kconfig
@@ -1,6 +1,6 @@
 config DVB_C8SECTPFE
 	tristate "STMicroelectronics C8SECTPFE DVB support"
-	depends on PINCTRL && DVB_CORE && I2C
+	depends on PINCTRL && DVB_CORE && I2C && HAS_DMA
 	depends on ARCH_STI || ARCH_MULTIPLATFORM || COMPILE_TEST
 	select FW_LOADER
 	select DEBUG_FS
-- 
2.7.4
