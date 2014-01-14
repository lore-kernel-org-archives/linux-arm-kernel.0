From: srinivas.kandagatla@st.com (srinivas.kandagatla at st.com)
Date: Tue, 14 Jan 2014 14:52:27 +0000
Subject: [PATCH v1 4/5] ARM:STi: STiH416: Add interrupt support for pin
 controller
In-Reply-To: <1389711077-20949-1-git-send-email-srinivas.kandagatla@st.com>
References: <1389711077-20949-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1389711147-21130-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch adds interrupt support for STiH416 pin controllers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi |   81 ++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index 74f8cfc..3adbd98 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -8,6 +8,7 @@
  * publishhed by the Free Software Foundation.
  */
 #include "st-pincfg.h"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
 
 	aliases {
@@ -49,41 +50,57 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih416-sbc-pinctrl";
 			st,syscfg	= <&syscfg_sbc>;
+			reg 		= <0xfe61f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges		= <0 0xfe610000 0x6000>;
 
 			PIO0: gpio at fe610000 {
 				gpio-controller;
 				#gpio-cells = <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0 0x100>;
 				st,bank-name	= "PIO0";
 			};
 			PIO1: gpio at fe611000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x1000 0x100>;
 				st,bank-name	= "PIO1";
 			};
 			PIO2: gpio at fe612000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x2000 0x100>;
 				st,bank-name	= "PIO2";
 			};
 			PIO3: gpio at fe613000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x3000 0x100>;
 				st,bank-name	= "PIO3";
 			};
 			PIO4: gpio at fe614000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x4000 0x100>;
 				st,bank-name	= "PIO4";
 			};
 			PIO40: gpio at fe615000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x5000 0x100>;
 				st,bank-name	= "PIO40";
 				st,retime-pin-mask = <0x7f>;
@@ -181,65 +198,89 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih416-front-pinctrl";
 			st,syscfg	= <&syscfg_front>;
+			reg 		= <0xfee0f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges		= <0 0xfee00000 0x10000>;
 
 			PIO5: gpio at fee00000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0 0x100>;
 				st,bank-name	= "PIO5";
 			};
 			PIO6: gpio at fee01000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x1000 0x100>;
 				st,bank-name	= "PIO6";
 			};
 			PIO7: gpio at fee02000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x2000 0x100>;
 				st,bank-name	= "PIO7";
 			};
 			PIO8: gpio at fee03000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x3000 0x100>;
 				st,bank-name	= "PIO8";
 			};
 			PIO9: gpio at fee04000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x4000 0x100>;
 				st,bank-name	= "PIO9";
 			};
 			PIO10: gpio at fee05000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x5000 0x100>;
 				st,bank-name	= "PIO10";
 			};
 			PIO11: gpio at fee06000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x6000 0x100>;
 				st,bank-name	= "PIO11";
 			};
 			PIO12: gpio at fee07000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x7000 0x100>;
 				st,bank-name	= "PIO12";
 			};
 			PIO30: gpio at fee08000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x8000 0x100>;
 				st,bank-name	= "PIO30";
 			};
 			PIO31: gpio at fee09000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x9000 0x100>;
 				st,bank-name	= "PIO31";
 			};
@@ -276,41 +317,57 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih416-rear-pinctrl";
 			st,syscfg	= <&syscfg_rear>;
+			reg 		= <0xfe82f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges 		= <0 0xfe820000 0x6000>;
 
 			PIO13: gpio at fe820000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0 0x100>;
 				st,bank-name	= "PIO13";
 			};
 			PIO14: gpio at fe821000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x1000 0x100>;
 				st,bank-name	= "PIO14";
 			};
 			PIO15: gpio at fe822000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x2000 0x100>;
 				st,bank-name	= "PIO15";
 			};
 			PIO16: gpio at fe823000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x3000 0x100>;
 				st,bank-name	= "PIO16";
 			};
 			PIO17: gpio at fe824000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x4000 0x100>;
 				st,bank-name	= "PIO17";
 			};
 			PIO18: gpio at fe825000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x5000 0x100>;
 				st,bank-name	= "PIO18";
 				st,retime-pin-mask = <0xf>;
@@ -384,23 +441,33 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih416-fvdp-fe-pinctrl";
 			st,syscfg	= <&syscfg_fvdp_fe>;
+			reg 		= <0xfd6bf080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges		= <0 0xfd6b0000 0x3000>;
 
 			PIO100: gpio at fd6b0000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0 0x100>;
 				st,bank-name	= "PIO100";
 			};
 			PIO101: gpio at fd6b1000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x1000 0x100>;
 				st,bank-name	= "PIO101";
 			};
 			PIO102: gpio at fd6b2000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x2000 0x100>;
 				st,bank-name	= "PIO102";
 			};
@@ -411,29 +478,41 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih416-fvdp-lite-pinctrl";
 			st,syscfg		= <&syscfg_fvdp_lite>;
+			reg 		= <0xfd33f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges			= <0 0xfd330000 0x5000>;
 
 			PIO103: gpio at fd330000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0 0x100>;
 				st,bank-name	= "PIO103";
 			};
 			PIO104: gpio at fd331000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x1000 0x100>;
 				st,bank-name	= "PIO104";
 			};
 			PIO105: gpio at fd332000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x2000 0x100>;
 				st,bank-name	= "PIO105";
 			};
 			PIO106: gpio at fd333000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x3000 0x100>;
 				st,bank-name	= "PIO106";
 			};
@@ -441,6 +520,8 @@
 			PIO107: gpio at fd334000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x4000 0x100>;
 				st,bank-name	= "PIO107";
 				st,retime-pin-mask = <0xf>;
-- 
1.7.6.5
