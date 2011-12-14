From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Dec 2011 09:26:46 +0800
Subject: [PATCH V3 3/4] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323826007-17937-4-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add basic board dts file
- Add board compatible string to mach-imx6q.
- Update fsl DT board doc.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
 arch/arm/boot/dts/imx6q-sabrelite.dts         |   49 +++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx6q.c                |    1 +
 3 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-sabrelite.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index c9848ad..d4e50ad 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -24,3 +24,7 @@ Required root node properties:
 i.MX6 Quad SABRE Automotive Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
+
+i.MX6 Quad SABRE Lite Board
+Required root node properties:
+    - compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
new file mode 100644
index 0000000..08d920d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -0,0 +1,49 @@
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
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	soc {
+		aips-bus at 02100000 { /* AIPS2 */
+			enet at 02188000 {
+				phy-mode = "rgmii";
+				phy-reset-gpios = <&gpio3 23 0>;
+				status = "okay";
+			};
+
+			usdhc at 02198000 { /* uSDHC3 */
+				cd-gpios = <&gpio7 0 0>;
+				wp-gpios = <&gpio7 1 0>;
+				status = "okay";
+			};
+
+			usdhc at 0219c000 { /* uSDHC4 */
+				cd-gpios = <&gpio2 6 0>;
+				wp-gpios = <&gpio2 7 0>;
+				status = "okay";
+			};
+
+			uart2: uart at 021e8000 {
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
