From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue,  9 Oct 2018 19:35:22 +0530
Subject: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels and
 triggers
In-Reply-To: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all 96Boards, the following standard is used for onboard LEDs.

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity
                                          (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD-card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

So lets adopt the same for Ultra96, which is one of the 96Boards
CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
consolidate only User LEDs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index eb5e8bddb610..565ceb390f99 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -57,29 +57,30 @@
 	leds {
 		compatible = "gpio-leds";
 		ds2 {
-			label = "ds2";
+			label = "zynqmp-zcu100-revC:green:user1";
 			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		ds3 {
-			label = "ds3";
+			label = "zynqmp-zcu100-revC:green:user2";
 			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0tx"; /* WLAN tx */
+			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		ds4 {
-			label = "ds4";
+			label = "zynqmp-zcu100-revC:green:user3";
 			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0rx"; /* WLAN rx */
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
 		ds5 {
-			label = "ds5";
+			label = "zynqmp-zcu100-revC:green:user4";
 			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "bluetooth-power";
+			linux,default-trigger = "none";
+			panic-indicator;
 		};
 
 		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
-- 
2.17.1
