From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:40 -0500
Subject: [PATCH v2 08/10] arm64: dts: qcom: msm8916-pins: move sdhc2 cd node
 with its siblings
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-9-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nodes relative to the first sdhc node were interlaced with node of the
second sdhc. Move sdhc2_cd_pin with its siblings to prevent that. Also
rename the grouping node from sdhc2_cd_pin to pmx_sdc2_cd_pin, as
"pmx_sdc" is the prefix used by other nodes.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index c79301f204b7..7704ddecb6c4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -194,21 +194,6 @@
 		};
 	};
 
-	sdhc2_cd_pin {
-		sdc2_cd_on: cd_on {
-			pinmux {
-				function = "gpio";
-				pins = "gpio38";
-			};
-		};
-		sdc2_cd_off: cd_off {
-			pinmux {
-				function = "gpio";
-				pins = "gpio38";
-			};
-		};
-	};
-
 	pmx_sdc1_clk {
 		sdc1_clk_on: clk_on {
 			pinmux {
@@ -287,6 +272,21 @@
 		};
 	};
 
+	pmx_sdc2_cd_pin {
+		sdc2_cd_on: cd_on {
+			pinmux {
+				function = "gpio";
+				pins = "gpio38";
+			};
+		};
+		sdc2_cd_off: cd_off {
+			pinmux {
+				function = "gpio";
+				pins = "gpio38";
+			};
+		};
+	};
+
 	cdc-pdm-lines {
 		cdc_pdm_lines_act: pdm_lines_on {
 			pinmux {
-- 
2.15.0
