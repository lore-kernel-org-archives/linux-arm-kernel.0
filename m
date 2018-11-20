From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 20 Nov 2018 18:57:06 +0000
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: Enable pcie
Message-ID: <31f5fa5e281b53f10dc25d8abe20ccaa569ad86e.1542739826.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6qdl-sabreauto boards have a pcie slot so let's enable it.

Tested on imx6dl-sabreauto with an atk9k wifi card; scanning works.

There are unhandled differences for imx6qp but imx6qp-sabreauto.dts
already contains a snippet explicitly disabling the &pcie node so that
can be dealt with later.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index a6dc5c42c632..540fbaf57e91 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -756,10 +756,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
 };
 
+&pcie {
+	status = "okay";
+};
+
 &spdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spdif>;
 	status = "okay";
 };
-- 
2.17.1
