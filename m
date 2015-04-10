From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:35:58 +0200
Subject: [PATCH 3/9] Documentation: DT bindings: fix hda2codec_2x clock name
 for tegra30-hda
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <ee8e9952dfdfd87da52f817fca0a6ad94a137742.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix hda2codec_2x clock name in Tegra30 HDA controller device tree node
documentation.
While at it also fix coma vs. semicolon issue.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
index 13e2ef4..5032efa 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
@@ -8,10 +8,10 @@ Required properties:
 - interrupts : The interrupt from the HDA controller.
 - clocks : Must contain an entry for each required entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries: hda, hdacodec_2x, hda2hdmi
+- clock-names : Must include the following entries: hda, hda2codec_2x, hda2hdmi
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
-- reset-names : Must include the following entries: hda, hdacodec_2x, hda2hdmi
+- reset-names : Must include the following entries: hda, hda2codec_2x, hda2hdmi
 
 Example:
 
@@ -24,7 +24,7 @@ hda at 0,70030000 {
 		 <&tegra_car TEGRA124_CLK_HDA2CODEC_2X>;
 	clock-names = "hda", "hda2hdmi", "hda2codec_2x";
 	resets = <&tegra_car 125>, /* hda */
-		 <&tegra_car 128>; /* hda2hdmi */
-		 <&tegra_car 111>, /* hda2codec_2x */
+		 <&tegra_car 128>, /* hda2hdmi */
+		 <&tegra_car 111>; /* hda2codec_2x */
 	reset-names = "hda", "hda2hdmi", "hda2codec_2x";
 };
-- 
1.9.3
