From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  1 Dec 2017 11:43:14 -0600
Subject: [PATCH 2/3] arm64: dts: stratix10: remove phy node for usb
In-Reply-To: <1512150195-31821-1-git-send-email-dinguyen@kernel.org>
References: <1512150195-31821-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1512150195-31821-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY entry for the USB nodes is not needed for the Stratix10 platform.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 7c9bdc7..11ce068 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -323,18 +323,10 @@
 			status = "disabled";
 		};
 
-		usbphy0: usbphy at 0 {
-			#phy-cells = <0>;
-			compatible = "usb-nop-xceiv";
-			status = "okay";
-		};
-
 		usb0: usb at ffb00000 {
 			compatible = "snps,dwc2";
 			reg = <0xffb00000 0x40000>;
 			interrupts = <0 93 4>;
-			phys = <&usbphy0>;
-			phy-names = "usb2-phy";
 			resets = <&rst USB0_RESET>;
 			reset-names = "dwc2";
 			status = "disabled";
@@ -344,8 +336,6 @@
 			compatible = "snps,dwc2";
 			reg = <0xffb40000 0x40000>;
 			interrupts = <0 94 4>;
-			phys = <&usbphy0>;
-			phy-names = "usb2-phy";
 			resets = <&rst USB1_RESET>;
 			reset-names = "dwc2";
 			status = "disabled";
-- 
2.7.4
