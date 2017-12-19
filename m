From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:40 -0800
Subject: [PATCH v2 2/9] dt-bindings: arm: brcmstb: Correct BIUCTRL node
 documentation
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the Device Tree bindings for the HIF_CPUBIUCTRL node whose
compatible string is actually brcm,bcm<chip-id>-cpu-biu-ctrl. Also
document in the binding the fallback property
("brcm,brcmstb-cpu-biu-ctrl") and update the example accordingly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index 790e6b0b8306..ed4bf3f388a3 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -17,21 +17,23 @@ Further, syscon nodes that map platform-specific registers used for general
 system control is required:
 
     - compatible: "brcm,bcm<chip_id>-sun-top-ctrl", "syscon"
-    - compatible: "brcm,bcm<chip_id>-hif-cpubiuctrl", "syscon"
+    - compatible: "brcm,bcm<chip_id>-cpu-biu-ctrl",
+		  "brcm,brcmstb-cpu-biu-ctrl",
+		  "syscon"
     - compatible: "brcm,bcm<chip_id>-hif-continuation", "syscon"
 
-hif-cpubiuctrl node
+cpu-biu-ctrl node
 -------------------
-SoCs with Broadcom Brahma15 ARM-based CPUs have a specific Bus Interface Unit
-(BIU) block which controls and interfaces the CPU complex to the different
-Memory Controller Ports (MCP), one per memory controller (MEMC). This BIU block
-offers a feature called Write Pairing which consists in collapsing two adjacent
-cache lines into a single (bursted) write transaction towards the memory
-controller (MEMC) to maximize write bandwidth.
+SoCs with Broadcom Brahma15 ARM-based and Brahma53 ARM64-based CPUs have a
+specific Bus Interface Unit (BIU) block which controls and interfaces the CPU
+complex to the different Memory Controller Ports (MCP), one per memory
+controller (MEMC). This BIU block offers a feature called Write Pairing which
+consists in collapsing two adjacent cache lines into a single (bursted) write
+transaction towards the memory controller (MEMC) to maximize write bandwidth.
 
 Required properties:
 
-    - compatible: must be "brcm,bcm7445-hif-cpubiuctrl", "syscon"
+    - compatible: must be "brcm,bcm7445-cpu-biu-ctrl", ""brcm,brcmstb-cpu-biu-ctrl", "syscon"
 
 Optional properties:
 
@@ -52,7 +54,7 @@ example:
         };
 
         hif_cpubiuctrl: syscon at 3e2400 {
-            compatible = "brcm,bcm7445-hif-cpubiuctrl", "syscon";
+            compatible = "brcm,bcm7445-cpu-biu-ctrl", "brcm,brcmstb-cpu-biu-ctrl", "syscon";
             reg = <0x3e2400 0x5b4>;
             brcm,write-pairing;
         };
-- 
2.9.3
