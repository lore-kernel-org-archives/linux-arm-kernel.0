From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Nov 2013 14:22:36 +0000
Subject: [PATCH 10/10] ARM: STi: Add support for the FSM Serial Flash
 Controller
In-Reply-To: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
References: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1384438956-31153-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the necessary device nodes required for successful device
probing and Pinctrl setup for the FSM.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-b2105.dts    | 10 ++++++++++
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-b2105.dts b/arch/arm/boot/dts/stih416-b2105.dts
index f14eec3..29b09ab 100644
--- a/arch/arm/boot/dts/stih416-b2105.dts
+++ b/arch/arm/boot/dts/stih416-b2105.dts
@@ -32,6 +32,16 @@
 			status = "okay";
 		};
 
+		/* FSM */
+		spifsm: spifsm at fe902000{
+		        compatible      = "st,spi-fsm", "simple-bus";
+		        reg             =  <0xfe902000 0x1000>;
+		        reg-names       = "spi-fsm";
+		        pinctrl-0       = <&pinctrl_fsm>;
+
+		        status = "okay";
+		};
+
 		leds {
 			compatible	= "gpio-leds";
 			fp_led {
diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index eb426a1..3106ea2 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -235,6 +235,18 @@
 				};
 			};
 
+			fsm {
+				pinctrl_fsm: fsm {
+					st,pins {
+						spi-fsm-clk     = <&PIO12 2     OUT     ALT1>;
+						spi-fsm-cs      = <&PIO12 3     OUT     ALT1>;
+						spi-fsm-mosi    = <&PIO12 4     OUT     ALT1>;
+						spi-fsm-miso    = <&PIO12 5     IN      ALT1>;
+						spi-fsm-hol     = <&PIO12 6     OUT     ALT1>;
+						spi-fsm-wp      = <&PIO12 7     OUT     ALT1>;
+					};
+				};
+			};
 		};
 
 		pin-controller-rear {
-- 
1.8.1.2
