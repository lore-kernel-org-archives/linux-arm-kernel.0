From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 29 Oct 2018 15:12:42 +0530
Subject: [PATCH v3 4/7] arm64: dts: hisilicon: hikey960: Standardize LED
 labels and triggers
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181029094245.7886-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all 96Boards, the following standard is used for onboard LEDs.

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

So lets adopt the same for HiKey960 which is one of the 96Boards
CE platform.

Since there is no trigger available for onboard-storage UFS now, user2
trigger is set to none.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hi3660-hikey960.dts     | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c98bcbc8dfba..46435466f1ab 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -85,36 +85,36 @@
 		compatible = "gpio-leds";
 
 		user_led1 {
-			label = "user_led1";
+			label = "green:user1";
 			/* gpio_150_user_led1 */
 			gpios = <&gpio18 6 0>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		user_led2 {
-			label = "user_led2";
+			label = "green:user2";
 			/* gpio_151_user_led2 */
 			gpios = <&gpio18 7 0>;
-			linux,default-trigger = "mmc0";
+			linux,default-trigger = "none";
 		};
 
 		user_led3 {
-			label = "user_led3";
+			label = "green:user3";
 			/* gpio_189_user_led3 */
 			gpios = <&gpio23 5 0>;
-			default-state = "off";
+			linux,default-trigger = "mmc0";
 		};
 
 		user_led4 {
-			label = "user_led4";
+			label = "green:user4";
 			/* gpio_190_user_led4 */
 			gpios = <&gpio23 6 0>;
 			panic-indicator;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
 		};
 
 		wlan_active_led {
-			label = "wifi_active";
+			label = "yellow:wlan";
 			/* gpio_205_wifi_active */
 			gpios = <&gpio25 5 0>;
 			linux,default-trigger = "phy0tx";
@@ -122,7 +122,7 @@
 		};
 
 		bt_active_led {
-			label = "bt_active";
+			label = "blue:bt";
 			gpios = <&gpio25 7 0>;
 			/* gpio_207_user_led1 */
 			linux,default-trigger = "hci0-power";
-- 
2.17.1
