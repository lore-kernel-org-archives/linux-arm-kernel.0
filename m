From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Aug 2012 16:00:40 +0200
Subject: [PATCH 1/2] ARM: dts: mxs: Add alternative I2C muxing options for
 imx28
In-Reply-To: <1346421641-3765-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346421641-3765-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1346421641-3765-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 60d10d7..7d156ee 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -421,6 +421,17 @@
 					fsl,pull-up = <1>;
 				};
 
+				i2c1_pins_a: i2c1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3101 /* MX28_PAD_PWM0__I2C1_SCL */
+						0x3111 /* MX28_PAD_PWM1__I2C1_SDA */
+					>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
 				saif0_pins_a: saif0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.9.5
