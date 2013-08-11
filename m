From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 11 Aug 2013 19:59:23 +0200
Subject: [PATCH 11/18] ASoC: Samsung: Do not require legacy DMA API in case of
 S3C64XX
In-Reply-To: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1376243970-6489-12-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With support for amba-pl08x driver, on S3C64xx the generic DMA engine
API can be used instead of the private s3c-dma interface.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 9855dfc..55b514d 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,7 +1,7 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on PLAT_SAMSUNG
-	select S3C64XX_DMA if ARCH_S3C64XX
+	select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
 	select S3C2410_DMA if ARCH_S3C24XX
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
1.8.3.2
