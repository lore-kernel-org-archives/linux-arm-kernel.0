From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  7 Mar 2017 06:34:45 +0800
Subject: [PATCH v3 1/5] dt: bindings: add pmu0 regs for USB PHYs on Allwinner
 H3/V3s/A64
In-Reply-To: <20170306223449.21404-1-icenowy@aosc.xyz>
References: <20170306223449.21404-1-icenowy@aosc.xyz>
Message-ID: <20170306223449.21404-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H3/V3s/A64 SoCs have a special USB PHY0 that can route to two
controllers: one is MUSB and the other is a EHCI/OHCI pair.

When it's routed to EHCI/OHCI pair, it will needs a "pmu0" regs to
tweak, like other EHCI/OHCI pairs in Allwinner SoCs.

Add this to the binding of USB PHYs on Allwinner H3/V3s/A64.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch in v3.

 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index e42334258185..005bc22938ff 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -15,6 +15,7 @@ Required properties:
 - reg : a list of offset + length pairs
 - reg-names :
   * "phy_ctrl"
+  * "pmu0" for H3, V3s and A64
   * "pmu1"
   * "pmu2" for sun4i, sun6i or sun7i
 - #phy-cells : from the generic phy bindings, must be 1
-- 
2.11.1
