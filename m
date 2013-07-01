From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon,  1 Jul 2013 10:39:34 +0200
Subject: [RFC PATCH 09/13] sound: atmel-pcm: don't return ok if pcm-dma is not
 implemented
In-Reply-To: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1372667978-4718-10-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If DMA is not selected, atmel_pcm_dma_platform_register() should fail.
Like that, the driver knows it can't use it.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 sound/soc/atmel/atmel-pcm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 12ae814..c0a01fa 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -109,7 +109,7 @@ void atmel_pcm_dma_platform_unregister(struct device *dev);
 #else
 static inline int atmel_pcm_dma_platform_register(struct device *dev)
 {
-	return 0;
+	return -1;
 }
 static inline void atmel_pcm_dma_platform_unregister(struct device *dev)
 {
-- 
1.7.10.4
