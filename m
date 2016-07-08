From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  8 Jul 2016 17:04:55 +0800
Subject: [PATCH 1/7] dt-bindings: add rk3399 support for dw-mipi-rockchip
In-Reply-To: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
References: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1467968701-15620-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw-mipi-dsi of rk3399 is almost the same as rk3288, the rk3399 has
additional phy config clock.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 1753f0c..4d59df3 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -5,6 +5,7 @@ Required properties:
 - #address-cells: Should be <1>.
 - #size-cells: Should be <0>.
 - compatible: "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi".
+	      "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi".
 - reg: Represent the physical address range of the controller.
 - interrupts: Represent the controller's interrupt to the CPU(s).
 - clocks, clock-names: Phandles to the controller's pll reference
@@ -13,6 +14,10 @@ Required properties:
 - ports: contain a port node with endpoint definitions as defined in [2].
   For vopb,set the reg = <0> and set the reg = <1> for vopl.
 
+Optional properties:
+- clocks, clock-names: phandle to the dw-mipi phy clock, name should be
+		       "phy_cfg".
+
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/media/video-interfaces.txt
 
-- 
2.6.3
