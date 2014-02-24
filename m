From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 24 Feb 2014 11:25:57 +0100
Subject: [PATCH 3/3] dt/bindings: fsl-fec: add "per" to clock properties
In-Reply-To: <1393237557-31406-1-git-send-email-gsi@denx.de>
References: <1393237557-31406-1-git-send-email-gsi@denx.de>
Message-ID: <1393237557-31406-3-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a recent FEC binding document update that was motivated by i.MX
development revealed that ARM and PowerPC implementations in Linux
did not agree on the clock names to use for the FEC nodes

update the FEC (fast ethernet controller) binding to document the
"per" clock name as an obsolete alias for "ipg"

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---

this patch depends on "dt/bindings: fsl-fec: add clock properties"
by Shawn Guo which introduces the context of this patch

the patch only is necessary if the MPC5121 .dtsi update (switch
FEC nodes from "per" to "ipg") won't make it for v3.14

---
 Documentation/devicetree/bindings/net/fsl-fec.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index 468736d4323d..f59b58e29da6 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -24,6 +24,8 @@ Optional properties:
      or external oscillator via pad depending on board design.
    - "enet_out": the phy reference clock provided by SoC via pad, which
      is available on SoC like i.MX28.
+   - "per": obsolete alias for "ipg" for compatibility with early
+     MPC5121 implementations, not recommended for new .dts files
 - clock-names: Must contain the clock names described just above
 
 Example:
-- 
1.7.10.4
