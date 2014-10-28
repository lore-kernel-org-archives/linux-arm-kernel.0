From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 28 Oct 2014 12:24:22 +0000
Subject: [PATCH v1 4/4] ARM: dts: rockchip: Enable emac node in
 rk3066a-marsboard
In-Reply-To: <1414499062-23875-1-git-send-email-romain.perier@gmail.com>
References: <1414499062-23875-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1414499062-23875-4-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables EMAC Rockchip and adds initial ethernet support
for the MarsBoard RK3066.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3066a-marsboard.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index 146bd61..560070c 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -122,6 +122,30 @@
 /* must be included after &tps gets defined */
 #include "tps65910.dtsi"
 
+&emac {
+	status = "okay";
+
+	phy = <&phy0>;
+	phy-supply = <&vaux33_reg>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&phy_int>;
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&pinctrl {
+	lan8720a {
+		phy_int: phy-int {
+			rockchip,pins = <RK_GPIO1 26 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.9.1
