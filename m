From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 19 Oct 2016 12:08:28 +0200
Subject: [PATCH 8/9] ARM64: dts: amlogic: enable gpio interrupt controller on
 gxbb
In-Reply-To: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1476871709-8359-9-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index aad639ab0112..5208cb80b55e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -141,6 +141,13 @@
 		#reset-cells = <1>;
 	};
 
+	gpio_interrupt: interrupt-controller at 9880 {
+		compatible = "amlogic,meson-gxbb-gpio-intc";
+		reg = <0x0 0x9880 0x0 0x10>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	uart_B: serial at 84dc {
 		compatible = "amlogic,meson-uart";
 		reg = <0x0 0x84dc 0x0 0x14>;
@@ -238,6 +245,7 @@
 			reg-names = "mux", "pull", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-parent = <&gpio_interrupt>;
 		};
 
 		uart_ao_a_pins: uart_ao_a {
@@ -343,6 +351,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-parent = <&gpio_interrupt>;
 		};
 
 		emmc_pins: emmc {
-- 
2.7.4
