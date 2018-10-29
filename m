From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 29 Oct 2018 14:30:05 +0530
Subject: [PATCH v2 6/7] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
In-Reply-To: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
References: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181029090006.4353-7-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all 96Boards, the following standard is used for onboard LEDs.

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

So lets adopt the same for Ultra96, which is one of the 96Boards
CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
consolidate only User LEDs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index eb5e8bddb610..c08a8753215b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -57,29 +57,30 @@
 	leds {
 		compatible = "gpio-leds";
 		ds2 {
-			label = "ds2";
+			label = "green:user1";
 			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		ds3 {
-			label = "ds3";
+			label = "green:user2";
 			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0tx"; /* WLAN tx */
+			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		ds4 {
-			label = "ds4";
+			label = "green:user3";
 			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0rx"; /* WLAN rx */
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
 		ds5 {
-			label = "ds5";
+			label = "green:user4";
 			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "bluetooth-power";
+			linux,default-trigger = "none";
+			panic-indicator;
 		};
 
 		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
-- 
2.17.1
