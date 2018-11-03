From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  3 Nov 2018 20:32:36 +0800
Subject: [PATCH v2 1/3] dt-binding: dwmac-sun8i: add H6 compatible string (w/
 A64 fallback)
In-Reply-To: <20181103123238.4665-1-icenowy@aosc.io>
References: <20181103123238.4665-1-icenowy@aosc.io>
Message-ID: <20181103123238.4665-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H6 SoC features a Ethernet MAC that is similar to the one
in A64.

Add a compatible string for it with A64 fallback compatible string, in
this case the A64 driver can be used.

The "internal" PHY is not internal from the perspective of the H6 main
die, instead it's on the co-packaged AC200 chip, and connected to the
main die with RMII at the in-package Port A PIO bank. So from the SoC
driver side it needs no special treatment.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
- Added ACK tag by Rob and Review tag by Chen-Yu.

 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index 5bb3a18cc38d..54c66d0611cb 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -10,6 +10,7 @@ Required properties:
 		"allwinner,sun8i-r40-gmac"
 		"allwinner,sun8i-v3s-emac"
 		"allwinner,sun50i-a64-emac"
+		"allwinner,sun50i-h6-emac", "allwinner-sun50i-a64-emac"
 - reg: address and length of the register for the device.
 - interrupts: interrupt for the device
 - interrupt-names: must be "macirq"
-- 
2.18.1
