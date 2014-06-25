From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Jun 2014 21:13:44 -0300
Subject: [PATCH] ARM: dts: mx6: Disable the keypad in the dtsi files
Message-ID: <1403655224-25624-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When booting a board that does not have a keypad (such as imx6q-sabresd) the
following error is seen on boot:

imx-keypad 20b8000.kpp: OF: linux,keymap property not defined in /soc/aips-bus at 02000000/kpp at 020b8000
imx-keypad 20b8000.kpp: failed to build keymap
imx-keypad: probe of 20b8000.kpp failed with error -2

Let's disable the keypad functionality in the dtsi files and let each board dts
enable it when needed.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 1 +
 arch/arm/boot/dts/imx6qdl.dtsi     | 1 +
 arch/arm/boot/dts/imx6sl.dtsi      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 66a1353..f02b80b 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -620,6 +620,7 @@
 		MATRIX_KEY(2, 7, KEY_KP8) /* 0x02070048 */
 		MATRIX_KEY(2, 2, KEY_KP9) /* 0x02020049 */
 	>;
+	status = "okay";
 };
 
 &pwm1 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 1fd272b..d7c97d9 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -485,6 +485,7 @@
 				reg = <0x020b8000 0x4000>;
 				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_IPG>;
+				status = "disabled";
 			};
 
 			wdog1: wdog at 020bc000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 57d4abe..c0ee12f 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -403,6 +403,7 @@
 				reg = <0x020b8000 0x4000>;
 				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
+				status = "disabled";
 			};
 
 			wdog1: wdog at 020bc000 {
-- 
1.8.3.2
