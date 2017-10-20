From: marco.franchi@nxp.com (Marco Franchi)
Date: Fri, 20 Oct 2017 13:48:27 -0200
Subject: [PATCH v3 6/6] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with
 unit name and no reg property
In-Reply-To: <1508514507-30736-1-git-send-email-marco.franchi@nxp.com>
References: <1508514507-30736-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508514507-30736-6-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has a unit name, but no reg property

Fix this warning by adding reg property from such node.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v2:
-change message log
-add reg property
 arch/arm/boot/dts/imx53-tx53.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 76e7186..61ecd13 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -226,6 +226,7 @@
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
+		reg = <0>;
 		interrupts-extended = <&gpio2 4 IRQ_TYPE_EDGE_FALLING>;
 		device_type = "ethernet-phy";
 	};
-- 
2.7.4
