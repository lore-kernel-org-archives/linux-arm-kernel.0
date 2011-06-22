From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Jun 2011 22:41:29 +0800
Subject: [PATCH v2 4/6] ARM: mxc: imx-dma on imx25 has no other TO version but
	TO1
In-Reply-To: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
References: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1308753691-14442-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx25 sdma script only gets TO1 version, so there is no need
to encode "to1" in the variable name.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index f25a41c..27104f5 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -82,7 +82,7 @@ static struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
 }
 
 #ifdef CONFIG_ARCH_MX25
-static struct sdma_script_start_addrs addr_imx25_to1 = {
+static struct sdma_script_start_addrs addr_imx25 = {
 	.ap_2_ap_addr = 729,
 	.uart_2_mcu_addr = 904,
 	.per_2_app_addr = 1255,
@@ -186,7 +186,7 @@ static int __init imxXX_add_imx_dma(void)
 
 #if defined(CONFIG_SOC_IMX25)
 	if (cpu_is_mx25()) {
-		imx25_imx_sdma_data.pdata.script_addrs = &addr_imx25_to1;
+		imx25_imx_sdma_data.pdata.script_addrs = &addr_imx25;
 		ret = imx_add_imx_sdma(&imx25_imx_sdma_data);
 	} else
 #endif
-- 
1.7.4.1
