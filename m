From: biju.das@bp.renesas.com (Biju Das)
Date: Wed,  5 Jul 2017 14:01:50 +0100
Subject: [PATCH v 1/2] ravb: Add support for r8a7743 SoC
In-Reply-To: <1499259711-56175-1-git-send-email-biju.das@bp.renesas.com>
References: <1499259711-56175-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499259711-56175-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Gigabit Ethernet E-MAC on r8a7743 (RZ/G1M) SoC.
Renesas RZ/G1M (R8A7743) SoC Ethernet AVB IP is identical to the R-Car Gen2
family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 3 ++-
 drivers/net/ethernet/renesas/ravb_main.c               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index b519503..bc692ab 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -4,7 +4,8 @@ This file provides information on what the device node for the Ethernet AVB
 interface contains.
 
 Required properties:
-- compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
+- compatible: "renesas,etheravb-r8a7743" if the device is a part of R8A7743 SoC.
+	      "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,etheravb-r8a7791" if the device is a part of R8A7791 SoC.
 	      "renesas,etheravb-r8a7792" if the device is a part of R8A7792 SoC.
 	      "renesas,etheravb-r8a7793" if the device is a part of R8A7793 SoC.
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5931e85..e35b30f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1869,6 +1869,7 @@ static int ravb_mdio_release(struct ravb_private *priv)
 }
 
 static const struct of_device_id ravb_match_table[] = {
+	{ .compatible = "renesas,etheravb-r8a7743", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,etheravb-r8a7790", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,etheravb-r8a7794", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,etheravb-rcar-gen2", .data = (void *)RCAR_GEN2 },
-- 
1.9.1
