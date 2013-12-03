From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Tue,  3 Dec 2013 12:10:14 +0100
Subject: [PATCH 2/3] ARM: dts: apf27dev: Add pwm support
In-Reply-To: <1386069015-10718-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1386069015-10718-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1386069015-10718-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index d02c67f..a794b1a 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -123,6 +123,10 @@
 			fsl,pins = <MX27_I2C2_PINGRP1>;
 		};
 
+		pinctrl_pwm0: pwm0grp {
+			fsl,pins = <MX27_PWM_PINGRP1>;
+		};
+
 		pinctrl_sdhc2: sdhc2grp {
 			fsl,pins = <MX27_SDHC2_PINGRP1>;
 		};
@@ -136,3 +140,8 @@
 	pinctrl-0 = <&pinctrl_sdhc2>;
 	status = "okay";
 };
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0>;
+};
-- 
1.8.3.2
