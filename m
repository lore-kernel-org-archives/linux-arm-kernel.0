From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 10 Sep 2012 15:16:36 +0200
Subject: [PATCH 1/1] ARM: dts: OMAP3: Add gpio-twl4030 properties for Overo
In-Reply-To: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch>
References: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1347282996-31190-2-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the blue LED connected to the LEDB pin of the TWL4030
on the Gumstix Overo.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index d6cc5e2..89808ce 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -13,6 +13,17 @@
 
 /include/ "omap3.dtsi"
 
+/ {
+	leds {
+		compatible = "gpio-leds";
+		overo {
+			label = "overo:blue:COM";
+			gpios = <&twl_gpio 19 0>;
+			linux,default-trigger = "mmc0";
+		};
+	};
+};
+
 &i2c1 {
 	clock-frequency = <2600000>;
 
@@ -40,3 +51,7 @@
 &mmc2 {
 	bus-width = <4>;
 };
+
+&twl_gpio {
+	ti,use-leds;
+};
-- 
1.7.5.4
