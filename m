From: eric@anholt.net (Eric Anholt)
Date: Tue, 18 Aug 2015 14:54:07 -0700
Subject: [PATCH v2 6/7] ARM: bcm2835: Add the DDC I2C controller to the device
 tree.
In-Reply-To: <1439934848-7196-1-git-send-email-eric@anholt.net>
References: <1439934848-7196-1-git-send-email-eric@anholt.net>
Message-ID: <1439934848-7196-7-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use it for getting video modes over HDMI.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Mark it as disabled by default, and enable it in bcm2835-rpi.

 arch/arm/boot/dts/bcm2835-rpi.dtsi |  4 ++++
 arch/arm/boot/dts/bcm2835.dtsi     | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 46780bb..29cc7ba 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -45,6 +45,10 @@
 	clock-frequency = <100000>;
 };
 
+&i2c2 {
+	status = "okay";
+};
+
 &sdhci {
 	status = "okay";
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..20574cc 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -149,6 +149,16 @@
 			status = "disabled";
 		};
 
+		i2c2: i2c at 7e805000 {
+			compatible = "brcm,bcm2835-i2c";
+			reg = <0x7e805000 0x1000>;
+			interrupts = <2 21>;
+			clocks = <&clk_i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
-- 
2.1.4
