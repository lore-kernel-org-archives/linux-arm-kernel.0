From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Jun 2011 22:41:28 +0800
Subject: [PATCH v2 3/6] ARM: mxc: change imx-dma default to_version to 1
In-Reply-To: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
References: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1308753691-14442-4-git-send-email-shawn.guo@linaro.org>
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
index 1fc3522..f25a41c 100644
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
 
 #ifdef CONFIG_SOC_IMX53
-- 
1.7.4.1
