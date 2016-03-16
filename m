From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Thu, 17 Mar 2016 00:04:33 +0800
Subject: [PATCH v4 10/13] ARM: dts: sun8i-a83t: add mmc0 CD pin
In-Reply-To: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1458144276-31108-11-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A83T Boards BPI-m3 and Allwinner H8Homletv2 boards use PF6 as
Card Detect pin., so use PF6 as reference design CD pin in dtsi.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 7b02d85..c64d8d6 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -390,6 +390,13 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
+				allwinner,pins = "PF6";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PF2", "PF4";
 				allwinner,function = "uart0";
-- 
1.9.1
