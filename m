From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri, 29 Mar 2013 09:23:38 +0100
Subject: [PATCH 1/2] ARM: imx27: Add PWM0 to device tree
Message-ID: <1364545419-21558-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27.dtsip | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsip b/arch/arm/boot/dts/imx27.dtsip
index ff4bd48..d4196d1 100644
--- a/arch/arm/boot/dts/imx27.dtsip
+++ b/arch/arm/boot/dts/imx27.dtsip
@@ -89,6 +89,15 @@
 				clock-names = "ipg", "per";
 			};
 
+			pwm0: pwm at 10006000 {
+				compatible = "fsl,imx27-pwm";
+				reg = <0x10006000 0x1000>;
+				interrupts = <23>;
+				clocks = <&clks 34>, <&clks 61>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
 			uart1: serial at 1000a000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
-- 
1.8.1.5
