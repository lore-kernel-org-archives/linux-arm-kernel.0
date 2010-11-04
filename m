From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Nov 2010 17:34:18 +0100
Subject: [PATCH 2/3] ARM i.MX: sdma is merged, so remove #ifdef SDMA_IS_MERGED
In-Reply-To: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
References: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288888459-7293-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 02d9890..3a705c7 100644
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
1.7.2.3
