From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  5 Feb 2018 15:34:32 +0100
Subject: [PATCH 6/9] dt-bindings: allow optional phys in Rockchip dw_hdmi
 binding
In-Reply-To: <20180205143435.4723-1-heiko@sntech.de>
References: <20180205143435.4723-1-heiko@sntech.de>
Message-ID: <20180205143435.4723-7-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some newer Rockchip SoCs use an Innosilicon hdmiphy accessed via general
mmio, so allow these to be referenced via the regular phy interfaces
and therefore add optional phy-related properties to the binding.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt | 2 ++
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
2.15.1
