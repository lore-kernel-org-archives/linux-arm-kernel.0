From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Feb 2013 15:08:07 +0800
Subject: [PATCH 1/3] ARM: dts: imx: use pre-processor for device trees
In-Reply-To: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361344089-16804-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable C pre-processing on imx device trees. This allows future use
of defining names for various constants, to increase the readability
of the device tree sources.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../{imx25-karo-tx25.dts => imx25-karo-tx25.dtsp}  |    2 +-
 .../arm/boot/dts/{imx25-pdk.dts => imx25-pdk.dtsp} |    2 +-
 arch/arm/boot/dts/{imx25.dtsi => imx25.dtsip}      |    2 +-
 .../boot/dts/{imx27-apf27.dts => imx27-apf27.dtsp} |    2 +-
 .../arm/boot/dts/{imx27-pdk.dts => imx27-pdk.dtsp} |    2 +-
 ...hytec-phycore.dts => imx27-phytec-phycore.dtsp} |    2 +-
 arch/arm/boot/dts/{imx27.dtsi => imx27.dtsip}      |    2 +-
 .../arm/boot/dts/{imx31-bug.dts => imx31-bug.dtsp} |    2 +-
 arch/arm/boot/dts/{imx31.dtsi => imx31.dtsip}      |    2 +-
 .../boot/dts/{imx51-apf51.dts => imx51-apf51.dtsp} |    2 +-
 .../dts/{imx51-babbage.dts => imx51-babbage.dtsp}  |    2 +-
 arch/arm/boot/dts/{imx51.dtsi => imx51.dtsip}      |    2 +-
 .../arm/boot/dts/{imx53-ard.dts => imx53-ard.dtsp} |    2 +-
 .../arm/boot/dts/{imx53-evk.dts => imx53-evk.dtsp} |    2 +-
 .../boot/dts/{imx53-mba53.dts => imx53-mba53.dtsp} |    2 +-
 .../arm/boot/dts/{imx53-qsb.dts => imx53-qsb.dtsp} |    2 +-
 .../arm/boot/dts/{imx53-smd.dts => imx53-smd.dtsp} |    2 +-
 .../dts/{imx53-tqma53.dtsi => imx53-tqma53.dtsip}  |    2 +-
 arch/arm/boot/dts/{imx53.dtsi => imx53.dtsip}      |    2 +-
 arch/arm/boot/dts/{imx6dl.dtsi => imx6dl.dtsip}    |    0
 .../boot/dts/{imx6q-arm2.dts => imx6q-arm2.dtsp}   |    2 +-
 .../{imx6q-sabreauto.dts => imx6q-sabreauto.dtsp}  |    2 +-
 .../{imx6q-sabrelite.dts => imx6q-sabrelite.dtsp}  |    2 +-
 .../dts/{imx6q-sabresd.dts => imx6q-sabresd.dtsp}  |    2 +-
 arch/arm/boot/dts/{imx6q.dtsi => imx6q.dtsip}      |    2 +-
 arch/arm/boot/dts/{imx6qdl.dtsi => imx6qdl.dtsip}  |    2 +-
 26 files changed, 25 insertions(+), 25 deletions(-)
 rename arch/arm/boot/dts/{imx25-karo-tx25.dts => imx25-karo-tx25.dtsp} (96%)
 rename arch/arm/boot/dts/{imx25-pdk.dts => imx25-pdk.dtsp} (96%)
 rename arch/arm/boot/dts/{imx25.dtsi => imx25.dtsip} (99%)
 rename arch/arm/boot/dts/{imx27-apf27.dts => imx27-apf27.dtsp} (98%)
 rename arch/arm/boot/dts/{imx27-pdk.dts => imx27-pdk.dtsp} (96%)
 rename arch/arm/boot/dts/{imx27-phytec-phycore.dts => imx27-phytec-phycore.dtsp} (98%)
 rename arch/arm/boot/dts/{imx27.dtsi => imx27.dtsip} (99%)
 rename arch/arm/boot/dts/{imx31-bug.dts => imx31-bug.dtsp} (96%)
 rename arch/arm/boot/dts/{imx31.dtsi => imx31.dtsip} (98%)
 rename arch/arm/boot/dts/{imx51-apf51.dts => imx51-apf51.dtsp} (97%)
 rename arch/arm/boot/dts/{imx51-babbage.dts => imx51-babbage.dtsp} (99%)
 rename arch/arm/boot/dts/{imx51.dtsi => imx51.dtsip} (99%)
 rename arch/arm/boot/dts/{imx53-ard.dts => imx53-ard.dtsp} (99%)
 rename arch/arm/boot/dts/{imx53-evk.dts => imx53-evk.dtsp} (99%)
 rename arch/arm/boot/dts/{imx53-mba53.dts => imx53-mba53.dtsp} (98%)
 rename arch/arm/boot/dts/{imx53-qsb.dts => imx53-qsb.dtsp} (99%)
 rename arch/arm/boot/dts/{imx53-smd.dts => imx53-smd.dtsp} (99%)
 rename arch/arm/boot/dts/{imx53-tqma53.dtsi => imx53-tqma53.dtsip} (99%)
 rename arch/arm/boot/dts/{imx53.dtsi => imx53.dtsip} (99%)
 rename arch/arm/boot/dts/{imx6dl.dtsi => imx6dl.dtsip} (100%)
 rename arch/arm/boot/dts/{imx6q-arm2.dts => imx6q-arm2.dtsp} (98%)
 rename arch/arm/boot/dts/{imx6q-sabreauto.dts => imx6q-sabreauto.dtsp} (98%)
 rename arch/arm/boot/dts/{imx6q-sabrelite.dts => imx6q-sabrelite.dtsp} (99%)
 rename arch/arm/boot/dts/{imx6q-sabresd.dts => imx6q-sabresd.dtsp} (98%)
 rename arch/arm/boot/dts/{imx6q.dtsi => imx6q.dtsip} (99%)
 rename arch/arm/boot/dts/{imx6qdl.dtsi => imx6qdl.dtsip} (99%)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dtsp
