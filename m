From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Dec 2014 12:38:29 -0800
Subject: [PATCH 3/4] clk: tegra: Update binding doc for Tegra132
In-Reply-To: <20141216203813.22980.2301.stgit@chromeos-P9X79>
References: <20141216203813.22980.2301.stgit@chromeos-P9X79>
Message-ID: <20141216203828.22980.14684.stgit@chromeos-P9X79>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

Tegra132 has almost the same clock structure than Tegra124. This patch
documents the missing clock IDs.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
[paul at pwsan.com: updated binding documentation to reflect the recent
 split of Tegra124 clock IDs into a Tegra124/132-common file and a
 Tegra124-specific file]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 .../bindings/clock/nvidia,tegra124-car.txt         |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
index ded5d62..c6620bc 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
@@ -1,4 +1,4 @@
-NVIDIA Tegra124 Clock And Reset Controller
+NVIDIA Tegra124 and Tegra132 Clock And Reset Controller
 
 This binding uses the common clock binding:
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -7,14 +7,16 @@ The CAR (Clock And Reset) Controller on Tegra is the HW module responsible
 for muxing and gating Tegra's clocks, and setting their rates.
 
 Required properties :
-- compatible : Should be "nvidia,tegra124-car"
+- compatible : Should be "nvidia,tegra124-car" or "nvidia,tegra132-car"
 - reg : Should contain CAR registers location and length
 - clocks : Should contain phandle and clock specifiers for two clocks:
   the 32 KHz "32k_in", and the board-specific oscillator "osc".
 - #clock-cells : Should be 1.
   In clock consumers, this cell represents the clock ID exposed by the
-  CAR. The assignments may be found in header file
-  <dt-bindings/clock/tegra124-car.h>.
+  CAR. The assignments may be found in the header files
+  <dt-bindings/clock/tegra124-car-common.h> (which covers IDs common
+  to Tegra124 and Tegra132) and <dt-bindings/clock/tegra124-car.h>
+  (for Tegra124-specific clocks).
 - #reset-cells : Should be 1.
   In clock consumers, this cell represents the bit number in the CAR's
   array of CLK_RST_CONTROLLER_RST_DEVICES_* registers.
