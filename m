From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Sat, 25 Feb 2017 06:54:25 +0100
Subject: [PATCH 2/6] ARM: dts: socfpga: Add unit name to memory nodes
In-Reply-To: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <1488002069-22404-3-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory nodes in Arria5, Cyclone5 and Arria10 do not have a unit name.
This will trigger several warnings like this one (when compiled with
W=1):

Node /memory has a reg or ranges property, but no unit name

Add the corresponding unit name to each node.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       | 2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi        | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 2 +-
 arch/arm/boot/dts/socfpga_vt.dts                   | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index c57e6ce..4d0a729 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -30,7 +30,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index 8672edf..aac4fee 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -26,7 +26,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index 5ecd2ef..7b49395 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -25,7 +25,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
index 6ad3b1eb..3c03da6 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
@@ -21,7 +21,7 @@
 	model = "Aries/DENX MCV";
 	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1 GiB */
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 7ea32c8..155829f 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -26,7 +26,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index a0c90b3b..a4a555c 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -26,7 +26,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index c3d52f2..8e3b017 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -25,7 +25,7 @@
 		bootargs = "console=ttyS0,115200";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
index d69ad29..8860dd2 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
@@ -28,7 +28,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index 363ee62..8931980 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -57,7 +57,7 @@
 		bootargs = "console=ttyS0,115200";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index f9345e0..dfe2193 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -26,7 +26,7 @@
 		bootargs = "console=ttyS0,57600";
 	};
 
-	memory {
+	memory at 0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1 GB */
-- 
2.7.4
