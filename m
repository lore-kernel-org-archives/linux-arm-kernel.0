From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Oct 2015 14:37:29 +0200
Subject: [PATCH 3/3] ARM: i.MX6 Phytec PFLA02: Add supplies for the SoC
 internal regulators
In-Reply-To: <1445344649-9559-1-git-send-email-s.hauer@pengutronix.de>
References: <1445344649-9559-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1445344649-9559-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC internal regulators for the CPU and the SoC come from the
DA9063 vdd_core and vdd_soc. Add this relationship to the device tree
so that the voltage drop on the SoC internal LDO regulators can be
minimized.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index d6d98d4..b879383 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -379,6 +379,18 @@
 	status = "disabled";
 };
 
+&reg_arm {
+	vin-supply = <&vddcore_reg>;
+};
+
+&reg_pu {
+	vin-supply = <&vddsoc_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&vddsoc_reg>;
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
2.6.1
