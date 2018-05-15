From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 15:47:33 +0200
Subject: [PATCH v3 3/6] dt-bindings: allow optional phys in Rockchip dw_hdmi
 binding
In-Reply-To: <20180515134736.5824-1-heiko@sntech.de>
References: <20180515134736.5824-1-heiko@sntech.de>
Message-ID: <20180515134736.5824-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some newer Rockchip SoCs use an Innosilicon hdmiphy accessed via general
mmio, so allow these to be referenced via the regular phy interfaces
and therefore add optional phy-related properties to the binding.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
index adc94fc3c9f8..937bfb472e1d 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
@@ -34,6 +34,8 @@ Optional properties
 - clock-names: May contain "cec" as defined in dw_hdmi.txt.
 - clock-names: May contain "grf", power for grf io.
 - clock-names: May contain "vpll", external clock for some hdmi phy.
+- phys: from general PHY binding: the phandle for the PHY device.
+- phy-names: Should be "hdmi" if phys references an external phy.
 
 Example:
 
-- 
2.17.0
