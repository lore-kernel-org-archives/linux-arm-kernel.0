From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Oct 2018 13:16:32 +0200
Subject: [PATCH 3/9] dt-bindings: tegra186-hsp: Add shared interrupts
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
Message-ID: <20181026111638.10759-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

HSP interrupts can be routed through exposed "shared interrupts". These
interrupts can be mapped to various internal interrupt lines. Add
interrupt properties for shared interrupts to the tegra186-hsp device
tree bindings.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
index b99d25fc2f26..620c249363ca 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -15,12 +15,15 @@ Required properties:
     Array of strings.
     one of:
     - "nvidia,tegra186-hsp"
+    - "nvidia,tegra194-hsp", "nvidia,tegra186-hsp"
 - reg : Offset and length of the register set for the device.
 - interrupt-names
     Array of strings.
     Contains a list of names for the interrupts described by the interrupt
     property. May contain the following entries, in any order:
     - "doorbell"
+    - "sharedN", where 'N' is a number from zero up to the number of
+      external interrupts supported by the HSP instance minus one.
     Users of this binding MUST look up entries in the interrupt property
     by name, using this interrupt-names property to do so.
 - interrupts
-- 
2.19.1
