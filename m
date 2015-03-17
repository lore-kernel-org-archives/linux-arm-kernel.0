From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Mar 2015 01:32:21 -0700
Subject: [PATCHv2 3/3] Documentation: DT bindings: Tegra AHB: note base
 address change
In-Reply-To: <20150317083221.32662.14647.stgit@baseline>
References: <20150317083221.32662.14647.stgit@baseline>
Message-ID: <20150317083221.32662.96822.stgit@baseline>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Tegra132 and later chips, we can now use the correct hardware base
address for the Tegra AHB IP block in the DT data.  Update the DT binding
documentation to reflect this change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 .../bindings/arm/tegra/nvidia,tegra20-ahb.txt      |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
index 067c979..7692b4c 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
@@ -2,10 +2,15 @@ NVIDIA Tegra AHB
 
 Required properties:
 - compatible : For Tegra20, must contain "nvidia,tegra20-ahb".  For
-  Tegra30, must contain "nvidia,tegra30-ahb".  Otherwise, must contain
-  '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is tegra124,
-  tegra132, or tegra210.
-- reg : Should contain 1 register ranges(address and length)
+  Tegra30, must contain "nvidia,tegra30-ahb".  For Tegra114 and Tegra124, must
+  contain '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is tegra114
+  or tegra124.  For Tegra132, the compatible string must contain
+  "nvidia,tegra132-ahb".
+
+- reg : Should contain 1 register ranges(address and length).  On Tegra20,
+  Tegra30, Tegra114, and Tegra124 chips, the low byte of the physical base
+  address of the IP block must end in 0x04.  On DT files for later chips, the
+  actual hardware base address of the IP block should be used.
 
 Example:
 	ahb: ahb at 6000c004 {
