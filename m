From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 23:45:36 +0530
Subject: [PATCH v6 08/10] ARM: S5P64x0: Modify platform data for pl330 driver
In-Reply-To: <1318270538-30450-8-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-5-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-8-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318270538-30450-9-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the 'struct dma_pl330_peri' removed, the platfrom data for dma
driver can be simplified to a simple list of peripheral request ids.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-s5p64x0/dma.c |  227 ++++++++++++------------------------------
 1 files changed, 65 insertions(+), 162 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
index 442dd4a..f820c07 100644
--- a/arch/arm/mach-s5p64x0/dma.c
+++ b/arch/arm/mach-s5p64x0/dma.c
@@ -38,176 +38,74 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-struct dma_pl330_peri s5p6440_pdma_peri[22] = {
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
-		.peri_id = DMACH_MAX,
-	}, {
-		.peri_id = DMACH_MAX,
-	}, {
-		.peri_id = (u8)DMACH_PCM0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_MAX,
-	}, {
-		.peri_id = (u8)DMACH_MAX,
-	}, {
-		.peri_id = (u8)DMACH_MAX,
-	}, {
-		.peri_id = (u8)DMACH_MAX,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_RX,
-		.rqtype = DEVTOMEM,
-	},
+u8 s5p6440_pdma_peri[] = {
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART1_RX,
+	DMACH_UART1_TX,
+	DMACH_UART2_RX,
+	DMACH_UART2_TX,
+	DMACH_UART3_RX,
+	DMACH_UART3_TX,
+	DMACH_MAX,
+	DMACH_MAX,
+	DMACH_PCM0_TX,
+	DMACH_PCM0_RX,
+	DMACH_I2S0_TX,
+	DMACH_I2S0_RX,
+	DMACH_SPI0_TX,
+	DMACH_SPI0_RX,
+	DMACH_MAX,
+	DMACH_MAX,
+	DMACH_MAX,
+	DMACH_MAX,
+	DMACH_SPI1_TX,
+	DMACH_SPI1_RX,
 };
 
 struct dma_pl330_platdata s5p6440_pdma_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(s5p6440_pdma_peri),
-	.peri = s5p6440_pdma_peri,
+	.peri_id = s5p6440_pdma_peri,
 };
 
-struct dma_pl330_peri s5p6450_pdma_peri[32] = {
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
-		.peri_id = (u8)DMACH_UART4_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART4_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI0_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PCM2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_PCM2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_SPI1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_USI_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_USI_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_MAX,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S1_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_I2S2_TX,
-		.rqtype = MEMTODEV,
-	}, {
-		.peri_id = (u8)DMACH_I2S2_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_PWM,
-	}, {
-		.peri_id = (u8)DMACH_UART5_RX,
-		.rqtype = DEVTOMEM,
-	}, {
-		.peri_id = (u8)DMACH_UART5_TX,
-		.rqtype = MEMTODEV,
-	},
+u8 s5p6450_pdma_peri[] = {
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART1_RX,
+	DMACH_UART1_TX,
+	DMACH_UART2_RX,
+	DMACH_UART2_TX,
+	DMACH_UART3_RX,
+	DMACH_UART3_TX,
+	DMACH_UART4_RX,
+	DMACH_UART4_TX,
+	DMACH_PCM0_TX,
+	DMACH_PCM0_RX,
+	DMACH_I2S0_TX,
+	DMACH_I2S0_RX,
+	DMACH_SPI0_TX,
+	DMACH_SPI0_RX,
+	DMACH_PCM1_TX,
+	DMACH_PCM1_RX,
+	DMACH_PCM2_TX,
+	DMACH_PCM2_RX,
+	DMACH_SPI1_TX,
+	DMACH_SPI1_RX,
+	DMACH_USI_TX,
+	DMACH_USI_RX,
+	DMACH_MAX,
+	DMACH_I2S1_TX,
+	DMACH_I2S1_RX,
+	DMACH_I2S2_TX,
+	DMACH_I2S2_RX,
+	DMACH_PWM,
+	DMACH_UART5_RX,
+	DMACH_UART5_TX,
 };
 
 struct dma_pl330_platdata s5p6450_pdma_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(s5p6450_pdma_peri),
-	.peri = s5p6450_pdma_peri,
+	.peri_id = s5p6450_pdma_peri,
 };
 
 struct amba_device s5p64x0_device_pdma = {
@@ -227,10 +125,15 @@ struct amba_device s5p64x0_device_pdma = {
 
 static int __init s5p64x0_dma_init(void)
 {
-	if (soc_is_s5p6450())
+	if (soc_is_s5p6450()) {
+		dma_cap_set(DMA_SLAVE, s5p6450_pdma_pdata.cap_mask);
+		dma_cap_set(DMA_CYCLIC, s5p6450_pdma_pdata.cap_mask);
 		s5p64x0_device_pdma.dev.platform_data = &s5p6450_pdma_pdata;
-	else
+	} else {
+		dma_cap_set(DMA_SLAVE, s5p6440_pdma_pdata.cap_mask);
+		dma_cap_set(DMA_CYCLIC, s5p6440_pdma_pdata.cap_mask);
 		s5p64x0_device_pdma.dev.platform_data = &s5p6440_pdma_pdata;
+	}
 
 	amba_device_register(&s5p64x0_device_pdma, &iomem_resource);
 
-- 
1.6.6.rc2
