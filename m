From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:26 +0200
Subject: [RFC 08/10] ARM64: dts: amlogic: enable gpio interrupt controller on
 gxbb
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-9-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 610e0e1c3cee..e5c6372dbe1c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -183,6 +183,21 @@
 				#reset-cells = <1>;
 			};
 
+			gpio_interrupt: interrupt-controller at 9880 {
+				compatible = "amlogic,gxbb-gpio-intc";
+				reg = <0x0 0x9880 0x0 0x10>;
+				interrupts = <GIC_SPI 64 IRQ_TYPE_NONE>,
+					   <GIC_SPI 65 IRQ_TYPE_NONE>,
+					   <GIC_SPI 66 IRQ_TYPE_NONE>,
+					   <GIC_SPI 67 IRQ_TYPE_NONE>,
+					   <GIC_SPI 68 IRQ_TYPE_NONE>,
+					   <GIC_SPI 69 IRQ_TYPE_NONE>,
+					   <GIC_SPI 70 IRQ_TYPE_NONE>,
+					   <GIC_SPI 71 IRQ_TYPE_NONE>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
 			uart_A: serial at 84c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x84c0 0x0 0x14>;
@@ -307,6 +322,7 @@
 					reg-names = "mux", "pull", "gpio";
 					gpio-controller;
 					#gpio-cells = <2>;
+					interrupt-parent = <&gpio_interrupt>;
 				};
 
 				uart_ao_a_pins: uart_ao_a {
@@ -426,6 +442,7 @@
 					reg-names = "mux", "pull", "pull-enable", "gpio";
 					gpio-controller;
 					#gpio-cells = <2>;
+					interrupt-parent = <&gpio_interrupt>;
 				};
 
 				emmc_pins: emmc {
-- 
2.7.4
