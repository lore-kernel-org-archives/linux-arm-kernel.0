From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 17 Aug 2017 21:54:11 +0300
Subject: [PATCH 4/6] dt-bindings: host1x: Fix and add Tegra186 information
In-Reply-To: <20170817185413.6324-1-mperttunen@nvidia.com>
References: <20170817185413.6324-1-mperttunen@nvidia.com>
Message-ID: <20170817185413.6324-5-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add note that address/size-cells should be 2 on 64-bit systems,
and add Tegra186-specific register range properties.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt  | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 74e1e8add5a1..b3e785b47100 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -3,11 +3,16 @@ NVIDIA Tegra host1x
 Required properties:
 - compatible: "nvidia,tegra<chip>-host1x"
 - reg: Physical base address and length of the controller's registers.
+  For pre-Tegra186, one entry describing the whole register area.
+  For Tegra186, one entry for each entry in reg-names:
+    "vm" - VM region assigned to Linux
+    "hypervisor" - Hypervisor region (only if Linux acts as hypervisor)
 - interrupts: The interrupt outputs from the controller.
 - #address-cells: The number of cells used to represent physical base addresses
-  in the host1x address space. Should be 1.
+  in the host1x address space. Should be 1 for 32-bit and 2 for 64-bit systems.
 - #size-cells: The number of cells used to represent the size of an address
-  range in the host1x address space. Should be 1.
+  range in the host1x address space. Should be 1 for 32-bit and 2 for 64-bit
+  systems.
 - ranges: The mapping of the host1x address space to the CPU address space.
 - clocks: Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
-- 
2.14.1
