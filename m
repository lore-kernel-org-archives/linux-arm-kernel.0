From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 21:10:59 +0200
Subject: [PATCH v2 8/8] ASoC: Samsung: Always select S3C64XX_PL080 when
 ARCH_S3C64XX is enabled
In-Reply-To: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1381950659-12703-9-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy S3C64xx DMA driver has been removed, DMA support on
S3C64xx is provided only by the generic PL08x driver.

This patch modifies the Kconfig entry of Samsung ASoC subsystem, which
relies on availability of DMA, to always select the S3C64XX_PL080
symbol.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 sound/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 206a35f..6cc5948 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,7 +1,7 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on PLAT_SAMSUNG
-	select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
+	select S3C64XX_PL080 if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C24XX
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
1.8.3.2
