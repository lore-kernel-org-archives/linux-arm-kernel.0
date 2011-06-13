From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jun 2011 15:37:22 +0800
Subject: [PATCH 3/6] ARM: mxc: change imx-dma default to_version to 1
In-Reply-To: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307950645-26529-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The value 0 is not a valid TO version number.  With the current
code, imx-sdma driver will try to load firmware sdma-imx25-to0.bin,
which is obviously not a good name.  Instead, sdma-imx25-to1.bin
makes much more sense.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 1c0ba53..c2712b7 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -33,22 +33,22 @@ struct imx_imx_sdma_data {
 
 #ifdef CONFIG_SOC_IMX25
 struct imx_imx_sdma_data imx25_imx_sdma_data __initconst =
-	imx_imx_sdma_data_entry_single(MX25, 2, "imx25", 0);
+	imx_imx_sdma_data_entry_single(MX25, 2, "imx25", 1);
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX31
 struct imx_imx_sdma_data imx31_imx_sdma_data __initdata =
-	imx_imx_sdma_data_entry_single(MX31, 1, "imx31", 0);
+	imx_imx_sdma_data_entry_single(MX31, 1, "imx31", 1);
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
 struct imx_imx_sdma_data imx35_imx_sdma_data __initdata =
-	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 0);
+	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 1);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_SOC_IMX51
 struct imx_imx_sdma_data imx51_imx_sdma_data __initconst =
-	imx_imx_sdma_data_entry_single(MX51, 2, "imx51", 0);
+	imx_imx_sdma_data_entry_single(MX51, 2, "imx51", 1);
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
 static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
-- 
1.7.4.1
