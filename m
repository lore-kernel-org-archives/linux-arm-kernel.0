From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 14 Sep 2015 12:52:47 -0700
Subject: [PATCH 1/3] Documentation: bindings: brcmstb: Document write-pairing
In-Reply-To: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
References: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1442260369-6575-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the hif-cpubiuctrl node a bit more, and add a documentation
entry for the optional "brcm,write-pairing" property.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index 430608ec09f0..602fa5f308bb 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -20,6 +20,20 @@ system control is required:
     - compatible: "brcm,bcm<chip_id>-hif-cpubiuctrl", "syscon"
     - compatible: "brcm,bcm<chip_id>-hif-continuation", "syscon"
 
+hif-cpubiuctrl node
+-------------------
+
+Required properties:
+
+    - compatible
+	The string should be "brcm.bcm7445-hif-cpubiuctrl", "syscon"
+
+Optional properties:
+
+    - brcm,write-pairing:
+	Boolean property, which when present indicatse that the chip
+	supports write-pairing.
+
 example:
     rdb {
         #address-cells = <1>;
@@ -35,6 +49,7 @@ example:
         hif_cpubiuctrl: syscon at 3e2400 {
             compatible = "brcm,bcm7445-hif-cpubiuctrl", "syscon";
             reg = <0x3e2400 0x5b4>;
+            brcm,write-pairing;
         };
 
         hif_continuation: syscon at 452000 {
-- 
2.1.0
