From: romain.perier@gmail.com (Romain Perier)
Date: Sun, 26 Oct 2014 13:23:48 +0000
Subject: [PATCH v1 3/4] ARM: dts: rockchip: Add EMAC Rockchip for RK3066 SoCs
In-Reply-To: <1414329829-8031-1-git-send-email-romain.perier@gmail.com>
References: <1414329829-8031-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1414329829-8031-3-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the right pins topology for the MAC and MDIO
found in RK3066 SoCs. Boards based on this SoC have an
initial support for the emac-rockchip dt-binding.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index ad9c2db..7bec55f 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -179,6 +179,24 @@
 			bias-disable;
 		};
 
+		emac {
+			emac_xfer: emac-xfer {
+				rockchip,pins = <RK_GPIO1 16 RK_FUNC_2 &pcfg_pull_none>, /* mac_clk */
+						<RK_GPIO1 17 RK_FUNC_2 &pcfg_pull_none>, /* tx_en */
+						<RK_GPIO1 18 RK_FUNC_2 &pcfg_pull_none>, /* txd1 */
+						<RK_GPIO1 19 RK_FUNC_2 &pcfg_pull_none>, /* txd0 */
+						<RK_GPIO1 20 RK_FUNC_2 &pcfg_pull_none>, /* rx_err */
+						<RK_GPIO1 21 RK_FUNC_2 &pcfg_pull_none>, /* crs_dvalid */
+						<RK_GPIO1 22 RK_FUNC_2 &pcfg_pull_none>, /* rxd1 */
+						<RK_GPIO1 23 RK_FUNC_2 &pcfg_pull_none>; /* rxd0 */
+			};
+
+			emac_mdio: emac-mdio {
+				rockchip,pins = <RK_GPIO1 24 RK_FUNC_2 &pcfg_pull_none>, /* mac_md */
+						<RK_GPIO1 25 RK_FUNC_2 &pcfg_pull_none>; /* mac_mdclk */
+			};
+		};
+
 		emmc {
 			emmc_clk: emmc-clk {
 				rockchip,pins = <RK_GPIO3 31 RK_FUNC_2 &pcfg_pull_default>;
@@ -496,3 +514,7 @@
 &wdt {
 	compatible = "rockchip,rk3066-wdt", "snps,dw-wdt";
 };
+
+&emac {
+	compatible = "rockchip,rk3066-emac";
+};
-- 
1.9.1
