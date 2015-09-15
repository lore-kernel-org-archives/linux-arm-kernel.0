From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 15 Sep 2015 11:14:58 -0700
Subject: [PATCH v2 1/3] Documentation: bindings: brcmstb: Document
 write-pairing
In-Reply-To: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
References: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1442340900-15320-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the hif-cpubiuctrl node a bit more, and add a documentation
entry for the optional "brcm,write-pairing" property.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- added a description of what the BIU stands for and what write pairing is
- fixed the compatible string description

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt     | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index 430608ec09f0..8ac28eb4a5a1 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -20,6 +20,25 @@ system control is required:
     - compatible: "brcm,bcm<chip_id>-hif-cpubiuctrl", "syscon"
     - compatible: "brcm,bcm<chip_id>-hif-continuation", "syscon"
 
+hif-cpubiuctrl node
+-------------------
+SoCs with Broadcom Brahma15 ARM-based CPUs have a specific Bus Interface Unit
+(BIU) block which controls and interfaces the CPU complex to the different
+Memory Controller Ports (MCP), one per memory controller (MEMC). This BIU block
+offers a feature called Write Pairing which consists in collapsing two adjacent
+cache lines into a single (bursted) write transaction towards the memory
+controller (MEMC) to maximize write bandwidth.
+
+Required properties:
+
+    - compatible: must be "brcm,bcm7445-hif-cpubiuctrl", "syscon"
+
+Optional properties:
+
+    - brcm,write-pairing:
+	Boolean property, which when present indicates that the chip
+	supports write-pairing.
+
 example:
     rdb {
         #address-cells = <1>;
@@ -35,6 +54,7 @@ example:
         hif_cpubiuctrl: syscon at 3e2400 {
             compatible = "brcm,bcm7445-hif-cpubiuctrl", "syscon";
             reg = <0x3e2400 0x5b4>;
+            brcm,write-pairing;
         };
 
         hif_continuation: syscon at 452000 {
-- 
2.1.0
