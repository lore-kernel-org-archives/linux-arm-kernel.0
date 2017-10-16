From: marco.franchi@nxp.com (Marco Franchi)
Date: Mon, 16 Oct 2017 10:48:30 -0200
Subject: [PATCH 6/6] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with unit
 name and no reg property
In-Reply-To: <1508158110-5188-1-git-send-email-marco.franchi@nxp.com>
References: <1508158110-5188-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508158110-5188-6-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/
ethernet-phy at 0 has a unit name, but no reg property

Fix this warning by removing '@' from such node.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx53-tx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 7807c1f..27a1aee 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -206,7 +206,7 @@
 	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
 	status = "okay";
 
-	phy0: ethernet-phy at 0 {
+	phy0: ethernet-phy {
 		interrupt-parent = <&gpio2>;
 		interrupts = <4>;
 		device_type = "ethernet-phy";
-- 
2.7.4
