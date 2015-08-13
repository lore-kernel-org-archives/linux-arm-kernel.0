From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 17:56:19 -0700
Subject: [PATCH 6/7] ARM: bcm2835: Add the DDC I2C controller to the device
 tree.
In-Reply-To: <1439427380-2436-1-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
Message-ID: <1439427380-2436-7-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use it for getting video modes over HDMI.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..8f3ba88 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -149,6 +149,15 @@
 			status = "disabled";
 		};
 
+		i2c2: i2c at 7e805000 {
+			compatible = "brcm,bcm2835-i2c";
+			reg = <0x7e805000 0x1000>;
+			interrupts = <2 21>;
+			clocks = <&clk_i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
-- 
2.1.4
