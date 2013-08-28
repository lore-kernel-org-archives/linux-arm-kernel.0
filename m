From: alison_chaiken@mentor.com (alison_chaiken at mentor.com)
Date: Tue, 27 Aug 2013 20:17:35 -0700
Subject: [PATCH 2/2] i.MX6: Documentation: Change fsl,
 imx-pinctrl.txt to match i.MX6 TRM
In-Reply-To: <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
References: <521C40D9.3070802@freescale.com>
 <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <1377659855-9573-3-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

Update documentation file fsl,imx-pinctrl.txt to match iomuxc pinctrl config
settings to reflect Rev. 1 (4/2013) of IMX6DQRM, i.MX6 technical reference
manual.

Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
---
 .../bindings/pinctrl/fsl,imx-pinctrl.txt           | 25 +++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
index 3a7caf7..9b347f1 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
@@ -72,23 +72,24 @@ iomuxc at 020e0000 {
 	/* shared pinctrl settings */
 	usdhc4 {
 		pinctrl_usdhc4_1: usdhc4grp-1 {
-			fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
+			fsl,pins = <1386 0x1b0b0	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
 				    1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
-				    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
-				    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
-				    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
-				    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
-				    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
-				    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
-				    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
-				    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
+				    1462 0x1b0b0	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
+				    1470 0x1b0b0	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
+				    1478 0x1b0b0	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
+				    1486 0x1b0b0	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
+				    1493 0x1b0b0	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
+				    1501 0x1b0b0	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
+				    1509 0x1b0b0	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
+				    1517 0x1b0b0>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
 		};
 	};
 	....
 };
-Refer to the IOMUXC controller chapter in imx6q datasheet,
-0x17059 means enable hysteresis, 47KOhm Pull Up, 50Mhz speed,
-80Ohm driver strength and Fast Slew Rate.
+Referring to "Pin Assignments" Table of "i.MX 6Dual/6Quad Applications Processor
+Reference Manual, Rev. 1, 04/2013",
+0x1b0b0 means enable hysteresis, 100KOhm Pull Up, 100Mhz speed,
+40Ohm driver strength and Slow Slew Rate.
 User should refer to each SoC spec to set the correct value.
 
 TODO: when dtc macro support is available, we can change above raw data
-- 
1.8.4
