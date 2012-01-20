From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 20 Jan 2012 16:43:08 -0200
Subject: [PATCH 1/3] ARM: mx3: Remove unneeded ifdef's from mm-imx3.c
Message-ID: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are already able to build a kernel that can run on mx31 and mx35, there
is no need for the ifdef's anymore, so remove them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx3.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 31807d2..3555e0b 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -111,7 +111,6 @@ void imx3_init_l2x0(void)
 	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
 }
 
-#ifdef CONFIG_SOC_IMX31
 static struct map_desc mx31_io_desc[] __initdata = {
 	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
 	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
@@ -176,9 +175,7 @@ void __init imx31_soc_init(void)
 
 	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
 }
-#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_SOC_IMX35
 static struct map_desc mx35_io_desc[] __initdata = {
 	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
 	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
@@ -260,4 +257,3 @@ void __init imx35_soc_init(void)
 
 	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
 }
-#endif /* ifdef CONFIG_SOC_IMX35 */
-- 
1.7.1
