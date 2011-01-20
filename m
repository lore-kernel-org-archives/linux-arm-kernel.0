From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 20 Jan 2011 12:32:39 -0800
Subject: [PATCH 1/7] msm: qsd8x50: add uart platform data
In-Reply-To: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1295555565-21563-2-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the uart for QSD8x50.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/devices-qsd8x50.c |   42 +++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index b1a8f0f..24b2051 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -28,6 +28,32 @@
 
 #include <mach/mmc.h>
 
+static struct resource resources_uart1[] = {
+	{
+		.start	= INT_UART1,
+		.end	= INT_UART1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= MSM_UART1_PHYS,
+		.end	= MSM_UART1_PHYS + MSM_UART1_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource resources_uart2[] = {
+	{
+		.start	= INT_UART2,
+		.end	= INT_UART2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= MSM_UART2_PHYS,
+		.end	= MSM_UART2_PHYS + MSM_UART2_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static struct resource resources_uart3[] = {
 	{
 		.start	= INT_UART3,
@@ -41,6 +67,20 @@ static struct resource resources_uart3[] = {
 	},
 };
 
+struct platform_device msm_device_uart1 = {
+	.name	= "msm_serial",
+	.id	= 0,
+	.num_resources	= ARRAY_SIZE(resources_uart1),
+	.resource	= resources_uart1,
+};
+
+struct platform_device msm_device_uart2 = {
+	.name	= "msm_serial",
+	.id	= 1,
+	.num_resources	= ARRAY_SIZE(resources_uart2),
+	.resource	= resources_uart2,
+};
+
 struct platform_device msm_device_uart3 = {
 	.name	= "msm_serial",
 	.id	= 2,
@@ -345,6 +385,8 @@ struct clk msm_clocks_8x50[] = {
 	CLK_PCOM("tsif_ref_clk",	TSIF_REF_CLK,	NULL, 0),
 	CLK_PCOM("tv_dac_clk",	TV_DAC_CLK,	NULL, 0),
 	CLK_PCOM("tv_enc_clk",	TV_ENC_CLK,	NULL, 0),
+	CLK_PCOM("uart_clk",	UART1_CLK,	&msm_device_uart1.dev, OFF),
+	CLK_PCOM("uart_clk",	UART2_CLK,	&msm_device_uart2.dev, OFF),
 	CLK_PCOM("uart_clk",	UART3_CLK,	&msm_device_uart3.dev, OFF),
 	CLK_PCOM("usb_hs_clk",	USB_HS_CLK,	NULL, OFF),
 	CLK_PCOM("usb_hs_pclk",	USB_HS_P_CLK,	NULL, OFF),
-- 
1.7.0.4

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
