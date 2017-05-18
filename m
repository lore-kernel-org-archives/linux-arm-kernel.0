From: s-anna@ti.com (Suman Anna)
Date: Thu, 18 May 2017 17:08:59 -0500
Subject: [PATCH 1/4] remoteproc/davinci: Update Kconfig to depend on DMA_CMA
In-Reply-To: <20170518220902.2846-1-s-anna@ti.com>
References: <20170518220902.2846-1-s-anna@ti.com>
Message-ID: <20170518220902.2846-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci remoteproc driver requires a CMA pool for allocating
memory for virtio vrings/buffers and other sections of the firmware
image. The allocations are done using the DMA API. The CMA option is
currently selected automatically on systems with MMU when davinci
remoteproc is enabled, switch this to a saner depends on dependency
convention. The dependency is also updated to use the DMA_CMA kconfig
symbol that is used for CMA allocations using the DMA API, the CMA
dependency is inherited implicitly.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index faad69a1a597..0aafb0d0e9fd 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -52,7 +52,7 @@ config DA8XX_REMOTEPROC
 	tristate "DA8xx/OMAP-L13x remoteproc support"
 	depends on ARCH_DAVINCI_DA8XX
 	depends on REMOTEPROC
-	select CMA if MMU
+	depends on DMA_CMA
 	select RPMSG_VIRTIO
 	help
 	  Say y here to support DA8xx/OMAP-L13x remote processors via the
-- 
2.12.0
