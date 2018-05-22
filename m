From: daniel@zonque.org (Daniel Mack)
Date: Tue, 22 May 2018 22:22:32 +0200
Subject: [PATCH v2] ARM: pxa: dts: add pin definitions for extended GPIOs
Message-ID: <20180522202232.7981-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA3xx series features some extended GPIO banks which are named GPIO0_2,
GPIO1_2 etc. The PXA300, PXA310 and PXA320 have different numbers of such
pins, and they also have variant-specific register offsets.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index a13ac52e4fd2..99c3687e89d3 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -8,6 +8,10 @@
 	 (gpio <= 98) ? (0x0400 + 4 * (gpio - 27)) :	\
 	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
 	 0)
+#define MFP_PIN_PXA300_2(gpio)				\
+	((gpio <= 1) ? (0x674 + 4 * gpio) :		\
+	 (gpio <= 6) ? (0x2dc + 4 * gpio) :		\
+	 0)
 
 #define MFP_PIN_PXA310(gpio)				\
 	((gpio <= 2) ? (0x00b4 + 4 * gpio) :		\
@@ -18,6 +22,11 @@
 	 (gpio <= 262) ? 0 :				\
 	 (gpio <= 268) ? (0x052c + 4 * (gpio - 263)) :	\
 	 0)
+#define MFP_PIN_PXA310_2(gpio)				\
+	((gpio <= 1) ? (0x674 + 4 * gpio) :		\
+	 (gpio <= 6) ? (0x2dc + 4 * gpio) :		\
+	 (gpio <= 10) ? (0x52c + 4 * gpio) :		\
+	 0)
 
 #define MFP_PIN_PXA320(gpio)				\
 	((gpio <= 4) ? (0x0124 + 4 * gpio) :		\
@@ -30,6 +39,10 @@
 	 (gpio <= 98) ? (0x04f0 + 4 * (gpio - 74)) :	\
 	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
 	 0)
+#define MFP_PIN_PXA320_2(gpio)				\
+	((gpio <= 3) ? (0x674 + 4 * gpio) :		\
+	 (gpio <= 5) ? (0x284 + 4 * gpio) :		\
+	 0)
 
 /*
  * MFP Alternate functions for pins having a gpio.
-- 
2.14.3
