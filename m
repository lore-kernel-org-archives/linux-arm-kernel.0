From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 May 2013 12:00:39 +0200
Subject: [PATCHv3 2/6] ARM: sunxi: dt: Add i2c controller nodes to the DTSI
In-Reply-To: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1369648843-1640-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 and A13 both have 3 i2c controller embedded.
Add those to the common sunxi dtsi.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi | 27 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e7ef619..311dcd4 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -292,5 +292,32 @@
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
index 8ba65c1..16df784 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -215,5 +215,32 @@
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
1.8.2.3
