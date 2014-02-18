From: ashutosh.s@phytec.in (Ashutosh singh)
Date: Tue, 18 Feb 2014 19:16:24 +0530
Subject: [PATCH v2 3/4] Phytec phyFLEX-i.MX6 : Added GPMI-NAND Support
In-Reply-To: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
References: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <1392731185-4885-3-git-send-email-ashutosh.s@phytec.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for GPMI-NAND on Phytec phyFLEX-i.MX6 Quad module.

Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |    7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index 91aecba..21c8b37 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -21,6 +21,10 @@
 	status = "okay";
 };
 
+&gpmi {
+	status = "okay";
+};
+
 &uart4 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index 12a02f7..32097b4 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -174,6 +174,13 @@
 	status = "disabled";
 };
 
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand_1>;
+	nand-on-flash-bbt;
+	status = "disabled";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4_1>;
-- 
1.7.9.5
