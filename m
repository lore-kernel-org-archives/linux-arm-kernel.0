From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 28 Jan 2016 16:33:47 +0000
Subject: [PATCH V5 09/14] Documentation: DT: bindings: Update NVIDIA PMC for
 Tegra
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1453998832-27383-10-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PMC driver compatible strings for Tegra132 and Tegra210.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt     | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 02c27004d4a8..53aa5496c5cf 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -6,11 +6,13 @@ modes. It provides power-gating controllers for SoC and CPU power-islands.
 
 Required properties:
 - name : Should be pmc
-- compatible : For Tegra20, must contain "nvidia,tegra20-pmc".  For Tegra30,
-  must contain "nvidia,tegra30-pmc".  For Tegra114, must contain
-  "nvidia,tegra114-pmc".  For Tegra124, must contain "nvidia,tegra124-pmc".
-  Otherwise, must contain "nvidia,<chip>-pmc", plus at least one of the
-  above, where <chip> is tegra132.
+- compatible : Should contain one of the following:
+	For Tegra20 must contain "nvidia,tegra20-pmc".
+	For Tegra30 must contain "nvidia,tegra30-pmc".
+	For Tegra114 must contain "nvidia,tegra114-pmc"
+	For Tegra124 must contain "nvidia,tegra124-pmc"
+	For Tegra132 must contain "nvidia,tegra124-pmc"
+	For Tegra210 must contain "nvidia,tegra210-pmc"
 - reg : Offset and length of the register set for the device
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
-- 
2.1.4
