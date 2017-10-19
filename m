From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 19 Oct 2017 14:01:41 +0200
Subject: [PATCH 3/5] ARM: dts: meson8b: enable gpio interrupt controller
In-Reply-To: <20171019120143.20581-1-jbrunet@baylibre.com>
References: <20171019120143.20581-1-jbrunet@baylibre.com>
Message-ID: <20171019120143.20581-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio interrupt controller node to the meson8b boards

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/boot/dts/meson.dtsi   | 9 +++++++++
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 290a183e87c5..3d18ecc2bef1 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -85,6 +85,15 @@
 				reg = <0x7c00 0x200>;
 			};
 
+			gpio_intc: interrupt-controller at 9880 {
+				compatible = "amlogic,meson-gpio-intc";
+				reg = <0xc1109880 0x10>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
+				status = "disabled";
+			};
+
 			hwrng: rng at 8100 {
 				compatible = "amlogic,meson-rng";
 				reg = <0x8100 0x8>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 40cfe5c8df6a..574aafa3db83 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -179,6 +179,12 @@
 	clock-names = "stmmaceth";
 };
 
+&gpio_intc {
+	compatible = "amlogic,meson-gpio-intc",
+		     "amlogic,meson8b-gpio-intc";
+	status = "okay";
+};
+
 &hwrng {
 	compatible = "amlogic,meson8b-rng", "amlogic,meson-rng";
 	clocks = <&clkc CLKID_RNG0>;
-- 
2.13.6
