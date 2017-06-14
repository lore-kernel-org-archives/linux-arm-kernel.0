From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 14 Jun 2017 16:23:28 +0800
Subject: [PATCH v3 11/21] arm64: dts: hikey960: add LED nodes
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Message-ID: <20170614082338.15673-12-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HiKey960 has four user LEDs, and two special purpose LEDs: WiFi and BT
respectively.

All of them are implemented as GPIO.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 7aac35b..9ecf6c6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -49,6 +49,54 @@
 			linux,code = <KEY_POWER>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_led1 {
+			label = "user_led1";
+			/* gpio_150_user_led1 */
+			gpios = <&gpio18 6 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "user_led2";
+			/* gpio_151_user_led2 */
+			gpios = <&gpio18 7 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "user_led3";
+			/* gpio_189_user_led3 */
+			gpios = <&gpio23 5 0>;
+			default-state = "off";
+		};
+
+		user_led4 {
+			label = "user_led4";
+			/* gpio_190_user_led4 */
+			gpios = <&gpio23 6 0>;
+			linux,default-trigger = "cpu0";
+		};
+
+		wlan_active_led {
+			label = "wifi_active";
+			/* gpio_205_wifi_active */
+			gpios = <&gpio25 5 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "bt_active";
+			gpios = <&gpio25 7 0>;
+			/* gpio_207_user_led1 */
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
 };
 
 &i2c0 {
-- 
2.10.2
