From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 29 Oct 2018 15:12:43 +0530
Subject: [PATCH v3 5/7] arm64: dts: hisilicon: poplar: Standardize LED labels
 and triggers
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181029094245.7886-6-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all 96Boards, the following standard is used for onboard LEDs.

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

So lets adopt the same for Poplar, which is one of the 96Boards
Enterprise edition platform.

Due to absence of WLAN and BT support, corresponding LED nodes are not
considered.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index d30f6eb8a5ee..32716c96b457 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -35,30 +35,31 @@
 		compatible = "gpio-leds";
 
 		user-led0 {
-			label = "USER-LED0";
+			label = "green:user1";
 			gpios = <&gpio6 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
 		user-led1 {
-			label = "USER-LED1";
+			label = "green:user2";
 			gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		user-led2 {
-			label = "USER-LED2";
+			label = "green:user3";
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
 		user-led3 {
-			label = "USER-LED3";
+			label = "green:user4";
 			gpios = <&gpio10 6 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
+			panic-indicator;
 			default-state = "off";
 		};
 	};
-- 
2.17.1
