From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Dec 2017 17:59:45 -0200
Subject: [PATCH] ARM: dts: imx7s: Avoid using label in unit address and reg
Message-ID: <1514318385-12135-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As recommended by Rob Herring [1] labels should not be used in unit address
and reg, so use its real value directly instead.

[1] https://www.spinics.net/lists/devicetree/msg206567.html

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 2ceb37d..9aa2bb9 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -600,9 +600,9 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					pgc_pcie_phy: pgc-power-domain at IMX7_POWER_DOMAIN_PCIE_PHY {
+					pgc_pcie_phy: pgc-power-domain at 1 {
 						#power-domain-cells = <0>;
-						reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
+						reg = <1>;
 						power-supply = <&reg_1p0d>;
 					};
 				};
-- 
2.7.4
