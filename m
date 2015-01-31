From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jan 2015 23:48:26 +0100
Subject: [PATCH 1/5] ARM: dts: pxa: add pwri2c to pxa device-tree
Message-ID: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa variant has 2 I2C busses on the SoC :
 - the casual I2C
 - the power I2C, normally driving power regulators, and capable of
 receiving orders on core frequency modifications

Add the missing pwri2c to pxa description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index c08f846..2371d9b 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -103,6 +103,15 @@
 			status = "disabled";
 		};
 
+		pwri2c: i2c at 40f000180 {
+			compatible = "mrvl,pxa-i2c";
+			reg = <0x40f00180 0x24>;
+			interrupts = <6>;
+			#address-cells = <0x1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pxai2c1: i2c at 40301680 {
 			compatible = "mrvl,pxa-i2c";
 			reg = <0x40301680 0x30>;
-- 
2.1.0
