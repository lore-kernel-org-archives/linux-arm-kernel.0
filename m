From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 7 Jul 2013 20:35:11 +0800
Subject: [PATCH for linux-3.10.y] ARM: dts: imx: cpus/cpu nodes dts updates
Message-ID: <1373200511-18917-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

commit 7925e89f54fc49bcd1e73f0a65c4a3eb35b9cfb1 upstream.

Commit 1ba9bf0 (ARM: 7762/1: kernel: fix arm_dt_init_cpu_maps() to skip
non-cpu nodes) goes into v3.10 with leaving the dts cpu node update to
the next release (v3.11).  This unfortunately causes a regression on
multi-core system, e.g. i.MX6 Quad, that is only one cpu core will be
brought up by kernel.

CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x80538c18 - 0x80538c88
Brought up 1 CPUs
SMP: Total of 1 processors activated (1581.05 BogoMIPS).

Fix the regression by applying the necessary dts updates.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Greg,

This is a fix for 3.10 stable kernel.  This is my first time to forward
a patch that is already on mainline to stable kernel.  Please let me
know the correct process if what I'm doing here is wrong.

Shawn

 arch/arm/boot/dts/imx23.dtsi  |    8 ++++++--
 arch/arm/boot/dts/imx28.dtsi  |    8 ++++++--
 arch/arm/boot/dts/imx6dl.dtsi |    2 ++
 arch/arm/boot/dts/imx6q.dtsi  |    4 ++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 73fd7d0..587ceef 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -23,8 +23,12 @@
 	};
 
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 600f7cb..4c10a19 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -32,8 +32,12 @@
 	};
 
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 5bcdf3a..62dc781 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -18,12 +18,14 @@
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
 		};
 
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2>;
 		};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 21e6758..dc54a72 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -18,6 +18,7 @@
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
 			operating-points = <
@@ -39,18 +40,21 @@
 
 		cpu@1 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2>;
 		};
 
 		cpu at 2 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <2>;
 			next-level-cache = <&L2>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <3>;
 			next-level-cache = <&L2>;
 		};
-- 
1.7.9.5
