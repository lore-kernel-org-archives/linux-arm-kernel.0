From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Thu, 26 Nov 2015 11:59:15 +0100
Subject: [PATCH] ARM: dts: imx53: fix EIM_D27/29 pad UART2 configuration
Message-ID: <1448535555-17130-1-git-send-email-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Br?nn <p.bruenn@beckhoff.com>

MX53_PAD_EIM_D27__UART2_RXD_MUX and MX53_PAD_EIM_D29__UART2_RTS input_val must be configured as 0 instead of 1 to have UART2 muxed on EIM pins working

Signed-off-by: Patrick Br?nn <p.bruenn@beckhoff.com>
---
 arch/arm/boot/dts/imx53-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/imx53-pinfunc.h
index aec406b..a4c973d 100644
--- a/arch/arm/boot/dts/imx53-pinfunc.h
+++ b/arch/arm/boot/dts/imx53-pinfunc.h
@@ -532,7 +532,7 @@
 #define MX53_PAD_EIM_D26__IPU_DISP1_DAT_22			0x144 0x48c 0x000 0x7 0x0
 #define MX53_PAD_EIM_D27__EMI_WEIM_D_27				0x148 0x490 0x000 0x0 0x0
 #define MX53_PAD_EIM_D27__GPIO3_27				0x148 0x490 0x000 0x1 0x0
-#define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x1
+#define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x0
 #define MX53_PAD_EIM_D27__FIRI_TXD				0x148 0x490 0x000 0x3 0x0
 #define MX53_PAD_EIM_D27__IPU_CSI0_D_0				0x148 0x490 0x000 0x4 0x0
 #define MX53_PAD_EIM_D27__IPU_DI1_PIN13				0x148 0x490 0x000 0x5 0x0
@@ -548,7 +548,7 @@
 #define MX53_PAD_EIM_D28__IPU_DI0_PIN13				0x14c 0x494 0x000 0x7 0x0
 #define MX53_PAD_EIM_D29__EMI_WEIM_D_29				0x150 0x498 0x000 0x0 0x0
 #define MX53_PAD_EIM_D29__GPIO3_29				0x150 0x498 0x000 0x1 0x0
-#define MX53_PAD_EIM_D29__UART2_RTS				0x150 0x498 0x87c 0x2 0x1
+#define MX53_PAD_EIM_D29__UART2_RTS				0x150 0x498 0x87c 0x2 0x0
 #define MX53_PAD_EIM_D29__IPU_DISPB0_SER_RS			0x150 0x498 0x000 0x3 0x0
 #define MX53_PAD_EIM_D29__CSPI_SS0				0x150 0x498 0x78c 0x4 0x2
 #define MX53_PAD_EIM_D29__IPU_DI1_PIN15				0x150 0x498 0x000 0x5 0x0
-- 
1.9.1
