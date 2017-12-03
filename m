From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  3 Dec 2017 16:04:57 +0100
Subject: [PATCH v2] ARM: dts: Add ethernet PHYs to the a bunch of Geminis
Message-ID: <20171203150457.21774-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These Gemini boards have Ethernet PHY on GPIO bit-banged
MDIO, clearly defined in the corresponding OpenWRT
ethernet patches since ages. Add them in accordance with
the OpenWRT patch so we can use them when we add ethernet
support.

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix the unit names on all PHYs to correspond to the
  actual reg.
---
 arch/arm/boot/dts/gemini-nas4220b.dts | 13 +++++++++++++
 arch/arm/boot/dts/gemini-rut1xx.dts   | 13 +++++++++++++
 arch/arm/boot/dts/gemini-wbd111.dts   | 13 +++++++++++++
 arch/arm/boot/dts/gemini-wbd222.dts   | 18 ++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index d6a22e677c7a..943d2d07fac7 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -64,6 +64,19 @@
 		};
 	};
 
+	mdio0: ethernet-phy {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
+			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy at 1 {
+			reg = <1>;
+			device_type = "ethernet-phy";
+		};
+	};
+
 	soc {
 		flash at 30000000 {
 			status = "okay";
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index 500057b6570e..fd55528bba56 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -58,6 +58,19 @@
 		};
 	};
 
+	mdio0: ethernet-phy {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
+			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy at 1 {
+			reg = <1>;
+			device_type = "ethernet-phy";
+		};
+	};
+
 	soc {
 		flash at 30000000 {
 			status = "okay";
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index b413fd12c5ba..f36e1b65497d 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -69,6 +69,19 @@
 		};
 	};
 
+	mdio0: ethernet-phy {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
+			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy at 1 {
+			reg = <1>;
+			device_type = "ethernet-phy";
+		};
+	};
+
 	soc {
 		flash at 30000000 {
 			status = "okay";
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index 3ba710538662..669bd8b5f92f 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -69,6 +69,24 @@
 		};
 	};
 
+	mdio0: ethernet-phy {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
+			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy at 1 {
+			reg = <1>;
+			device_type = "ethernet-phy";
+		};
+
+		phy1: ethernet-phy at 3 {
+			reg = <3>;
+			device_type = "ethernet-phy";
+		};
+	};
+
 	soc {
 		flash at 30000000 {
 			status = "okay";
-- 
2.14.3
