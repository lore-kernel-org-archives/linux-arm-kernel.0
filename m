From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 12 Nov 2016 13:30:35 -0200
Subject: [PATCH] ARM: dts: imx: Remove skeleton.dtsi
Message-ID: <1478964635-12298-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As explained by commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark
skeleton.dtsi as deprecated"), including skeleton.dtsi is deprecated.

This fixes the following warning with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx1.dtsi    | 4 +++-
 arch/arm/boot/dts/imx23.dtsi   | 4 +++-
 arch/arm/boot/dts/imx25.dtsi   | 4 +++-
 arch/arm/boot/dts/imx27.dtsi   | 4 +++-
 arch/arm/boot/dts/imx28.dtsi   | 4 +++-
 arch/arm/boot/dts/imx31.dtsi   | 5 +++--
 arch/arm/boot/dts/imx35.dtsi   | 4 +++-
 arch/arm/boot/dts/imx50.dtsi   | 4 +++-
 arch/arm/boot/dts/imx51.dtsi   | 4 +++-
 arch/arm/boot/dts/imx53.dtsi   | 4 +++-
 arch/arm/boot/dts/imx6qdl.dtsi | 5 +++--
 arch/arm/boot/dts/imx6sl.dtsi  | 4 +++-
 arch/arm/boot/dts/imx6sx.dtsi  | 4 +++-
 arch/arm/boot/dts/imx6ul.dtsi  | 4 +++-
 arch/arm/boot/dts/imx7s.dtsi   | 4 +++-
 15 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 22f5d1d..b792eee 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -9,7 +9,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx1-pinfunc.h"
 
 #include <dt-bindings/clock/imx1-clock.h>
@@ -17,6 +16,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8e1543f..ac2a9da 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -9,10 +9,12 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx23-pinfunc.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	interrupt-parent = <&icoll>;
 
 	aliases {
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index af6af87..831d09a 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -9,10 +9,12 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx25-pinfunc.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index f818ea4..9d8b596 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -9,7 +9,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx27-pinfunc.h"
 
 #include <dt-bindings/clock/imx27-clock.h>
@@ -18,6 +17,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 0ad893b..3aabf65 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -10,10 +10,12 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 #include "imx28-pinfunc.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	interrupt-parent = <&icoll>;
 
 	aliases {
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 8d4c0e3..685916e 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -9,9 +9,10 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		serial0 = &uart1;
 		serial1 = &uart2;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index f812d58..9f40e62 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -8,10 +8,12 @@
  * Free Software Foundation.
  */
 
-#include "skeleton.dtsi"
 #include "imx35-pinfunc.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 92a03bc..fe0221e 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -11,11 +11,13 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx50-pinfunc.h"
 #include <dt-bindings/clock/imx5-clock.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index d8efdab..33526ca 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -10,7 +10,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx51-pinfunc.h"
 #include <dt-bindings/clock/imx5-clock.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -18,6 +17,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 88f9e09e..ca51dc0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -10,7 +10,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
 #include "imx53-pinfunc.h"
 #include <dt-bindings/clock/imx5-clock.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -18,6 +17,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 1bbd36f..bc3e12a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -13,9 +13,10 @@
 #include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		can0 = &can1;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 02378db..4fe5d0c 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -8,11 +8,13 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "skeleton.dtsi"
 #include "imx6sl-pinfunc.h"
 #include <dt-bindings/clock/imx6sl-clock.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index bd9fe67..3926eb5 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -11,9 +11,11 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx6sx-pinfunc.h"
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		can0 = &flexcan1;
 		can1 = &flexcan2;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c5c05fd..39845a7 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -11,9 +11,11 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx6ul-pinfunc.h"
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		ethernet0 = &fec1;
 		ethernet1 = &fec2;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 0d7d5ac..51dfcc1 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -46,9 +46,11 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx7d-pinfunc.h"
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
-- 
2.7.4
