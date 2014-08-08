From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Aug 2014 11:24:22 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: add alternative pinmuxing for i2c1
In-Reply-To: <1407489862-6358-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407489862-6358-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1407489862-6358-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx28.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index defb98a5b045..47f68ac868d4 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -585,6 +585,17 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
+				i2c1_pins_b: i2c1 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART2_CTS__I2C1_SCL
+						MX28_PAD_AUART2_RTS__I2C1_SDA
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
 				saif0_pins_a: saif0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.0.1
