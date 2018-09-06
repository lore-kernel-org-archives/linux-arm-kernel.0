From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 6 Sep 2018 11:03:31 +0200
Subject: [PATCH] ARM: dts: stih410: change syntax of multiple DAI
Message-ID: <1536224611-30979-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christophe Priouzeau <christophe.priouzeau@st.com>

With change of syntax for 'simple-audio-card,dai-link' containers,
devicetrees of stih410 must be updated.

This fixes the following error:

[    3.839466] asoc-simple-card sound: asoc_simple_card_dai_link_of:
Can't find simple-audio-card,cpu DT node
[    3.849150] asoc-simple-card sound: parse error -22

Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410-b2260.dts  |  5 ++++-
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 155caa8..4ee6d51 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -61,8 +61,11 @@
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "STI-B2260";
 		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		simple-audio-card,dai-link0 {
+		simple-audio-card,dai-link at 0 {
+			reg = <0>;
 			/* DAC */
 			format = "i2s";
 			mclk-fs = <128>;
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 4dedfcb..97e05f5 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -27,8 +27,11 @@
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "STI-B2120";
 		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		simple-audio-card,dai-link0 {
+		simple-audio-card,dai-link at 0 {
+			reg = <0>;
 			/* HDMI */
 			format = "i2s";
 			mclk-fs = <128>;
@@ -41,7 +44,8 @@
 			};
 		};
 
-		simple-audio-card,dai-link1 {
+		simple-audio-card,dai-link at 1 {
+			reg = <1>;
 			/* DAC */
 			format = "i2s";
 			mclk-fs = <256>;
@@ -55,7 +59,8 @@
 			};
 		};
 
-		simple-audio-card,dai-link2 {
+		simple-audio-card,dai-link at 2 {
+			reg = <2>;
 			/* SPDIF */
 			format = "left_j";
 			mclk-fs = <128>;
-- 
1.9.1
