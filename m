From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 May 2013 13:24:29 -0600
Subject: [PATCH 1/4] ARM: tegra: use #include for all device trees
Message-ID: <1368473072-10145-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Replace /include/ (dtc) with #include (C pre-processor) for all Tegra DT
files, so that gcc -E handles the entire include tree, and hence any of
those files can #include some other file e.g. for constant definitions.

This allows future use of #defines and header files in order to define
names for various constants, such as the IDs and flags in GPIO
specifiers. Use of those features will increase the readability of the
device tree files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This series will need some slight updates when rebased on top of Venu's
USB binding cleanup series, but I figured I may as well send this for
review as early as possible; I'll see if I can post an incremental patch
for the rebase.

 arch/arm/boot/dts/tegra114-dalmore.dts     |    2 +-
 arch/arm/boot/dts/tegra114-pluto.dts       |    2 +-
 arch/arm/boot/dts/tegra114.dtsi            |    2 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi |    2 +-
 arch/arm/boot/dts/tegra20-harmony.dts      |    2 +-
 arch/arm/boot/dts/tegra20-iris-512.dts     |    2 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts  |    2 +-
 arch/arm/boot/dts/tegra20-paz00.dts        |    2 +-
 arch/arm/boot/dts/tegra20-plutux.dts       |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     |    2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi    |    2 +-
 arch/arm/boot/dts/tegra20-tec.dts          |    2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts      |    2 +-
 arch/arm/boot/dts/tegra20-whistler.dts     |    2 +-
 arch/arm/boot/dts/tegra20.dtsi             |    2 +-
 arch/arm/boot/dts/tegra30-beaver.dts       |    2 +-
 arch/arm/boot/dts/tegra30-cardhu-a02.dts   |    2 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts   |    2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |    2 +-
 arch/arm/boot/dts/tegra30.dtsi             |    2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 72c1f27..3c563af 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra114.dtsi"
+#include "tegra114.dtsi"
 
 / {
 	model = "NVIDIA Tegra114 Dalmore evaluation board";
diff --git a/arch/arm/boot/dts/tegra114-pluto.dts b/arch/arm/boot/dts/tegra114-pluto.dts
index 6bbc8ef..d5f8d3e 100644
--- a/arch/arm/boot/dts/tegra114-pluto.dts
+++ b/arch/arm/boot/dts/tegra114-pluto.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra114.dtsi"
+#include "tegra114.dtsi"
 
 / {
 	model = "NVIDIA Tegra114 Pluto evaluation board";
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 629415f..aeeb53b 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "nvidia,tegra114";
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index a573b94..390a4fb 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -1,4 +1,4 @@
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "Toradex Colibri T20 512MB";
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index e7d5de4..3f968f2 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "NVIDIA Tegra20 Harmony evaluation board";
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dts
index 52f1103..248f7ea 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris-512.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-colibri-512.dtsi"
+#include "tegra20-colibri-512.dtsi"
 
 / {
 	model = "Toradex Colibri T20 512MB on Iris";
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index ace2343..d7e32fa 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsi"
 
 / {
 	model = "Avionic Design Medcom-Wide board";
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index e3e0c99..df57639 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "Toshiba AC100 / Dynabook AZ";
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts
index 1a17cc3..508e56a 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsi"
 
 / {
 	model = "Avionic Design Plutux board";
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index cee4c34..368e6fb 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "NVIDIA Seaboard";
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 50b3ec1..eb6ba60 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -1,4 +1,4 @@
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "Avionic Design Tamonten SOM";
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 742f0b3..9a2a6a4 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsi"
 
 / {
 	model = "Avionic Design Tamonten Evaluation Carrier";
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 9cc78a1..cf4fdce 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "Compulab TrimSlice board";
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index dd38f1f..9f9efec 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "NVIDIA Tegra20 Ventana evaluation board";
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index d2567f8..8c415f2 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi"
 
 / {
 	model = "NVIDIA Tegra20 Whistler evaluation board";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 56a9110..ed5f23f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "nvidia,tegra20";
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index b732f7c..b92ab8a 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30.dtsi"
+#include "tegra30.dtsi"
 
 / {
 	model = "NVIDIA Tegra30 Beaver evaluation board";
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
index e392bd2..3934b0f 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30-cardhu.dtsi"
+#include "tegra30-cardhu.dtsi"
 
 /* This dts file support the cardhu A02 version of board */
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index d0db6c7..af3ff7a 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30-cardhu.dtsi"
+#include "tegra30-cardhu.dtsi"
 
 /* This dts file support the cardhu A04 and later versions of board */
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 01b4c26..e54eed2 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -1,4 +1,4 @@
-/include/ "tegra30.dtsi"
+#include "tegra30.dtsi"
 
 /**
  * This file contains common DT entry for all fab version of Cardhu.
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 15ded60..38967fd 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "nvidia,tegra30";
-- 
1.7.10.4
