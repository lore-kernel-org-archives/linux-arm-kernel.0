From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 20:35:42 -0700
Subject: [PATCH] ARM: bcm2835: add missing #xxx-cells to I2C nodes
Message-ID: <1385436942-6283-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C controller node needs #address-cells and #size-cells properties,
but these are currently missing. Add them. This allows child nodes to be
parsed correctly.

Cc: stable at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
This is a patch for 3.13-rc.

 arch/arm/boot/dts/bcm2835.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 1e12aef..aa537ed 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -85,6 +85,8 @@
 			reg = <0x7e205000 0x1000>;
 			interrupts = <2 21>;
 			clocks = <&clk_i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
@@ -93,6 +95,8 @@
 			reg = <0x7e804000 0x1000>;
 			interrupts = <2 21>;
 			clocks = <&clk_i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
1.7.10.4
