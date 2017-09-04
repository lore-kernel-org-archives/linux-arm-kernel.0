From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Sep 2017 11:58:14 -0300
Subject: [PATCH] ARM: imx: mx31moboard: Remove unused 'dma' variable
Message-ID: <1504537094-20898-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 2436bdcda53f ("dma-coherent: remove the DMA_MEMORY_MAP and
DMA_MEMORY_IO flags") missed to remove the 'dma' variable causing
the following build warning:

arch/arm/mach-imx/mach-mx31moboard.c:478:6: warning: unused variable 'dma' [-Wunused-variable]

Remove the unused 'dma' variable.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
This applies against linux-next 20170904.

 arch/arm/mach-imx/mach-mx31moboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 3cd0309..7716f83 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -475,7 +475,7 @@ static phys_addr_t mx3_camera_base __initdata;
 
 static int __init mx31moboard_init_cam(void)
 {
-	int dma, ret;
+	int ret;
 	struct platform_device *pdev;
 
 	imx31_add_ipu_core();
-- 
2.7.4
