From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 10:07:14 +0200
Subject: [PATCHv4 5/9] ARM: sunxi: dt: Add i2c controller nodes to the DTSI
In-Reply-To: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371024438-16631-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 and A13 both have 3 i2c controller embedded.
Add those to the common sunxi dtsi.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi | 27 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 04ff62a..f7e4a96 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -321,5 +321,32 @@
 			clocks = <&apb1_gates 23>;
 			status = "disabled";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <7>;
+			clocks = <&apb1_gates 0>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <8>;
+			clocks = <&apb1_gates 1>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <9>;
+			clocks = <&apb1_gates 2>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index f34db19..31ebfd7 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -217,5 +217,32 @@
 			clocks = <&apb1_gates 19>;
 			status = "disabled";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <7>;
+			clocks = <&apb1_gates 0>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <8>;
+			clocks = <&apb1_gates 1>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <9>;
+			clocks = <&apb1_gates 2>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.8.3
