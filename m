From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 13 Oct 2015 02:54:01 +0300
Subject: [PATCH 1/5] arm: dts: lpc32xx: change include syntax to be C
 preprocessor friendly
In-Reply-To: <1444694045-22000-1-git-send-email-vz@mleia.com>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
Message-ID: <1444694045-22000-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change replaces /include/ to #include in lpc32xx.dtsi and
derivatives, it is required, if C preprocessor is intended to be used
over dtsi/dts files, otherwise errors like one below are generated:

  Error: ea3250.dts:15.1-9 syntax error
  FATAL ERROR: Unable to parse input tree

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/ea3250.dts   | 2 +-
 arch/arm/boot/dts/lpc32xx.dtsi | 2 +-
 arch/arm/boot/dts/phy3250.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/ea3250.dts
index a4ba31b..121d032 100644
--- a/arch/arm/boot/dts/ea3250.dts
+++ b/arch/arm/boot/dts/ea3250.dts
@@ -12,7 +12,7 @@
  */
 
 /dts-v1/;
-/include/ "lpc32xx.dtsi"
+#include "lpc32xx.dtsi"
 
 / {
 	model = "Embedded Artists LPC3250 board based on NXP LPC3250";
diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 3abebb7..f35e982 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -11,7 +11,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "nxp,lpc3220";
diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index 90fdbd7..2a2d2cf 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -12,7 +12,7 @@
  */
 
 /dts-v1/;
-/include/ "lpc32xx.dtsi"
+#include "lpc32xx.dtsi"
 
 / {
 	model = "PHYTEC phyCORE-LPC3250 board based on NXP LPC3250";
-- 
2.1.4
