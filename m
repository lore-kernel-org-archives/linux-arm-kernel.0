From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 15:21:11 -0700
Subject: [PATCH 6/9] ARM: tegra: use pre-processor for all device trees
In-Reply-To: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360794071-29629-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This enables a C pre-processor pass on all Tegra device trees. This
allows future use of #defines and header files in order to define names
for various constants, such as the IDs and flags in GPIO specifiers.
Use of those features will increase the readability of the device tree
files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/{tegra114-dalmore.dts => tegra114-dalmore.dtsp}    |    2 +-
 arch/arm/boot/dts/{tegra114-pluto.dts => tegra114-pluto.dtsp}        |    2 +-
 arch/arm/boot/dts/{tegra114.dtsi => tegra114.dtsip}                  |    2 +-
 .../boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri-512.dtsip} |    2 +-
 arch/arm/boot/dts/{tegra20-harmony.dts => tegra20-harmony.dtsp}      |    2 +-
 arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-iris-512.dtsp}    |    2 +-
 .../boot/dts/{tegra20-medcom-wide.dts => tegra20-medcom-wide.dtsp}   |    2 +-
 arch/arm/boot/dts/{tegra20-paz00.dts => tegra20-paz00.dtsp}          |    2 +-
 arch/arm/boot/dts/{tegra20-plutux.dts => tegra20-plutux.dtsp}        |    2 +-
 arch/arm/boot/dts/{tegra20-seaboard.dts => tegra20-seaboard.dtsp}    |    2 +-
 arch/arm/boot/dts/{tegra20-tamonten.dtsi => tegra20-tamonten.dtsip}  |    2 +-
 arch/arm/boot/dts/{tegra20-tec.dts => tegra20-tec.dtsp}              |    2 +-
 arch/arm/boot/dts/{tegra20-trimslice.dts => tegra20-trimslice.dtsp}  |    2 +-
 arch/arm/boot/dts/{tegra20-ventana.dts => tegra20-ventana.dtsp}      |    2 +-
 arch/arm/boot/dts/{tegra20-whistler.dts => tegra20-whistler.dtsp}    |    2 +-
 arch/arm/boot/dts/{tegra20.dtsi => tegra20.dtsip}                    |    2 +-
 arch/arm/boot/dts/{tegra30-beaver.dts => tegra30-beaver.dtsp}        |    2 +-
 .../arm/boot/dts/{tegra30-cardhu-a02.dts => tegra30-cardhu-a02.dtsp} |    2 +-
 .../arm/boot/dts/{tegra30-cardhu-a04.dts => tegra30-cardhu-a04.dtsp} |    2 +-
 arch/arm/boot/dts/{tegra30-cardhu.dtsi => tegra30-cardhu.dtsip}      |    2 +-
 arch/arm/boot/dts/{tegra30.dtsi => tegra30.dtsip}                    |    2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)
 rename arch/arm/boot/dts/{tegra114-dalmore.dts => tegra114-dalmore.dtsp} (91%)
 rename arch/arm/boot/dts/{tegra114-pluto.dts => tegra114-pluto.dtsp} (91%)
 rename arch/arm/boot/dts/{tegra114.dtsi => tegra114.dtsip} (99%)
 rename arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri-512.dtsip} (99%)
 rename arch/arm/boot/dts/{tegra20-harmony.dts => tegra20-harmony.dtsp} (99%)
 rename arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-iris-512.dtsp} (97%)
 rename arch/arm/boot/dts/{tegra20-medcom-wide.dts => tegra20-medcom-wide.dtsp} (97%)
 rename arch/arm/boot/dts/{tegra20-paz00.dts => tegra20-paz00.dtsp} (99%)
 rename arch/arm/boot/dts/{tegra20-plutux.dts => tegra20-plutux.dtsp} (96%)
 rename arch/arm/boot/dts/{tegra20-seaboard.dts => tegra20-seaboard.dtsp} (99%)
 rename arch/arm/boot/dts/{tegra20-tamonten.dtsi => tegra20-tamonten.dtsip} (99%)
 rename arch/arm/boot/dts/{tegra20-tec.dts => tegra20-tec.dtsp} (96%)
 rename arch/arm/boot/dts/{tegra20-trimslice.dts => tegra20-trimslice.dtsp} (99%)
 rename arch/arm/boot/dts/{tegra20-ventana.dts => tegra20-ventana.dtsp} (99%)
 rename arch/arm/boot/dts/{tegra20-whistler.dts => tegra20-whistler.dtsp} (99%)
 rename arch/arm/boot/dts/{tegra20.dtsi => tegra20.dtsip} (99%)
 rename arch/arm/boot/dts/{tegra30-beaver.dts => tegra30-beaver.dtsp} (99%)
 rename arch/arm/boot/dts/{tegra30-cardhu-a02.dts => tegra30-cardhu-a02.dtsp} (98%)
 rename arch/arm/boot/dts/{tegra30-cardhu-a04.dts => tegra30-cardhu-a04.dtsp} (98%)
 rename arch/arm/boot/dts/{tegra30-cardhu.dtsi => tegra30-cardhu.dtsip} (99%)
 rename arch/arm/boot/dts/{tegra30.dtsi => tegra30.dtsip} (99%)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dtsp
