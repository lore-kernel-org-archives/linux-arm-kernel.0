From: songjun.wu@atmel.com (Songjun Wu)
Date: Tue, 22 Dec 2015 17:26:05 +0800
Subject: [PATCH 2/2] ARM: at91/dt: sama5d2 Xplained: add pdmic node
In-Reply-To: <1450776365-6373-1-git-send-email-songjun.wu@atmel.com>
References: <1450776365-6373-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <1450776365-6373-2-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pdmic node on sama5d2-xplained board.The pdmic
pins conflict with ISC_D0 & ISC_D1 data pins.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index c2fcc29..77ddff0 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -119,6 +119,16 @@
 				status = "okay";
 			};
 
+			pdmic at f8018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pdmic_default>;
+				atmel,model = "PDMIC @ sama5d2_xplained";
+				atmel,mic-min-freq = <1000000>;
+				atmel,mic-max-freq = <3246000>;
+				atmel,mic-offset = <0x0>;
+				status = "okay";
+			};
+
 			uart1: serial at f8020000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1_default>;
@@ -290,6 +300,12 @@
 					bias-disable;
 				};
 
+				pinctrl_pdmic_default: pdmic_default {
+					pinmux = <PIN_PB26__PDMIC_DAT>,
+						<PIN_PB27__PDMIC_CLK>;
+					bias-disable;
+				};
+
 				pinctrl_sdmmc0_default: sdmmc0_default {
 					cmd_data {
 						pinmux = <PIN_PA1__SDMMC0_CMD>,
-- 
1.7.9.5
