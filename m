From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  7 Nov 2016 18:17:45 +0000
Subject: [PATCH v11 14/14] dmaengine: st_fdma: Update st_fdma to 'depends on
 REMOTEPROC'.
In-Reply-To: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
References: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1478542665-17089-15-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During randconfig builds you can get the following warning
"warning: (ST_FDMA) selects ST_SLIM_REMOTEPROC which has unmet direct
 dependencies (REMOTEPROC)"

randconfig builds should always build without any warnings so
update fdma to depend on REMOTEPROC so this can not happen.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 661f217..6b96710 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -438,6 +438,7 @@ config STE_DMA40
 config ST_FDMA
 	tristate "ST FDMA dmaengine support"
 	depends on ARCH_STI
+	depends on REMOTEPROC
 	select ST_SLIM_REMOTEPROC
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-- 
2.7.4
