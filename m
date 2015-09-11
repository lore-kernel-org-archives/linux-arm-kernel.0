From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 11 Sep 2015 12:20:52 +0000
Subject: [PATCH 3/4] serial: bcm2835: add auxiliary uart1 to device tree of
 bcm2835
In-Reply-To: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
References: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441974053-2630-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the auxiliary uart1 device to the device tree of the bcm2835 SOC.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3f5a7f1..d68e30c 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -185,6 +185,17 @@
 			compatible = "arm,arm1176-pmu";
 		};
 
+		uart1: uart at 7e215040 {
+			compatible = "ns16550";
+			reg = <0x7e215040 0x40>;
+			reg-shift = <2>;
+			interrupts = <1 29>;
+			no-loopback-test;
+			status = "disabled";
+			clock-divider = <8>;
+			clocks = <&aux_clocks BCM2835_AUX_CLOCK_UART>;
+		};
+
 		spi1: spi at 7e215080 {
 			compatible = "brcm,bcm2835-aux-spi";
 			reg = <0x7e215080 0x40>;
-- 
1.7.10.4
