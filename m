From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Jun 2013 15:01:58 -0700
Subject: ARM: dts: Add missing vmmc2 regulator for twl
Message-ID: <20130607220157.GM3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason vmmc2 regulator is missing for twl.
Let's add it.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -47,6 +47,12 @@
 		regulator-max-microvolt = <3150000>;
 	};
 
+	vmmc2: regulator-vmmc2 {
+		compatible = "ti,twl4030-vmmc2";
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <3150000>;
+	};
+
 	vusb1v5: regulator-vusb1v5 {
 		compatible = "ti,twl4030-vusb1v5";
 	};
