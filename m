From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 15 Nov 2017 21:57:04 +0100
Subject: [PATCH] ARM: dts: bcm2835-rpi: Avoid conflicts on i2c0
Message-ID: <1510779424-642-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPU firmware of the Raspberry Pi 3 uses i2c0 to communicate to
the FXL6408 gpio expander. It's a bad idea to use the same interface
from the ARM side. Since this interface isn't used by the other
RPi boards, it's save to remove the complete node and avoid this
conflict.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 9d56c22a7861 ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.")
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392..995d17b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -44,13 +44,6 @@
 	};
 };
 
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_gpio0>;
-	status = "okay";
-	clock-frequency = <100000>;
-};
-
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_gpio2>;
-- 
2.7.4