similarity index 91%
rename from arch/arm/boot/dts/tegra114-dalmore.dts
rename to arch/arm/boot/dts/tegra114-dalmore.dtsp
index a30aca6..51f67cd 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra114.dtsi"
+#include "tegra114.dtsip"
 
 / {
 	model = "NVIDIA Tegra114 Dalmore evaluation board";
diff --git a/arch/arm/boot/dts/tegra114-pluto.dts b/arch/arm/boot/dts/tegra114-pluto.dtsp
similarity index 91%
rename from arch/arm/boot/dts/tegra114-pluto.dts
rename to arch/arm/boot/dts/tegra114-pluto.dtsp
index 9bea8f5..40a88d1 100644
--- a/arch/arm/boot/dts/tegra114-pluto.dts
+++ b/arch/arm/boot/dts/tegra114-pluto.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra114.dtsi"
+#include "tegra114.dtsip"
 
 / {
 	model = "NVIDIA Tegra114 Pluto evaluation board";
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsip
similarity index 99%
rename from arch/arm/boot/dts/tegra114.dtsi
rename to arch/arm/boot/dts/tegra114.dtsip
index 1dfaf28..d2150f0 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsip
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "nvidia,tegra114";
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsip
similarity index 99%
rename from arch/arm/boot/dts/tegra20-colibri-512.dtsi
rename to arch/arm/boot/dts/tegra20-colibri-512.dtsip
index 4441620..bf8865b 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsip
@@ -1,4 +1,4 @@
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "Toradex Colibri T20 512MB";
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dtsp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-harmony.dts
rename to arch/arm/boot/dts/tegra20-harmony.dtsp
index 61d027f..3fe66c1 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "NVIDIA Tegra20 Harmony evaluation board";
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dtsp
similarity index 97%
rename from arch/arm/boot/dts/tegra20-iris-512.dts
rename to arch/arm/boot/dts/tegra20-iris-512.dtsp
index 52f1103..a0ba0b0 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris-512.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-colibri-512.dtsi"
+#include "tegra20-colibri-512.dtsip"
 
 / {
 	model = "Toradex Colibri T20 512MB on Iris";
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dtsp
similarity index 97%
rename from arch/arm/boot/dts/tegra20-medcom-wide.dts
rename to arch/arm/boot/dts/tegra20-medcom-wide.dtsp
index a2d6d65..6125604 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsip"
 
 / {
 	model = "Avionic Design Medcom-Wide board";
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dtsp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-paz00.dts
rename to arch/arm/boot/dts/tegra20-paz00.dtsp
index 54d6fce..e40d7ee 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "Toshiba AC100 / Dynabook AZ";
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dtsp
similarity index 96%
rename from arch/arm/boot/dts/tegra20-plutux.dts
rename to arch/arm/boot/dts/tegra20-plutux.dtsp
index 2894800..08401b9 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsip"
 
 / {
 	model = "Avionic Design Plutux board";
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dtsp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-seaboard.dts
rename to arch/arm/boot/dts/tegra20-seaboard.dtsp
index 37b3a57..6534a61 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "NVIDIA Seaboard";
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsip
similarity index 99%
rename from arch/arm/boot/dts/tegra20-tamonten.dtsi
rename to arch/arm/boot/dts/tegra20-tamonten.dtsip
index 4766aba..089bbec 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsip
@@ -1,4 +1,4 @@
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "Avionic Design Tamonten SOM";
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dtsp
similarity index 96%
rename from arch/arm/boot/dts/tegra20-tec.dts
rename to arch/arm/boot/dts/tegra20-tec.dtsp
index 402b210..331c81a 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsip"
 
 / {
 	model = "Avionic Design Tamonten Evaluation Carrier";
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dtsp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-trimslice.dts
rename to arch/arm/boot/dts/tegra20-trimslice.dtsp
index 5d79e4f..1f6cd20 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "Compulab TrimSlice board";
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dtsp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-ventana.dts
rename to arch/arm/boot/dts/tegra20-ventana.dtsp
index 425c890..a5ae217 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "NVIDIA Tegra20 Ventana evaluation board";
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dtsp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-whistler.dts
rename to arch/arm/boot/dts/tegra20-whistler.dtsp
index ea57c0f..ee24daa 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsip"
 
 / {
 	model = "NVIDIA Tegra20 Whistler evaluation board";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsip
similarity index 99%
rename from arch/arm/boot/dts/tegra20.dtsi
rename to arch/arm/boot/dts/tegra20.dtsip
index 5916c93..917edd4 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsip
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "nvidia,tegra20";
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dtsp
similarity index 99%
rename from arch/arm/boot/dts/tegra30-beaver.dts
rename to arch/arm/boot/dts/tegra30-beaver.dtsp
index 8ff2ff2..af23c94 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30.dtsi"
+#include "tegra30.dtsip"
 
 / {
 	model = "NVIDIA Tegra30 Beaver evaluation board";
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dtsp
similarity index 98%
rename from arch/arm/boot/dts/tegra30-cardhu-a02.dts
rename to arch/arm/boot/dts/tegra30-cardhu-a02.dtsp
index adc88aa..64b7184 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30-cardhu.dtsi"
+#include "tegra30-cardhu.dtsip"
 
 /* This dts file support the cardhu A02 version of board */
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dtsp
similarity index 98%
rename from arch/arm/boot/dts/tegra30-cardhu-a04.dts
rename to arch/arm/boot/dts/tegra30-cardhu-a04.dtsp
index 08163e1..fc0d771 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dtsp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30-cardhu.dtsi"
+#include "tegra30-cardhu.dtsip"
 
 /* This dts file support the cardhu A04 and later versions of board */
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsip
similarity index 99%
rename from arch/arm/boot/dts/tegra30-cardhu.dtsi
rename to arch/arm/boot/dts/tegra30-cardhu.dtsip
index 1749927..75ff544 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsip
@@ -1,4 +1,4 @@
-/include/ "tegra30.dtsi"
+#include "tegra30.dtsip"
 
 /**
  * This file contains common DT entry for all fab version of Cardhu.
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsip
similarity index 99%
rename from arch/arm/boot/dts/tegra30.dtsi
rename to arch/arm/boot/dts/tegra30.dtsip
index 572a45b..d25975e 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsip
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "nvidia,tegra30";
-- 
1.7.10.4
