From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jul 2012 10:08:12 +0300
Subject: [PATCH 6/6] ARM: apx4devkit: add pin muxing for GPIOs
In-Reply-To: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <1341904092-13777-7-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pins are used as GPIOs in user space.

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
 arch/arm/boot/dts/apx4devkit.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
index b30e9d7..cef8a9b 100644
--- a/arch/arm/boot/dts/apx4devkit.dts
+++ b/arch/arm/boot/dts/apx4devkit.dts
@@ -40,8 +40,13 @@
 				hog_pins_a: hog-gpios at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
+						0x0113 /* MX28_PAD_GPMI_CE1N__GPIO_0_17 */
+						0x0153 /* MX28_PAD_GPMI_RDY1__GPIO_0_21 */
+						0x2123 /* MX28_PAD_SSP2_MISO__GPIO_2_18 */
+						0x2131 /* MX28_PAD_SSP2_SS0__GPIO_2_19 */
 						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
 						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
+						0x4143 /* MX28_PAD_JTAG_RTCK__GPIO_4_20 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
-- 
1.7.9.5
