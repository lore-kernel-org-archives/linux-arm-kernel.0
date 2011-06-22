From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Jun 2011 22:41:26 +0800
Subject: [PATCH v2 1/6] ARM: mxc: imx-sdma device gets 16K iosize than 4K
In-Reply-To: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
References: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1308753691-14442-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdma on all imx soc gets 16K IO space not 4K.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 4e7fbc2..1c737db 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -62,7 +62,7 @@ static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_4K - 1,
+			.end = data->iobase + SZ_16K - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
-- 
1.7.4.1
