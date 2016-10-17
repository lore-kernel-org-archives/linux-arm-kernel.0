From: marex@denx.de (Marek Vasut)
Date: Mon, 17 Oct 2016 18:34:49 +0200
Subject: [PATCH] ARM: dts: novena: Enable PWM1
Message-ID: <20161017163449.11990-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PWM1, otherwise the backlight cannot work.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx6q-novena.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 1723e89e..758bca9 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -451,6 +451,10 @@
 	status = "okay";
 };
 
+&pwm1 {
+	status = "okay";
+};
+
 &sata {
 	target-supply = <&reg_sata>;
 	fsl,transmit-level-mV = <1025>;
-- 
2.9.3
