From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Jun 2017 18:18:03 +0200
Subject: [PATCH v3 5/6] ARM: dts: meson8b: enable gpio interrupt controller
In-Reply-To: <20170615161804.32658-1-jbrunet@baylibre.com>
References: <20170615161804.32658-1-jbrunet@baylibre.com>
Message-ID: <20170615161804.32658-6-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio interrupt controller node to the meson8b boards

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/boot/dts/meson.dtsi   | 9 +++++++++
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 8d9c36970dfd..351783e72fab 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -78,6 +78,15 @@
 			#size-cells = <1>;
 			ranges = <0x0 0xc1100000 0x200000>;
 
+			gpio_intc: interrupt-controller at 9880 {
+				compatible = "amlogic,meson-gpio-intc";
+				reg = <0xc1109880 0x10>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,upstream-interrupts = <64 65 66 67 68 69 70 71>;
+				status = "disabled";
+			};
+
 			uart_A: serial at 84c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x84c0 0x18>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index d9f116a418b2..cbb85de864b6 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -171,6 +171,12 @@
 	};
 };
 
+&gpio_intc {
+	compatible = "amlogic,meson-gpio-intc",
+		     "amlogic,meson8b-gpio-intc";
+	status = "okay";
+};
+
 &L2 {
 	arm,data-latency = <3 3 3>;
 	arm,tag-latency = <2 2 2>;
-- 
2.9.4
