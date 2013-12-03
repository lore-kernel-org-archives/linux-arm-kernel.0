From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Tue,  3 Dec 2013 08:50:51 +0100
Subject: [PATCHv2 2/3] ARM: dts: apf27dev: Add pwm support
In-Reply-To: <1386057052-9978-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1386057052-9978-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1386057052-9978-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
Changelog:
v2:
 * rename subject: pwm0 -> pwm

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
