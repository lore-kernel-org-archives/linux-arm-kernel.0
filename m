From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 12 Oct 2014 22:01:55 +0200
Subject: [PATCH 3/3] ARM: dts: meson: add dts nodes for IR receiver
In-Reply-To: <1413144115-23188-1-git-send-email-b.galvani@gmail.com>
References: <1413144115-23188-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1413144115-23188-4-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/boot/dts/meson.dtsi           | 7 +++++++
 arch/arm/boot/dts/meson8-vega-s89e.dts | 6 ++++++
 arch/arm/boot/dts/meson8.dtsi          | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 7d27f12..a14461c 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -108,5 +108,12 @@
 			clocks = <&clk81>;
 			status = "disabled";
 		};
+
+		ir_receiver: ir-receiver at c8100480 {
+			compatible= "amlogic,meson6-ir";
+			reg = <0xc8100480 0x20>;
+			interrupts = <0 15 1>;
+			status = "disabled";
+		};
 	};
 }; /* end of / */
diff --git a/arch/arm/boot/dts/meson8-vega-s89e.dts b/arch/arm/boot/dts/meson8-vega-s89e.dts
index 70a05c1..5ea54c8 100644
--- a/arch/arm/boot/dts/meson8-vega-s89e.dts
+++ b/arch/arm/boot/dts/meson8-vega-s89e.dts
@@ -77,3 +77,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart_ao_a>;
 };
+
+&ir_receiver {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins>;
+};
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 59c3af0..ea98ed3 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -122,6 +122,13 @@
 				function = "uart_ao";
 			};
 		};
+
+		ir_pins: ir_pins {
+			ir_pins {
+				pins = "remote_input";
+				function = "remote";
+			};
+		};
 	};
 
 }; /* end of / */
-- 
1.9.1
