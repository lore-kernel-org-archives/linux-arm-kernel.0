From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 19 Sep 2011 11:58:59 +0530
Subject: [PATCH 3/6] ARM: EXYNOS4: Modify platform data for pl330 driver
In-Reply-To: <1316413742-23535-3-git-send-email-thomas.abraham@linaro.org>
References: <1316413742-23535-1-git-send-email-thomas.abraham@linaro.org>
	<1316413742-23535-2-git-send-email-thomas.abraham@linaro.org>
	<1316413742-23535-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1316413742-23535-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the 'struct dma_pl330_peri' removed, the platfrom data for dma
driver can be simplified to a simple list of peripheral request ids.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-exynos4/dma.c |  223 ++++++++++++-------------------------------
 1 files changed, 62 insertions(+), 161 deletions(-)

diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
index 9667c61..c3c0d17 100644
--- a/arch/arm/mach-exynos4/dma.c
+++ b/arch/arm/mach-exynos4/dma.c
@@ -35,95 +35,40 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-struct dma_pl330_peri pdma0_peri[28] = {
-	{
-		.peri_id = (u8)DMACH_PCM0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ0,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ2,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0S_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART4_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART4_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS4_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS4_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_AC97_MICIN,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_AC97_PCMIN,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_AC97_PCMOUT,
-		.rqtype = MEMTODEV,
-	},
+u8 pdma0_peri[] = {
+	DMACH_PCM0_RX,
+	DMACH_PCM0_TX,
+	DMACH_PCM2_RX,
+	DMACH_PCM2_TX,
+	DMACH_MSM_REQ0,
+	DMACH_MSM_REQ2,
+	DMACH_SPI0_RX,
+	DMACH_SPI0_TX,
+	DMACH_SPI2_RX,
+	DMACH_SPI2_TX,
+	DMACH_I2S0S_TX,
+	DMACH_I2S0_RX,
+	DMACH_I2S0_TX,
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART2_RX,
+	DMACH_UART2_TX,
+	DMACH_UART4_RX,
+	DMACH_UART4_TX,
+	DMACH_SLIMBUS0_RX,
+	DMACH_SLIMBUS0_TX,
+	DMACH_SLIMBUS2_RX,
+	DMACH_SLIMBUS2_TX,
+	DMACH_SLIMBUS4_RX,
+	DMACH_SLIMBUS4_TX,
+	DMACH_AC97_MICIN,
+	DMACH_AC97_PCMIN,
+	DMACH_AC97_PCMOUT,
 };
 
 struct dma_pl330_platdata exynos4_pdma0_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
-	.peri = pdma0_peri,
+	.peri_id = pdma0_peri,
 };
 
 struct amba_device exynos4_device_pdma0 = {
@@ -142,86 +87,37 @@ struct amba_device exynos4_device_pdma0 = {
 	.periphid = 0x00041330,
 };
 
-struct dma_pl330_peri pdma1_peri[25] = {
-	{
-		.peri_id = (u8)DMACH_PCM0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ1,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ3,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0S_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART3_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART3_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS3_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS3_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS5_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SLIMBUS5_TX,
-		.rqtype = MEMTODEV,
-	},
+u8 pdma1_peri[] = {
+	DMACH_PCM0_RX,
+	DMACH_PCM0_TX,
+	DMACH_PCM1_RX,
+	DMACH_PCM1_TX,
+	DMACH_MSM_REQ1,
+	DMACH_MSM_REQ3,
+	DMACH_SPI1_RX,
+	DMACH_SPI1_TX,
+	DMACH_I2S0S_TX,
+	DMACH_I2S0_RX,
+	DMACH_I2S0_TX,
+	DMACH_I2S1_RX,
+	DMACH_I2S1_TX,
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART1_RX,
+	DMACH_UART1_TX,
+	DMACH_UART3_RX,
+	DMACH_UART3_TX,
+	DMACH_SLIMBUS1_RX,
+	DMACH_SLIMBUS1_TX,
+	DMACH_SLIMBUS3_RX,
+	DMACH_SLIMBUS3_TX,
+	DMACH_SLIMBUS5_RX,
+	DMACH_SLIMBUS5_TX,
 };
 
 struct dma_pl330_platdata exynos4_pdma1_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
-	.peri = pdma1_peri,
+	.peri_id = pdma1_peri,
 };
 
 struct amba_device exynos4_device_pdma1 = {
@@ -242,7 +138,12 @@ struct amba_device exynos4_device_pdma1 = {
 
 static int __init exynos4_dma_init(void)
 {
+	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
 	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
+
+	dma_cap_set(DMA_SLAVE, exynos4_pdma1_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
 	amba_device_register(&exynos4_device_pdma1, &iomem_resource);
 
 	return 0;
-- 
1.6.6.rc2
