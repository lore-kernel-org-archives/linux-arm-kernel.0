From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Wed, 26 Jul 2017 14:05:33 +0200
Subject: [PATCH v5 3/4] ARM: dts: imx53: add alternative UART2 configuration
In-Reply-To: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
References: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170726120534.5516-4-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

UART2 on EIM_D26 - EIM_D29 pins supports interchanging RXD/TXD pins
and RTS/CTS pins.
One board using these alternate settings is Beckhoff CX9020. Add the
alternative configuration here, to make it available to others, too.

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
---
 arch/arm/boot/dts/imx53-pinfunc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/imx53-pinfunc.h
index aec406bc65eb..59f9c29e3fe2 100644
--- a/arch/arm/boot/dts/imx53-pinfunc.h
+++ b/arch/arm/boot/dts/imx53-pinfunc.h
@@ -524,6 +524,7 @@
 #define MX53_PAD_EIM_D25__UART1_DSR				0x140 0x488 0x000 0x7 0x0
 #define MX53_PAD_EIM_D26__EMI_WEIM_D_26				0x144 0x48c 0x000 0x0 0x0
 #define MX53_PAD_EIM_D26__GPIO3_26				0x144 0x48c 0x000 0x1 0x0
+#define MX53_PAD_EIM_D26__UART2_RXD_MUX				0x144 0x48c 0x880 0x2 0x0
 #define MX53_PAD_EIM_D26__UART2_TXD_MUX				0x144 0x48c 0x000 0x2 0x0
 #define MX53_PAD_EIM_D26__FIRI_RXD				0x144 0x48c 0x80c 0x3 0x0
 #define MX53_PAD_EIM_D26__IPU_CSI0_D_1				0x144 0x48c 0x000 0x4 0x0
@@ -533,6 +534,7 @@
 #define MX53_PAD_EIM_D27__EMI_WEIM_D_27				0x148 0x490 0x000 0x0 0x0
 #define MX53_PAD_EIM_D27__GPIO3_27				0x148 0x490 0x000 0x1 0x0
 #define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x1
+#define MX53_PAD_EIM_D27__UART2_TXD_MUX				0x148 0x490 0x000 0x2 0x0
 #define MX53_PAD_EIM_D27__FIRI_TXD				0x148 0x490 0x000 0x3 0x0
 #define MX53_PAD_EIM_D27__IPU_CSI0_D_0				0x148 0x490 0x000 0x4 0x0
 #define MX53_PAD_EIM_D27__IPU_DI1_PIN13				0x148 0x490 0x000 0x5 0x0
@@ -541,6 +543,7 @@
 #define MX53_PAD_EIM_D28__EMI_WEIM_D_28				0x14c 0x494 0x000 0x0 0x0
 #define MX53_PAD_EIM_D28__GPIO3_28				0x14c 0x494 0x000 0x1 0x0
 #define MX53_PAD_EIM_D28__UART2_CTS				0x14c 0x494 0x000 0x2 0x0
+#define MX53_PAD_EIM_D28__UART2_RTS				0x14c 0x494 0x87c 0x2 0x0
 #define MX53_PAD_EIM_D28__IPU_DISPB0_SER_DIO			0x14c 0x494 0x82c 0x3 0x1
 #define MX53_PAD_EIM_D28__CSPI_MOSI				0x14c 0x494 0x788 0x4 0x1
 #define MX53_PAD_EIM_D28__I2C1_SDA				0x14c 0x494 0x818 0x5 0x1
@@ -548,6 +551,7 @@
 #define MX53_PAD_EIM_D28__IPU_DI0_PIN13				0x14c 0x494 0x000 0x7 0x0
 #define MX53_PAD_EIM_D29__EMI_WEIM_D_29				0x150 0x498 0x000 0x0 0x0
 #define MX53_PAD_EIM_D29__GPIO3_29				0x150 0x498 0x000 0x1 0x0
+#define MX53_PAD_EIM_D29__UART2_CTS				0x150 0x498 0x000 0x2 0x0
 #define MX53_PAD_EIM_D29__UART2_RTS				0x150 0x498 0x87c 0x2 0x1
 #define MX53_PAD_EIM_D29__IPU_DISPB0_SER_RS			0x150 0x498 0x000 0x3 0x0
 #define MX53_PAD_EIM_D29__CSPI_SS0				0x150 0x498 0x78c 0x4 0x2
-- 
2.11.0
