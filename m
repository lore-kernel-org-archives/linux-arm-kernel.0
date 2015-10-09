From: eric@anholt.net (Eric Anholt)
Date: Fri,  9 Oct 2015 14:27:47 -0700
Subject: [PATCH v3 6/7] ARM: bcm2835: Add the DDC I2C controller to the device
 tree.
In-Reply-To: <1444426068-15817-1-git-send-email-eric@anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
Message-ID: <1444426068-15817-7-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use it for getting video modes over HDMI.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---

v2: Mark it as disabled by default, and enable it in bcm2835-rpi.

 arch/arm/boot/dts/bcm2835-rpi.dtsi |  4 ++++
 arch/arm/boot/dts/bcm2835.dtsi     | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ab5474e..3572f03 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -52,6 +52,10 @@
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
index a6a55b7..1e61eb7 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -167,6 +167,16 @@
 			status = "disabled";
 		};
 
+		i2c2: i2c at 7e805000 {
+			compatible = "brcm,bcm2835-i2c";
+			reg = <0x7e805000 0x1000>;
+			interrupts = <2 21>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>;
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
