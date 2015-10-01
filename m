From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:44 +0200
Subject: [PATCH 07/16] ARM: dts: lpc18xx: add i2c nodes
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-8-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NXP LPC1778 I2C controller nodes to the dtsi for all
lpc18xx/43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index f97feea5f5da..04bea2dc0e66 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -287,6 +287,17 @@
 			clocks = <&ccu1 CLK_CPU_SCU>;
 		};
 
+		i2c0: i2c at 400a1000 {
+			compatible = "nxp,lpc1788-i2c";
+			reg = <0x400a1000 0x1000>;
+			interrupts = <18>;
+			clocks = <&ccu1 CLK_APB1_I2C0>;
+			resets = <&rgu 48>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		can1: can at 400a4000 {
 			compatible = "bosch,c_can";
 			reg = <0x400a4000 0x1000>;
@@ -360,6 +371,17 @@
 			status = "disabled";
 		};
 
+		i2c1: i2c at 400e0000 {
+			compatible = "nxp,lpc1788-i2c";
+			reg = <0x400e0000 0x1000>;
+			interrupts = <19>;
+			clocks = <&ccu1 CLK_APB3_I2C1>;
+			resets = <&rgu 49>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		can0: can at 400e2000 {
 			compatible = "bosch,c_can";
 			reg = <0x400e2000 0x1000>;
-- 
1.8.0
