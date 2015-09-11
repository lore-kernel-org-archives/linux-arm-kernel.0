From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 11 Sep 2015 11:22:05 +0000
Subject: [PATCH v6 3/4] spi: bcm2835: add the auxiliary spi1 and spi2 to the
 device tree
In-Reply-To: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441970527-2403-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This enables the use of the auxiliary spi1 and spi2 devices
on the bcm2835 SOC.

Note that this requires the use of the new clk-bcm2835-aux to work.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 7c37956..3f5a7f1 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
 #include <dt-bindings/clock/bcm2835.h>
+#include <dt-bindings/clock/bcm2835-aux.h>
 #include "skeleton.dtsi"

 / {
@@ -183,6 +184,26 @@
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
+
+		spi1: spi at 7e215080 {
+			compatible = "brcm,bcm2835-aux-spi";
+			reg = <0x7e215080 0x40>;
+			interrupts = <1 29>;
+			clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi at 7e2150c0 {
+			compatible = "brcm,bcm2835-aux-spi";
+			reg = <0x7e2150c0 0x40>;
+			interrupts = <1 29>;
+			clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};

 	clocks {
--
1.7.10.4
