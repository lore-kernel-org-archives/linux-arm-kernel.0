From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 20 Feb 2017 16:02:17 +0800
Subject: [RESEND PATCH v7 1/7] dt-bindings: add rk3399 support for
 dw-mipi-rockchip
In-Reply-To: <1487577744-2855-1-git-send-email-zyw@rock-chips.com>
References: <1487577744-2855-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1487577744-2855-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw-mipi-dsi of rk3399 is almost the same as rk3288, the rk3399 has
additional phy config clock.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 1753f0c..0f82568 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -5,10 +5,12 @@ Required properties:
 - #address-cells: Should be <1>.
 - #size-cells: Should be <0>.
 - compatible: "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi".
+	      "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi".
 - reg: Represent the physical address range of the controller.
 - interrupts: Represent the controller's interrupt to the CPU(s).
 - clocks, clock-names: Phandles to the controller's pll reference
-  clock(ref) and APB clock(pclk), as described in [1].
+  clock(ref) and APB clock(pclk). For RK3399, a phy config clock
+  (phy_cfg) is additional required. As described in [1].
 - rockchip,grf: this soc should set GRF regs to mux vopl/vopb.
 - ports: contain a port node with endpoint definitions as defined in [2].
   For vopb,set the reg = <0> and set the reg = <1> for vopl.
-- 
2.6.3
