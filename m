From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 12 Feb 2016 11:14:25 +0000
Subject: [PATCH] ARM: bcm2835: add bcm2835-aux-uart support to DT
Message-ID: <1455275666-15806-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add bcm2835-aux-uart support to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm283x.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 05ff5ce..8aaf193 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -160,6 +160,14 @@
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
 		};
 
+		uart1: serial at 7e215040 {
+			compatible = "brcm,bcm2835-aux-uart";
+			reg = <0x7e215040 0x40>;
+			interrupts = <1 29>;
+			clocks = <&aux BCM2835_AUX_CLOCK_UART>;
+			status = "disabled";
+		};
+
 		spi1: spi at 7e215080 {
 			compatible = "brcm,bcm2835-aux-spi";
 			reg = <0x7e215080 0x40>;
-- 
1.7.10.4
