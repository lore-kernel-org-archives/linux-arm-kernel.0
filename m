From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 17 Oct 2016 12:47:29 +0100
Subject: [PATCH] ARM: dts: mps2: remove skeleton.dtsi include and fix unit
 address warnings
Message-ID: <1476704849-24039-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removale of skeleton.dtsi allows us also to fix the following
warning from the dts compiler:
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

by adding proper unit addresses to the memory nodes.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/boot/dts/mps2-an385.dts |    2 +-
 arch/arm/boot/dts/mps2-an399.dts |    2 +-
 arch/arm/boot/dts/mps2.dtsi      |    4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mps2-an385.dts b/arch/arm/boot/dts/mps2-an385.dts
index 31c374d..aebbebf 100644
--- a/arch/arm/boot/dts/mps2-an385.dts
+++ b/arch/arm/boot/dts/mps2-an385.dts
@@ -59,7 +59,7 @@
 		stdout-path = "serial0:9600n8";
 	};
 
-	memory {
+	memory at 21000000 {
 		device_type = "memory";
 		reg = <0x21000000 0x1000000>;
 	};
diff --git a/arch/arm/boot/dts/mps2-an399.dts b/arch/arm/boot/dts/mps2-an399.dts
index 5e7e5ca..349abf7 100644
--- a/arch/arm/boot/dts/mps2-an399.dts
+++ b/arch/arm/boot/dts/mps2-an399.dts
@@ -59,7 +59,7 @@
 		stdout-path = "serial0:9600n8";
 	};
 
-	memory {
+	memory at 60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x1000000>;
 	};
diff --git a/arch/arm/boot/dts/mps2.dtsi b/arch/arm/boot/dts/mps2.dtsi
index efb8a03..2346739 100644
--- a/arch/arm/boot/dts/mps2.dtsi
+++ b/arch/arm/boot/dts/mps2.dtsi
@@ -42,10 +42,12 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	oscclk0: clk-osc0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
1.7.9.5
