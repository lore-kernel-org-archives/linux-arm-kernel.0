From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 24 Nov 2010 17:29:31 -0200
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
Message-ID: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This allows imx-for-2.6.38 tree to build again.

 arch/arm/plat-mxc/devices/platform-imx-dma.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 93e2fdc..89ec637 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -12,15 +12,7 @@
 
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
-#ifdef SDMA_IS_MERGED
 #include <mach/sdma.h>
-#else
-struct sdma_platform_data {
-	int sdma_version;
-	char *cpu_name;
-	int to_version;
-};
-#endif
 
 struct imx_imx_sdma_data {
 	resource_size_t iobase;
-- 
1.6.0.4
