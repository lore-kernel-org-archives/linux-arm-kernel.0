From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  9 Oct 2017 11:22:23 +0100
Subject: [PATCH RESEND] phy: rcar-gen2: Add r8a7743/5 support
Message-ID: <1507544543-28654-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB PHY support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5)
USB PHY is identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is tested against Linux next tag next-20170929.

 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index 91da947..eeb9e18 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -4,10 +4,13 @@ This file provides information on what the device node for the R-Car generation
 2 USB PHY contains.
 
 Required properties:
-- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
+- compatible: "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
+	      "renesas,usb-phy-r8a7745" if the device is a part of R8A7745 SoC.
+	      "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
 	      "renesas,usb-phy-r8a7794" if the device is a part of R8A7794 SoC.
-	      "renesas,rcar-gen2-usb-phy" for a generic R-Car Gen2 compatible device.
+	      "renesas,rcar-gen2-usb-phy" for a generic R-Car Gen2 or
+					  RZ/G1 compatible device.
 
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
-- 
1.9.1
