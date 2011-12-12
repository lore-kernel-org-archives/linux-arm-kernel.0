From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 12 Dec 2011 11:42:26 +0800
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   54 +++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx6q.c        |    1 +
 2 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-sabrelite.dts

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
new file mode 100644
index 0000000..d54363f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -0,0 +1,54 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx6q.dtsi"
+
+/ {
+	model = "Freescale i.MX6 Quad SABRE Lite Board";
+	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
+
+	chosen {
+		bootargs = "console=ttymxc1,115200";
+	};
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	soc {
+		aips-bus at 02100000 { /* AIPS2 */
+			enet at 02188000 {
+				phy-mode = "rgmii";
+				local-mac-address = [01 04 9F 01 1B 61];
+				phy-reset-gpios = <&gpio2 23 0>; /* gpio3 23 */
+				status = "okay";
+			};
+
+			usdhc at 02198000 { /* uSDHC3 */
+				cd-gpios = <&gpio6 0 0>; /* GPIO7_0 */
+				wp-gpios = <&gpio6 1 0>; /* GPIO7_1 */
+				status = "okay";
+			};
+
+			usdhc at 0219c000 { /* uSDHC4 */
+				cd-gpios = <&gpio1 6 0>; /* GPIO2_6 */
+				wp-gpios = <&gpio1 7 0>; /* GPIO2_7 */
+				status = "okay";
+			};
+
+			uart1: uart at 021e8000 { /* UART2 */
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 8deb012..d24d6c4 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -73,6 +73,7 @@ static struct sys_timer imx6q_timer = {
 
 static const char *imx6q_dt_compat[] __initdata = {
 	"fsl,imx6q-sabreauto",
+	"fsl,imx6q-sabrelite",
 	NULL,
 };
 
-- 
1.7.5.4
