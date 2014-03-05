From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 5 Mar 2014 09:58:50 +0800
Subject: [PATCH 2/2] ARM: dts: sama5d36ek: add spi pinctrl sleep state
In-Reply-To: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
References: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1393984730-14828-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/boot/dts/sama5d36ek.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
index 59576c6..676d121 100644
--- a/arch/arm/boot/dts/sama5d36ek.dts
+++ b/arch/arm/boot/dts/sama5d36ek.dts
@@ -18,6 +18,8 @@
 	ahb {
 		apb {
 			spi0: spi at f0004000 {
+				pinctrl-names = "default", "sleep";
+				pinctrl-1 = <&pinctrl_spi0_sleep>;
 				status = "okay";
 			};
 
@@ -44,6 +46,18 @@
 			macb1: ethernet at f802c000 {
 				status = "okay";
 			};
+
+			pinctrl at fffff200 {
+				spi0 {
+					pinctrl_spi0_sleep: spi0-1 {
+						atmel,pins =
+							<AT91_PIOD 10 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW	/* PD10 GPIO Output Low */
+							 AT91_PIOD 11 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW	/* PD11 GPIO Output Low */
+							 AT91_PIOD 12 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW>;	/* PD12 GPIO Output Low */
+					};
+				};
+
+			};
 		};
 	};
 
-- 
1.7.9.5
