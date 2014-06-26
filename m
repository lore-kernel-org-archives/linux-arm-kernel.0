From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Jun 2014 22:49:43 +0200
Subject: [RFC 03/10] of: Add NVIDIA Tegra124 memory controller binding
In-Reply-To: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403815790-8548-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The memory controller on NVIDIA Tegra124 exposes various knobs that can
be used to tune the behaviour of the clients attached to it.

In addition, the memory controller implements an SMMU (IOMMU) which can
translate I/O virtual addresses to physical addresses for clients. This
is useful for scatter-gather operation on devices that don't support it
natively and for virtualization or process separation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-mc.txt       | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.txt
new file mode 100644
index 000000000000..4c922e839059
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.txt
@@ -0,0 +1,12 @@
+NVIDIA Tegra124 Memory Controller device tree bindings
+======================================================
+
+Required properties:
+- compatible: Should be "nvidia,tegra124-mc"
+- reg: Physical base address and length of the controller's registers.
+- interrupts: The interrupt outputs from the controller.
+- #iommu-cells: Should be 1. The single cell of the IOMMU specifier defines
+  the SWGROUP of the master.
+
+This device implements an IOMMU that complies with the generic IOMMU binding.
+See ../iommu/iommu.txt for details.
-- 
2.0.0
