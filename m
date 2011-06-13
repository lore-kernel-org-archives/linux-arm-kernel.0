From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jun 2011 15:37:23 +0800
Subject: [PATCH 4/6] ARM: mxc: imx-dma on imx25 has no other TO version but TO1
In-Reply-To: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307950645-26529-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx25 sdma script only gets TO1 version, so there is no need
to encode "to1" in the variable name.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index c2712b7..c64f015 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -77,7 +77,7 @@ static struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
 }
 
 #ifdef CONFIG_ARCH_MX25
-static struct sdma_script_start_addrs addr_imx25_to1 = {
+static struct sdma_script_start_addrs addr_imx25 = {
 	.ap_2_ap_addr = 729,
 	.uart_2_mcu_addr = 904,
 	.per_2_app_addr = 1255,
@@ -165,7 +165,7 @@ static int __init imxXX_add_imx_dma(void)
 
 #if defined(CONFIG_SOC_IMX25)
 	if (cpu_is_mx25()) {
-		imx25_imx_sdma_data.pdata.script_addrs = &addr_imx25_to1;
+		imx25_imx_sdma_data.pdata.script_addrs = &addr_imx25;
 		ret = imx_add_imx_sdma(&imx25_imx_sdma_data);
 	} else
 #endif
-- 
1.7.4.1
