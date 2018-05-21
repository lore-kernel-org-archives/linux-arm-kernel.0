From: daniel@zonque.org (Daniel Mack)
Date: Tue, 22 May 2018 00:00:44 +0200
Subject: [PATCH 2/2] ARM: pxa: dts: add pin definitions for extended GPIOs
In-Reply-To: <20180521220044.821-1-daniel@zonque.org>
References: <20180521220044.821-1-daniel@zonque.org>
Message-ID: <20180521220044.821-2-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA3xx series features some extended GPIO banks which are named GPIO0_2,
GPIO1_2 etc. The PXA300, PXA310 and PXA320 have different numbers of such
pins, and they also have variant-specific register offsets.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index a13ac52e4fd2..446e612688c0 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -8,6 +8,13 @@
 	 (gpio <= 98) ? (0x0400 + 4 * (gpio - 27)) :	\
 	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
 	 0)
+#define MFP_PIN_PXA300_0_2	0x674
+#define MFP_PIN_PXA300_1_2	0x678
+#define MFP_PIN_PXA300_2_2	0x2dc
+#define MFP_PIN_PXA300_3_2	0x2e0
+#define MFP_PIN_PXA300_4_2	0x2e4
+#define MFP_PIN_PXA300_5_2	0x2e8
+#define MFP_PIN_PXA300_6_2	0x2ec
 
 #define MFP_PIN_PXA310(gpio)				\
 	((gpio <= 2) ? (0x00b4 + 4 * gpio) :		\
@@ -18,6 +25,17 @@
 	 (gpio <= 262) ? 0 :				\
 	 (gpio <= 268) ? (0x052c + 4 * (gpio - 263)) :	\
 	 0)
+#define MFP_PIN_PXA310_0_2	0x674
+#define MFP_PIN_PXA310_1_2	0x678
+#define MFP_PIN_PXA310_2_2	0x2dc
+#define MFP_PIN_PXA310_3_2	0x2e0
+#define MFP_PIN_PXA310_4_2	0x2e4
+#define MFP_PIN_PXA310_5_2	0x2e8
+#define MFP_PIN_PXA310_6_2	0x2ec
+#define MFP_PIN_PXA310_7_2	0x52c
+#define MFP_PIN_PXA310_8_2	0x530
+#define MFP_PIN_PXA310_9_2	0x534
+#define MFP_PIN_PXA310_10_2	0x538
 
 #define MFP_PIN_PXA320(gpio)				\
 	((gpio <= 4) ? (0x0124 + 4 * gpio) :		\
@@ -30,6 +48,12 @@
 	 (gpio <= 98) ? (0x04f0 + 4 * (gpio - 74)) :	\
 	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
 	 0)
+#define MFP_PIN_PXA320_0_2	0x674
+#define MFP_PIN_PXA320_1_2	0x678
+#define MFP_PIN_PXA320_2_2	0x67c
+#define MFP_PIN_PXA320_3_2	0x680
+#define MFP_PIN_PXA320_4_2	0x284
+#define MFP_PIN_PXA320_5_2	0x28c
 
 /*
  * MFP Alternate functions for pins having a gpio.
-- 
2.14.3
