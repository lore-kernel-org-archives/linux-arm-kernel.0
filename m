From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  4 Jan 2013 17:45:09 +0100
Subject: [PATCH 2/2] ARM: sunxi: Add the GPIOs node to the device tree
In-Reply-To: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1357317909-12458-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi |   51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index e112189..dc650a6 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -14,6 +14,15 @@
 /include/ "sunxi.dtsi"
 
 / {
+	aliases {
+		gpio1 = &pb;
+		gpio2 = &pc;
+		gpio3 = &pd;
+		gpio4 = &pe;
+		gpio5 = &pf;
+		gpio6 = &pg;
+	};
+
 	memory {
 		reg = <0x40000000 0x20000000>;
 	};
@@ -39,5 +48,47 @@
 				allwinner,pull = <0>;
 			};
 		};
+
+		pb: gpio at 01c20824 {
+			compatible = "allwinner,sunxi-gpio";
+			reg = <0x01c20824 0x24>;
+			gpio-controller;
+			#gpio-cells = <1>;
+		};
+
+		pc: gpio at 01c20848 {
+			compatible = "allwinner,sunxi-gpio";
+			reg = <0x01c20848 0x24>;
+			gpio-controller;
+			#gpio-cells = <1>;
+		};
+
+		pd: gpio at 01c2086c {
+			compatible = "allwinner,sunxi-gpio";
+			reg = <0x01c2086c 0x24>;
+			gpio-controller;
+			#gpio-cells = <1>;
+		};
+
+		pe: gpio at 01c20890 {
+			compatible = "allwinner,sunxi-gpio";
+			reg = <0x01c20890 0x24>;
+			gpio-controller;
+			#gpio-cells = <1>;
+		};
+
+		pf: gpio at 01c208b4 {
+			compatible = "allwinner,sunxi-gpio";
+			reg = <0x01c208b4 0x24>;
+			gpio-controller;
+			#gpio-cells = <1>;
+		};
+
+		pg: gpio at 01c208d8 {
+			compatible = "allwinner,sunxi-gpio";
+			reg = <0x01c208d8 0x24>;
+			gpio-controller;
+			#gpio-cells = <1>;
+		};
 	};
 };
-- 
1.7.10.4
