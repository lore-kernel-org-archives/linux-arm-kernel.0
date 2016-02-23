From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:14:07 +0000
Subject: [PATCH 02/12] ARM: dts: apq8064: move pinctrls to dedicated dtsi
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236847-2445-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there are more pinctrls to come, moving these to dedicated dtsi makes
more sense.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 58 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      | 57 +------------------------------
 2 files changed, 59 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-pins.dtsi

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
new file mode 100644
index 0000000..c711aca
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -0,0 +1,58 @@
+
+&tlmm_pinmux {
+	sdc4_gpios: sdc4-gpios {
+		pios {
+			pins = "gpio63", "gpio64", "gpio65", "gpio66", "gpio67", "gpio68";
+			function = "sdc4";
+		};
+	};
+
+	ps_hold: ps_hold {
+		mux {
+			pins = "gpio78";
+			function = "ps_hold";
+		};
+	};
+
+	i2c1_pins: i2c1 {
+		mux {
+			pins = "gpio20", "gpio21";
+			function = "gsbi1";
+		};
+	};
+
+	i2c3_pins: i2c3 {
+		mux {
+			pins = "gpio8", "gpio9";
+			function = "gsbi3";
+		};
+	};
+
+	gsbi6_uart_2pins: gsbi6_uart_2pins {
+		mux {
+			pins = "gpio14", "gpio15";
+			function = "gsbi6";
+		};
+	};
+
+	gsbi6_uart_4pins: gsbi6_uart_4pins {
+		mux {
+			pins = "gpio14", "gpio15", "gpio16", "gpio17";
+			function = "gsbi6";
+		};
+	};
+
+	gsbi7_uart_2pins: gsbi7_uart_2pins {
+		mux {
+			pins = "gpio82", "gpio83";
+			function = "gsbi7";
+		};
+	};
+
+	gsbi7_uart_4pins: gsbi7_uart_4pins {
+		mux {
+			pins = "gpio82", "gpio83", "gpio84", "gpio85";
+			function = "gsbi7";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a7af35d..3d95534b 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -142,62 +142,6 @@
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&ps_hold>;
-
-			sdc4_gpios: sdc4-gpios {
-				pios {
-					pins = "gpio63", "gpio64", "gpio65", "gpio66", "gpio67", "gpio68";
-					function = "sdc4";
-				};
-			};
-
-			ps_hold: ps_hold {
-				mux {
-					pins = "gpio78";
-					function = "ps_hold";
-				};
-			};
-
-			i2c1_pins: i2c1 {
-				mux {
-					pins = "gpio20", "gpio21";
-					function = "gsbi1";
-				};
-			};
-
-			i2c3_pins: i2c3 {
-				mux {
-					pins = "gpio8", "gpio9";
-					function = "gsbi3";
-				};
-			};
-
-			gsbi6_uart_2pins: gsbi6_uart_2pins {
-				mux {
-					pins = "gpio14", "gpio15";
-					function = "gsbi6";
-				};
-			};
-
-			gsbi6_uart_4pins: gsbi6_uart_4pins {
-				mux {
-					pins = "gpio14", "gpio15", "gpio16", "gpio17";
-					function = "gsbi6";
-				};
-			};
-
-			gsbi7_uart_2pins: gsbi7_uart_2pins {
-				mux {
-					pins = "gpio82", "gpio83";
-					function = "gsbi7";
-				};
-			};
-
-			gsbi7_uart_4pins: gsbi7_uart_4pins {
-				mux {
-					pins = "gpio82", "gpio83", "gpio84", "gpio85";
-					function = "gsbi7";
-				};
-			};
 		};
 
 		sfpb_wrapper_mutex: syscon at 1200000 {
@@ -828,3 +772,4 @@
 		};
 	};
 };
+#include "qcom-apq8064-pins.dtsi"
-- 
1.9.1
