From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu,  3 Aug 2017 16:09:10 +0800
Subject: [PATCH v3 2/5] dt-bindings: phy-rockchip-inno-usb2: add companion grf
 quirk
In-Reply-To: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
References: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1501747753-6983-3-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rockchip,usbgrf and rockchip,companion_grf_quirk to support
the registers of usb-phy that are distributed in grf and usbgrf
on some special Rockchip SoCs (e.g RV1108).

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
index 84d59b0..ddf868a 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
@@ -18,6 +18,10 @@ Optional properties:
 		 usb-phy output 480m and xin24m.
 		 Refer to clk/clock-bindings.txt for generic clock
 		 consumer properties.
+ - rockchip,usbgrf : phandle to the syscon managing the "usb general
+		 register files".
+ - rockchip,companion_grf_quirk : when set driver will request
+		 "rockchip,usbgrf" phandle as one companion-grf.
 
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify host or otg port,
-- 
2.0.0
