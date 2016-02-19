From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Feb 2016 13:19:05 +0800
Subject: [PATCH 2/5] arm64: dts: add LED nodes for hi6220-hikey
In-Reply-To: <1455859148-29098-1-git-send-email-guodong.xu@linaro.org>
References: <1455859148-29098-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1455859148-29098-3-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index c4f560a..5a004b4 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -63,6 +63,47 @@
 			status = "ok";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		user_led1 {
+			label = "user_led4";
+			gpios = <&gpio4 0 0>; /* <&gpio_user_led_1>; */
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "user_led3";
+			gpios = <&gpio4 1 0>; /* <&gpio_user_led_2>; */
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "user_led2";
+			gpios = <&gpio4 2 0>; /* <&gpio_user_led_3>; */
+			linux,default-trigger = "mmc1";
+		};
+
+		user_led4 {
+			label = "user_led1";
+			gpios = <&gpio4 3 0>; /* <&gpio_user_led_4>; */
+			linux,default-trigger = "cpu0";
+		};
+
+		wlan_active_led {
+			label = "wifi_active";
+			gpios = <&gpio3 5 0>; /* <&gpio_wlan_active_led>; */
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "bt_active";
+			gpios = <&gpio4 7 0>; /* <&gpio_bt_active_led>; */
+			linux,default-trigger = "hci0rx";
+			default-state = "off";
+		};
+	};
 };
 
 &uart2 {
-- 
1.9.1
