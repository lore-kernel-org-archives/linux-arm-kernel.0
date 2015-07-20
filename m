From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Mon, 20 Jul 2015 10:54:28 +0300
Subject: [PATCH v2 3/4] of: Add NVIDIA Tegra VIC binding
In-Reply-To: <1437378869-10451-1-git-send-email-mperttunen@nvidia.com>
References: <1437378869-10451-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1437378869-10451-4-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree binding documentation for the Video Image
Compositor (VIC) present on Tegra124 and newer SoC's.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../devicetree/bindings/gpu/nvidia,tegra20-host1x.txt     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
index 009f4bf..1328f3f 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
@@ -240,6 +240,21 @@ of the following host1x client modules:
     - dpaux
   - vdd-supply: phandle of a supply that powers the DisplayPort link
 
+- vic: Video Image Compositor
+  - compatible: For Tegra124, must contain "nvidia,tegra124-vic".  Otherwise,
+    must contain '"nvidia,<chip>-vic", "nvidia,tegra124-vic"', where
+    <chip> is tegra132.
+  - reg: Physical base address and length of the controller's registers.
+  - interrupts: The interrupt outputs from the controller.
+  - clocks: Must contain an entry for each entry in clock-names.
+    See ../clocks/clock-bindings.txt for details.
+  - clock-names: Must include the following entries:
+    - vic: clock input for the VIC hardware
+  - resets: Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names: Must include the following entries:
+    - vic
+
 Example:
 
 / {
-- 
2.1.4