similarity index 96%
rename from arch/arm/boot/dts/imx25-karo-tx25.dts
rename to arch/arm/boot/dts/imx25-karo-tx25.dtsp
index 1a9d049..3dbe775 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dtsp
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "imx25.dtsi"
+#include "imx25.dtsip"
 
 / {
 	model = "Ka-Ro TX25";
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dtsp
similarity index 96%
rename from arch/arm/boot/dts/imx25-pdk.dts
rename to arch/arm/boot/dts/imx25-pdk.dtsp
index a02a860..8064b76 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dtsp
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "imx25.dtsi"
+#include "imx25.dtsip"
 
 / {
 	model = "Freescale i.MX25 Product Development Kit";
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsip
similarity index 99%
rename from arch/arm/boot/dts/imx25.dtsi
rename to arch/arm/boot/dts/imx25.dtsip
index 94f3305..d2550e0 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsip
@@ -9,7 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dtsp
similarity index 98%
rename from arch/arm/boot/dts/imx27-apf27.dts
rename to arch/arm/boot/dts/imx27-apf27.dtsp
index b464c80..59f276f 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dtsp
@@ -13,7 +13,7 @@
  */
 
 /dts-v1/;
-/include/ "imx27.dtsi"
+#include "imx27.dtsip"
 
 / {
 	model = "Armadeus Systems APF27 module";
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dtsp
similarity index 96%
rename from arch/arm/boot/dts/imx27-pdk.dts
rename to arch/arm/boot/dts/imx27-pdk.dtsp
index 41cd110..fe5f609 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dtsp
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "imx27.dtsi"
+#include "imx27.dtsip"
 
 / {
 	model = "Freescale i.MX27 Product Development Kit";
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
similarity index 98%
rename from arch/arm/boot/dts/imx27-phytec-phycore.dts
rename to arch/arm/boot/dts/imx27-phytec-phycore.dtsp
index 53b0ec0..924097a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "imx27.dtsi"
+#include "imx27.dtsip"
 
 / {
 	model = "Phytec pcm038";
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsip
similarity index 99%
rename from arch/arm/boot/dts/imx27.dtsi
rename to arch/arm/boot/dts/imx27.dtsip
index 5a82cb5..324130f 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsip
@@ -9,7 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/imx31-bug.dtsp
similarity index 96%
rename from arch/arm/boot/dts/imx31-bug.dts
rename to arch/arm/boot/dts/imx31-bug.dtsp
index 9ac6f6b..8e26e91 100644
--- a/arch/arm/boot/dts/imx31-bug.dts
+++ b/arch/arm/boot/dts/imx31-bug.dtsp
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "imx31.dtsi"
+#include "imx31.dtsip"
 
 / {
 	model = "Buglabs i.MX31 Bug 1.x";
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsip
similarity index 98%
rename from arch/arm/boot/dts/imx31.dtsi
rename to arch/arm/boot/dts/imx31.dtsip
index 454c2d1..aa488ac 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsip
@@ -9,7 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dtsp
similarity index 97%
rename from arch/arm/boot/dts/imx51-apf51.dts
rename to arch/arm/boot/dts/imx51-apf51.dtsp
index 92d3a66..4ef88fc 100644
--- a/arch/arm/boot/dts/imx51-apf51.dts
+++ b/arch/arm/boot/dts/imx51-apf51.dtsp
@@ -15,7 +15,7 @@
  */
 
 /dts-v1/;
-/include/ "imx51.dtsi"
+#include "imx51.dtsip"
 
 / {
 	model = "Armadeus Systems APF51 module";
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dtsp
similarity index 99%
rename from arch/arm/boot/dts/imx51-babbage.dts
rename to arch/arm/boot/dts/imx51-babbage.dtsp
index aab6e43..965a8c8 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx51.dtsi"
+#include "imx51.dtsip"
 
 / {
 	model = "Freescale i.MX51 Babbage Board";
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsip
similarity index 99%
rename from arch/arm/boot/dts/imx51.dtsi
rename to arch/arm/boot/dts/imx51.dtsip
index fcf035b..606a167 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsip
@@ -10,7 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dtsp
similarity index 99%
rename from arch/arm/boot/dts/imx53-ard.dts
rename to arch/arm/boot/dts/imx53-ard.dtsp
index e049fd0..78425a4 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx53.dtsi"
+#include "imx53.dtsip"
 
 / {
 	model = "Freescale i.MX53 Automotive Reference Design Board";
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dtsp
similarity index 99%
rename from arch/arm/boot/dts/imx53-evk.dts
rename to arch/arm/boot/dts/imx53-evk.dtsp
index 85a89b5..20fa799 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx53.dtsi"
+#include "imx53.dtsip"
 
 / {
 	model = "Freescale i.MX53 Evaluation Kit";
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dtsp
similarity index 98%
rename from arch/arm/boot/dts/imx53-mba53.dts
rename to arch/arm/boot/dts/imx53-mba53.dtsp
index 468c0a1..e7bde54 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx53-tqma53.dtsi"
+#include "imx53-tqma53.dtsip"
 
 / {
 	model = "TQ MBa53 starter kit";
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dtsp
similarity index 99%
rename from arch/arm/boot/dts/imx53-qsb.dts
rename to arch/arm/boot/dts/imx53-qsb.dtsp
index 05cc562..37fc83c 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx53.dtsi"
+#include "imx53.dtsip"
 
 / {
 	model = "Freescale i.MX53 Quick Start Board";
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dtsp
similarity index 99%
rename from arch/arm/boot/dts/imx53-smd.dts
rename to arch/arm/boot/dts/imx53-smd.dtsp
index 995554c..c429f44 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx53.dtsi"
+#include "imx53.dtsip"
 
 / {
 	model = "Freescale i.MX53 Smart Mobile Reference Design Board";
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsip
similarity index 99%
rename from arch/arm/boot/dts/imx53-tqma53.dtsi
rename to arch/arm/boot/dts/imx53-tqma53.dtsip
index 8278ec5..af24cb4 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsip
@@ -10,7 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "imx53.dtsi"
+#include "imx53.dtsip"
 
 / {
 	model = "TQ TQMa53";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsip
similarity index 99%
rename from arch/arm/boot/dts/imx53.dtsi
rename to arch/arm/boot/dts/imx53.dtsip
index d05aa21..baea3b5 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsip
@@ -10,7 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsip
similarity index 100%
rename from arch/arm/boot/dts/imx6dl.dtsi
rename to arch/arm/boot/dts/imx6dl.dtsip
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dtsp
similarity index 98%
rename from arch/arm/boot/dts/imx6q-arm2.dts
rename to arch/arm/boot/dts/imx6q-arm2.dtsp
index 53eb241..3028f96 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+#include "imx6q.dtsip"
 
 / {
 	model = "Freescale i.MX6 Quad Armadillo2 Board";
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dtsp
similarity index 98%
rename from arch/arm/boot/dts/imx6q-sabreauto.dts
rename to arch/arm/boot/dts/imx6q-sabreauto.dtsp
index 656d489..4063b90 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+#include "imx6q.dtsip"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Automotive Board";
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dtsp
similarity index 99%
rename from arch/arm/boot/dts/imx6q-sabrelite.dts
rename to arch/arm/boot/dts/imx6q-sabrelite.dtsp
index 2ce355c..c6a7737 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+#include "imx6q.dtsip"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Lite Board";
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dtsp
similarity index 98%
rename from arch/arm/boot/dts/imx6q-sabresd.dts
rename to arch/arm/boot/dts/imx6q-sabresd.dtsp
index bafaccd..306d101 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dtsp
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+#include "imx6q.dtsip"
 
 / {
 	model = "Freescale i.MX6Q SABRE Smart Device Board";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsip
similarity index 99%
rename from arch/arm/boot/dts/imx6q.dtsi
rename to arch/arm/boot/dts/imx6q.dtsip
index 0125250..5ca905c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsip
@@ -8,7 +8,7 @@
  *
  */
 
-/include/ "imx6qdl.dtsi"
+#include "imx6qdl.dtsip"
 
 / {
 	cpus {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsip
similarity index 99%
rename from arch/arm/boot/dts/imx6qdl.dtsi
rename to arch/arm/boot/dts/imx6qdl.dtsip
index 8f34a3cd..52b156f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsip
@@ -10,7 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
-- 
1.7.9.5
