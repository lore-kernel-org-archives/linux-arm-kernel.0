From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Jul 2018 18:34:27 -0300
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Disable internal watchdog
Message-ID: <1531344867-898-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx51-zii-rdu1 has an external watchdog in the environment
microcontroller, so disable the internal one.

This aligns with what was done in commit 7055f714032c ("ARM: dts:
imx6: RDU2: disable internal watchdog") for imx6 rdu2 board.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 257c918..0af9f67 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -668,6 +668,10 @@
 	status = "okay";
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_ampgpio: ampgpiogrp {
 		fsl,pins = <
-- 
2.7.4
