From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue,  5 Sep 2017 11:43:04 +0300
Subject: [PATCH v2 4/6] dt-bindings: host1x: Add Tegra186 information
In-Reply-To: <20170905084306.19318-1-mperttunen@nvidia.com>
References: <20170905084306.19318-1-mperttunen@nvidia.com>
Message-ID: <20170905084306.19318-5-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Tegra186-specific hypervisor-related register range
properties.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
- Dropped incorrect note about cells properties.

 .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 74e1e8add5a1..844e0103fb0d 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -3,6 +3,10 @@ NVIDIA Tegra host1x
 Required properties:
 - compatible: "nvidia,tegra<chip>-host1x"
 - reg: Physical base address and length of the controller's registers.
+  For pre-Tegra186, one entry describing the whole register area.
+  For Tegra186, one entry for each entry in reg-names:
+    "vm" - VM region assigned to Linux
+    "hypervisor" - Hypervisor region (only if Linux acts as hypervisor)
 - interrupts: The interrupt outputs from the controller.
 - #address-cells: The number of cells used to represent physical base addresses
   in the host1x address space. Should be 1.
-- 
2.14.1
