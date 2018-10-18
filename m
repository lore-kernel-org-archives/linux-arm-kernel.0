From: shyam.saini@amarulasolutions.com (Shyam Saini)
Date: Thu, 18 Oct 2018 20:33:05 +0530
Subject: [PATCH V2] ARM: dts: imx6qdl-icore: Add missing stdout-path property
Message-ID: <20181018150305.21408-1-shyam.saini@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This would help us to get early boot logs by passing "earlycon" to
kernel bootargs.

Further, by adding this we don't have to depend on complex earlyprintk
configs for early boot logs.

Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-icore.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 9ce993776160..f5b8ea6f7ee9 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -49,6 +49,10 @@
 		reg = <0x10000000 0x80000000>;
 	};
 
+	chosen {
+		stdout-path = &uart4;
+	};
+
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 100000>;
-- 
2.11.0
