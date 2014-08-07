From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu,  7 Aug 2014 12:58:40 +0200
Subject: [PATCH] ARM: imx6: add pci config space as platform resource
Message-ID: <1407409120-23635-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes "imx6q-pcie 1ffc000.pcie: missing *config* reg space"
error exposed by new versions of the designware pcie driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ce0599134a69..6b5da2a98aaf 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -133,7 +133,9 @@
 
 		pcie: pcie at 0x01000000 {
 			compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
-			reg = <0x01ffc000 0x4000>; /* DBI */
+			reg = <0x01ffc000 0x04000>,
+			      <0x01f00000 0x80000>;
+			reg-names = "dbi", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.0.1
