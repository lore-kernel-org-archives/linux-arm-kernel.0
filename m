From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 23 Jun 2017 17:40:13 +0200
Subject: [PATCH 1/2] arm64: dts: marvell: fix USB3 regulator definition on
 MacchiatoBin
Message-ID: <20170623154014.20573-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the lack of GPIO support, the USB3 regulator definition was
left unfinished in the MacchiatoBin DT description. Now that GPIO
support is available, this commit adjusts the Device Tree to properly
describe the USB3 regulator.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 015b58b..dfced8c 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -46,6 +46,8 @@
 
 #include "armada-8040.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Marvell 8040 MACHIATOBin";
 	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
@@ -80,8 +82,9 @@
 		regulator-name = "v_5v0_usb3_hst_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		/* actually GPIO controlled, but 8k has no GPIO support yet */
+		gpio = <&cpm_gpio2 15 GPIO_ACTIVE_HIGH>;
 		regulator-always-on;
+		enable-active-high;
 		status = "okay";
 	};
 
-- 
2.9.4
