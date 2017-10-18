From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 18 Oct 2017 17:29:51 -0200
Subject: [PATCH v2 6/6] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with
 unit name and no reg property
In-Reply-To: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
References: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508354991-18016-6-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has a unit name, but no reg property

Fix this warning by removing '@' from such node.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
-rebased to imx/dt branch
 arch/arm/boot/dts/imx53-tx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 76e7186..5d93287 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -225,7 +225,7 @@
 	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
 	status = "okay";
 
-	phy0: ethernet-phy at 0 {
+	phy0: ethernet-phy {
 		interrupts-extended = <&gpio2 4 IRQ_TYPE_EDGE_FALLING>;
 		device_type = "ethernet-phy";
 	};
-- 
2.7.4
