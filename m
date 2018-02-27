From: mayhs11saini@gmail.com (shyam saini)
Date: Tue, 27 Feb 2018 21:29:03 +0530
Subject: [PATCH] ARM: dts: imx6dl-icore-rqs: Fix invalid PHY address
 assignment for ethernet
Message-ID: <1519747143-3036-1-git-send-email-mayhs11saini@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shyam Saini <shyam@amarulasolutions.com>

Add "reg" property for ethernet to fix this issue.

Errors in boot logs:
mdio_bus 2188000.ethernet-1:
/soc/aips-bus at 02100000/ethernet at 02188000/mdio/ethernet-phy
has invalid PHY address

mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 0
mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 1
mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 2
mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 3

Reported-by: Shyam Saini <shyam@amarulasolutions.com>
Suggested-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Shyam Saini <shyam@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 49daa2b7892d..acc3b11fba2a 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -200,7 +200,11 @@
 	status = "okay";
 
 	mdio {
-		eth_phy: ethernet-phy {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy: ethernet-phy at 0 {
+			reg = <0x0>;
 			rxc-skew-ps = <1140>;
 			txc-skew-ps = <1140>;
 			txen-skew-ps = <600>;
-- 
2.7.4
