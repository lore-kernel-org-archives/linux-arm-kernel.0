From: stefan@agner.ch (Stefan Agner)
Date: Sun, 26 Jun 2016 01:47:52 -0700
Subject: [PATCH v2 2/5] ARM: dts: imx7d: use imx7s.dtsi as base device tree
In-Reply-To: <20160626084755.21925-1-stefan@agner.ch>
References: <20160626084755.21925-1-stefan@agner.ch>
Message-ID: <20160626084755.21925-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 7 series currently consists of two SoCs: i.MX 7Solo and
7Dual. The former has a subset of features of the latter, hence
use imx7s.dtsi as the new base device tree. To keep diffstat nice,
just move imx7d.dtsi to imx7s.dtsi temporarily and recreate
imx7d.dtsi in a second commit.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts      | 2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts        | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts              | 2 +-
 arch/arm/boot/dts/{imx7d.dtsi => imx7s.dtsi} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/boot/dts/{imx7d.dtsi => imx7s.dtsi} (100%)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 4863451..3942c7d 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -13,7 +13,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-#include "imx7d.dtsi"
+#include "imx7s.dtsi"
 
 / {
 	model = "CompuLab CL-SOM-iMX7";
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index bef394e..8e993cb 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -43,7 +43,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-#include "imx7d.dtsi"
+#include "imx7s.dtsi"
 
 / {
 	model = "Boundary Devices i.MX7 Nitrogen7 Board";
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index d6da506..1286569 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -43,7 +43,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-#include "imx7d.dtsi"
+#include "imx7s.dtsi"
 
 / {
 	model = "Freescale i.MX7 SabreSD Board";
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7d.dtsi
rename to arch/arm/boot/dts/imx7s.dtsi
-- 
2.8.3
