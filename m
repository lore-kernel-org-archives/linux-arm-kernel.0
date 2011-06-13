From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jun 2011 15:37:20 +0800
Subject: [PATCH 1/6] ARM: mxc: imx-sdma device gets 16K iosize than 4K
In-Reply-To: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307950645-26529-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdma on all imx soc gets 16K IO space not 4K.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index b130f60..222e439 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -57,7 +57,7 @@ static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
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
