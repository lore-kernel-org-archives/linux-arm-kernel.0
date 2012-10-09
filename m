From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 9 Oct 2012 16:25:13 -0300
Subject: [PATCH] ARM: mxc: platform-mxc-mmc: Fix register region size
Message-ID: <1349810713-12307-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not hardcode the register region to SZ_4K as this is not correct for mx31.

Use data->iosize instead which works for both mx27 and mx31 cases.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/devices/platform-mxc-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
index 540d3a7..e7b920b 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
@@ -55,7 +55,7 @@ struct platform_device *__init imx_add_mxc_mmc(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_4K - 1,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
-- 
1.7.9.5
