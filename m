From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 12:36:28 +0100
Subject: [PATCH 3/4] mmc: bcm2835: add internal SD controller to devicetree
In-Reply-To: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
Message-ID: <1485516989-1072-4-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 6 ++++++
 arch/arm/boot/dts/bcm283x.dtsi     | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 0b73f9c..7d89af2 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -69,6 +69,12 @@
 	bus-width = <4>;
 };
 
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	bus-width = <4>;
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index a3106aa..2024f9b 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -450,6 +450,14 @@
 			status = "disabled";
 		};
 
+		sdhost: sdhost at 7e202000 {
+			compatible = "brcm,bcm2835-sdhost";
+			reg = <0x7e202000 0x100>;
+			interrupts = <2 24>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>;
+			status = "disabled";
+		};
+
 		hvs at 7e400000 {
 			compatible = "brcm,bcm2835-hvs";
 			reg = <0x7e400000 0x6000>;
-- 
1.8.3.1
