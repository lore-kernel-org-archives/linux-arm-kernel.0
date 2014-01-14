From: srinivas.kandagatla@st.com (srinivas.kandagatla at st.com)
Date: Tue, 14 Jan 2014 14:52:33 +0000
Subject: [PATCH v1 5/5] ARM:STi: STiH415: Add interrupt support for pin
 controller
In-Reply-To: <1389711077-20949-1-git-send-email-srinivas.kandagatla@st.com>
References: <1389711077-20949-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1389711153-21171-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch adds interrupt support for STiH415 pin controllers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/boot/dts/stih415-pinctrl.dtsi |   75 ++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts/stih415-pinctrl.dtsi
index a9324fa..21b3b53 100644
--- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -7,6 +7,7 @@
  * publishhed by the Free Software Foundation.
  */
 #include "st-pincfg.h"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
 
 	aliases {
@@ -45,35 +46,49 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih415-sbc-pinctrl";
 			st,syscfg	= <&syscfg_sbc>;
+			reg 		= <0xfe61f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges 		= <0 0xfe610000 0x5000>;
 
 			PIO0: gpio at fe610000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
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
@@ -169,53 +184,73 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih415-front-pinctrl";
 			st,syscfg	= <&syscfg_front>;
+			reg 		= <0xfee0f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges		= <0 0xfee00000 0x8000>;
 
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
@@ -244,41 +279,57 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih415-rear-pinctrl";
 			st,syscfg	= <&syscfg_rear>;
+			reg 		= <0xfe82f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges		= <0 0xfe820000 0x8000>;
 
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
 			};
@@ -329,23 +380,33 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih415-left-pinctrl";
 			st,syscfg	= <&syscfg_left>;
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
@@ -356,35 +417,49 @@
 			#size-cells	= <1>;
 			compatible	= "st,stih415-right-pinctrl";
 			st,syscfg	= <&syscfg_right>;
+			reg 		= <0xfd33f080 0x4>;
+			reg-names	= "irqmux";
+			interrupts 	= <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-names = "irqmux";
 			ranges		= <0 0xfd330000 0x5000>;
 
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
 			PIO107: gpio at fd334000 {
 				gpio-controller;
 				#gpio-cells	= <1>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg		= <0x4000 0x100>;
 				st,bank-name	= "PIO107";
 			};
-- 
1.7.6.5
