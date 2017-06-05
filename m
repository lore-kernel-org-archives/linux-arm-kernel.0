From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon,  5 Jun 2017 10:33:32 -0500
Subject: [PATCH] ARM: dts: bonegreen-wireless: add WL1835 Bluetooth device node
Message-ID: <20170605153332.8827-1-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Ricardo Salveti <ricardo.salveti@linaro.org>
CC: Tony Lindgren <tony@atomide.com>
CC: Jason Kridner <jkridner@beagleboard.org>
---
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
index 9d1a0fd555f3..57731f0daf10 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -97,6 +97,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins &bt_pins>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &gpio1 {
-- 
2.11.0
