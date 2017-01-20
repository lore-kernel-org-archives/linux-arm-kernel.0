From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 20 Jan 2017 17:44:01 +0100
Subject: [PATCH] ARM: imx6: remove unit address from LDB node
Message-ID: <20170120164401.5904-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LDB has no reg property as it uses the IOMUX-GPR syscon to access
its registers. Remove the unit address from the DT node to make DT
compiler happy.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e9ba244cda54..8903794f6ef7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -808,7 +808,7 @@
 				reg = <0x020e0000 0x4000>;
 			};
 
-			ldb: ldb at 020e0008 {
+			ldb: ldb {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx6q-ldb", "fsl,imx53-ldb";
-- 
2.11.0
