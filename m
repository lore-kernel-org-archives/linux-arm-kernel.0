From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 23:45:37 +0530
Subject: [PATCH v6 09/10] ARM: S5PC100: Modify platform data for pl330 driver
In-Reply-To: <1318270538-30450-9-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-5-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-8-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-9-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318270538-30450-10-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the 'struct dma_pl330_peri' removed, the platfrom data for dma
driver can be simplified to a simple list of peripheral request ids.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-s5pc100/dma.c |  247 ++++++++++++-------------------------------
 1 files changed, 69 insertions(+), 178 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
index 065a087..8dfdc76 100644
--- a/arch/arm/mach-s5pc100/dma.c
+++ b/arch/arm/mach-s5pc100/dma.c
@@ -35,100 +35,42 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-struct dma_pl330_peri pdma0_peri[30] = {
-	{
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
-		.peri_id = (u8)DMACH_UART2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART3_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART3_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = DMACH_IRDA,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0S_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI2_TX,
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
-	}, {
-		.peri_id = (u8)DMACH_EXTERNAL,
-	}, {
-		.peri_id = (u8)DMACH_PWM,
-	}, {
-		.peri_id = (u8)DMACH_SPDIF,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_HSI_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_HSI_TX,
-		.rqtype = MEMTODEV,
-	},
+u8 pdma0_peri[] = {
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART1_RX,
+	DMACH_UART1_TX,
+	DMACH_UART2_RX,
+	DMACH_UART2_TX,
+	DMACH_UART3_RX,
+	DMACH_UART3_TX,
+	DMACH_IRDA,
+	DMACH_I2S0_RX,
+	DMACH_I2S0_TX,
+	DMACH_I2S0S_TX,
+	DMACH_I2S1_RX,
+	DMACH_I2S1_TX,
+	DMACH_I2S2_RX,
+	DMACH_I2S2_TX,
+	DMACH_SPI0_RX,
+	DMACH_SPI0_TX,
+	DMACH_SPI1_RX,
+	DMACH_SPI1_TX,
+	DMACH_SPI2_RX,
+	DMACH_SPI2_TX,
+	DMACH_AC97_MICIN,
+	DMACH_AC97_PCMIN,
+	DMACH_AC97_PCMOUT,
+	DMACH_EXTERNAL,
+	DMACH_PWM,
+	DMACH_SPDIF,
+	DMACH_HSI_RX,
+	DMACH_HSI_TX,
 };
 
 struct dma_pl330_platdata s5pc100_pdma0_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
-	.peri = pdma0_peri,
+	.peri_id = pdma0_peri,
 };
 
 struct amba_device s5pc100_device_pdma0 = {
@@ -147,98 +89,42 @@ struct amba_device s5pc100_device_pdma0 = {
 	.periphid = 0x00041330,
 };
 
-struct dma_pl330_peri pdma1_peri[30] = {
-	{
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
-		.peri_id = (u8)DMACH_UART2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_UART3_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART3_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = DMACH_IRDA,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0S_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ0,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ1,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ2,
-	}, {
-		.peri_id = (u8)DMACH_MSM_REQ3,
-	},
+u8 pdma1_peri[] = {
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART1_RX,
+	DMACH_UART1_TX,
+	DMACH_UART2_RX,
+	DMACH_UART2_TX,
+	DMACH_UART3_RX,
+	DMACH_UART3_TX,
+	DMACH_IRDA,
+	DMACH_I2S0_RX,
+	DMACH_I2S0_TX,
+	DMACH_I2S0S_TX,
+	DMACH_I2S1_RX,
+	DMACH_I2S1_TX,
+	DMACH_I2S2_RX,
+	DMACH_I2S2_TX,
+	DMACH_SPI0_RX,
+	DMACH_SPI0_TX,
+	DMACH_SPI1_RX,
+	DMACH_SPI1_TX,
+	DMACH_SPI2_RX,
+	DMACH_SPI2_TX,
+	DMACH_PCM0_RX,
+	DMACH_PCM1_TX,
+	DMACH_PCM1_RX,
+	DMACH_PCM1_TX,
+	DMACH_MSM_REQ0,
+	DMACH_MSM_REQ1,
+	DMACH_MSM_REQ2,
+	DMACH_MSM_REQ3,
 };
 
 struct dma_pl330_platdata s5pc100_pdma1_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
-	.peri = pdma1_peri,
+	.peri_id = pdma1_peri,
 };
 
 struct amba_device s5pc100_device_pdma1 = {
@@ -259,7 +145,12 @@ struct amba_device s5pc100_device_pdma1 = {
 
 static int __init s5pc100_dma_init(void)
 {
+	dma_cap_set(DMA_SLAVE, s5pc100_pdma0_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, s5pc100_pdma0_pdata.cap_mask);
 	amba_device_register(&s5pc100_device_pdma0, &iomem_resource);
+
+	dma_cap_set(DMA_SLAVE, s5pc100_pdma1_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, s5pc100_pdma1_pdata.cap_mask);
 	amba_device_register(&s5pc100_device_pdma1, &iomem_resource);
 
 	return 0;
-- 
1.6.6.rc2
