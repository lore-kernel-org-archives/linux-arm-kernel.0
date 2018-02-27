From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 27 Feb 2018 12:45:19 -0800
Subject: [PATCH] ARM: dts: NSP: Switch to port 8 for CPU port
Message-ID: <20180227204520.24122-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have added support for pre-pended Broadcom tags with commit
11606039604c ("net: dsa: b53: Support prepended Broadcom tags") we can
switch all the Northstar Plus reference boards to use port 8 for the CPU
port. This allows us to prepare room for supporting the Flow Accelerator
2 NAPT offload, and frees up port 5 to be made fully configurable for
the modes that it supports: internal, SGMII, RGMII etc.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958622hr.dts | 6 +++---
 arch/arm/boot/dts/bcm958623hr.dts | 6 +++---
 arch/arm/boot/dts/bcm958625hr.dts | 6 +++---
 arch/arm/boot/dts/bcm958625k.dts  | 6 +++---
 arch/arm/boot/dts/bcm988312hr.dts | 6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index fd8b8c689ffe..ecd05e26c262 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -204,10 +204,10 @@
 			reg = <4>;
 		};
 
-		port at 5 {
-			ethernet = <&amac0>;
+		port at 8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index b8bde13de90a..f5e85b301497 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -208,10 +208,10 @@
 			reg = <4>;
 		};
 
-		port at 5 {
-			ethernet = <&amac0>;
+		port at 8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 6a44b8021702..094db4ba8eb3 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -210,10 +210,10 @@
 			reg = <4>;
 		};
 
-		port at 5 {
-			ethernet = <&amac0>;
+		port at 8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 2cf2392483b2..3ea5f739e90b 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -245,10 +245,10 @@
 			reg = <4>;
 		};
 
-		port at 5 {
-			ethernet = <&amac0>;
+		port at 8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index bce251a68591..ea9a0806b446 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -216,10 +216,10 @@
 			reg = <4>;
 		};
 
-		port at 5 {
-			ethernet = <&amac0>;
+		port at 8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
-- 
2.14.1
