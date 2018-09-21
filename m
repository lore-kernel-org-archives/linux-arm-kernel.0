From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 18:09:15 +0200
Subject: [PATCH 1/2] arm64: dts: marvell: Add node labels for the cpus
In-Reply-To: <20180921160916.12393-1-gregory.clement@bootlin.com>
References: <20180921160916.12393-1-gregory.clement@bootlin.com>
Message-ID: <20180921160916.12393-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aligned with what we have done for the others nodes. It will also allow
to easily modify the cpu configuration at board (or sub-SoC) level.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-372x.dtsi     |  2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi     |  2 +-
 .../boot/dts/marvell/armada-ap806-dual.dtsi      |  4 ++--
 .../boot/dts/marvell/armada-ap806-quad.dtsi      |  8 ++++----
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi  | 16 ++++++++--------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
index 97558a64e276..6800945a88ad 100644
--- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
@@ -16,7 +16,7 @@
 	compatible = "marvell,armada3720", "marvell,armada3710";
 
 	cpus {
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x1>;
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index d9531e242eb4..179e571ba40e 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -40,7 +40,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
index 64b5e61a698e..d3c0636558ff 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
@@ -15,13 +15,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index 746e792767f5..01ea662afba8 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -15,25 +15,25 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
 			enable-method = "psci";
 		};
-		cpu at 100 {
+		cpu2: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x100>;
 			enable-method = "psci";
 		};
-		cpu at 101 {
+		cpu3: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x101>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi b/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
index 7d00ae78fc79..b788cb63caf2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
@@ -13,49 +13,49 @@
 		#size-cells = <0>;
 		compatible = "marvell,armada-ap810-octa";
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
 			enable-method = "psci";
 		};
-		cpu at 100 {
+		cpu2: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x100>;
 			enable-method = "psci";
 		};
-		cpu at 101 {
+		cpu3: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x101>;
 			enable-method = "psci";
 		};
-		cpu at 200 {
+		cpu4: cpu at 200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x200>;
 			enable-method = "psci";
 		};
-		cpu at 201 {
+		cpu5: cpu at 201 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x201>;
 			enable-method = "psci";
 		};
-		cpu at 300 {
+		cpu6: cpu at 300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x300>;
 			enable-method = "psci";
 		};
-		cpu at 301 {
+		cpu7: cpu at 301 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x301>;
-- 
2.19.0
