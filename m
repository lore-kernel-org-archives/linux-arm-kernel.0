From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Fri, 18 Dec 2015 11:52:45 +0300
Subject: [PATCH 4/4] ARM: dts: sun7i: Add PA gpio pin to Wexler TAB7200 tablet
In-Reply-To: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
References: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1450428765-5779-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PA gpio pin for controlling power of two external amplifiers (NS4890) which are used on the Wexler TAB7200 tablet

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index f47e5f1..2f6b21a 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -74,6 +74,9 @@
 };
 
 &codec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&codec_pa_pin>;
+	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
 	status = "okay";
 };
 
@@ -176,6 +179,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
+	codec_pa_pin: codec_pa_pin at 0 {
+		allwinner,pins = "PH15";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	ts_reset_pin: ts_reset_pin at 0 {
 		allwinner,pins = "PB13";
 		allwinner,function = "gpio_out";
-- 
2.4.10
