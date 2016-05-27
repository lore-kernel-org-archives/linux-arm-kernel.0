From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri, 27 May 2016 06:10:38 -0400
Subject: [PATCH v2 1/4] dt-bindings: rng: Northstar Plus SoC rng bindings
In-Reply-To: <1464343841-29504-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1464343841-29504-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1464343841-29504-2-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the bindings used by Northstar Plus(NSP) SoC random number
generator.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Acked-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/rng/brcm,bcm2835.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt b/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
index 07ccdaa..aa304d4 100644
--- a/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
@@ -2,7 +2,7 @@ BCM2835 Random number generator
 
 Required properties:
 
-- compatible : should be "brcm,bcm2835-rng"
+- compatible : should be "brcm,bcm2835-rng"  or "brcm,bcm-nsp-rng"
 - reg : Specifies base physical address and size of the registers.
 
 Example:
@@ -11,3 +11,8 @@ rng {
         compatible = "brcm,bcm2835-rng";
         reg = <0x7e104000 0x10>;
 };
+
+rng at 18033000 {
+	compatible = "brcm,bcm-nsp-rng";
+	reg = <0x18033000 0x14>;
+};
-- 
2.1.0
