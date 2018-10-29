From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 29 Oct 2018 15:12:41 +0530
Subject: [PATCH v3 3/7] arm64: dts: hisilicon: hikey: Standardize LED labels
 and triggers
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181029094245.7886-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all 96Boards, the following standard is used for onboard LEDs.

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

So lets adopt the same for HiKey, which is one of the 96Boards
CE platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../arm64/boot/dts/hisilicon/hi6220-hikey.dts | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index f4964bee6a1a..610235028cc7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -340,42 +340,43 @@
 
 	leds {
 		compatible = "gpio-leds";
-		user_led4 {
-			label = "user_led4";
+
+		user_led1 {
+			label = "green:user1";
 			gpios = <&gpio4 0 0>; /* <&gpio_user_led_1>; */
 			linux,default-trigger = "heartbeat";
 		};
 
-		user_led3 {
-			label = "user_led3";
+		user_led2 {
+			label = "green:user2";
 			gpios = <&gpio4 1 0>; /* <&gpio_user_led_2>; */
 			linux,default-trigger = "mmc0";
 		};
 
-		user_led2 {
-			label = "user_led2";
+		user_led3 {
+			label = "green:user3";
 			gpios = <&gpio4 2 0>; /* <&gpio_user_led_3>; */
 			linux,default-trigger = "mmc1";
 		};
 
-		user_led1 {
-			label = "user_led1";
+		user_led4 {
+			label = "green:user4";
 			gpios = <&gpio4 3 0>; /* <&gpio_user_led_4>; */
 			panic-indicator;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
 		};
 
 		wlan_active_led {
-			label = "wifi_active";
+			label = "yellow:wlan";
 			gpios = <&gpio3 5 0>; /* <&gpio_wlan_active_led>; */
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
 		};
 
 		bt_active_led {
-			label = "bt_active";
+			label = "blue:bt";
 			gpios = <&gpio4 7 0>; /* <&gpio_bt_active_led>; */
-			linux,default-trigger = "hci0rx";
+			linux,default-trigger = "hci0-power";
 			default-state = "off";
 		};
 	};
-- 
2.17.1
