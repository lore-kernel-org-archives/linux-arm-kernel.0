From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 22 Feb 2014 16:53:42 +0100
Subject: [PATCH v7 13/15] ARM: sun4i: dt: Remove grouping + simple-bus
 compatible for regulators
In-Reply-To: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393084424-31099-14-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/regulator/regulator.txt
regulator nodes should not be placed under 'simple-bus'.

Mark Rutland also explains about it at:
http://www.spinics.net/lists/linux-usb/msg101497.html

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts     | 22 +++++++++-------------
 arch/arm/boot/dts/sun4i-a10-hackberry.dts | 18 +++++++-----------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index d4b081d..cbd2e13 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -80,18 +80,14 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		reg_emac_3v3: emac-3v3 {
-			compatible = "regulator-fixed";
-			pinctrl-names = "default";
-			pinctrl-0 = <&emac_power_pin_a1000>;
-			regulator-name = "emac-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			enable-active-high;
-			gpio = <&pio 7 15 0>;
-		};
+	reg_emac_3v3: emac-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&emac_power_pin_a1000>;
+		regulator-name = "emac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 7 15 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 3a1595f..6692d336 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -54,16 +54,12 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		reg_emac_3v3: emac-3v3 {
-			compatible = "regulator-fixed";
-			regulator-name = "emac-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			enable-active-high;
-			gpio = <&pio 7 19 0>;
-		};
+	reg_emac_3v3: emac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "emac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 7 19 0>;
 	};
 };
-- 
1.9.0
