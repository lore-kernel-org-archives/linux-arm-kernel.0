From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat, 30 Nov 2013 15:36:09 +0100
Subject: [PATCH 2/3] ARM: dts: apf27dev: Add pwm0 support
In-Reply-To: <1385822170-98486-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1385822170-98486-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1385822170-98486-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 0010b3e..6069331 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -125,6 +125,10 @@
 		pinctrl_sdhc2: sdhc2grp {
 			fsl,pins = <MX27_SDHC2_PINGRP1>;
 		};
+
+		pinctrl_pwm0: pwm0grp {
+			fsl,pins = <MX27_PWM_PINGRP1>;
+		};
 	};
 };
 
@@ -135,3 +139,8 @@
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
