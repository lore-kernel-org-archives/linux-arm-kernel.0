From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 15 Nov 2016 15:07:27 +0100
Subject: [PATCH 2/2] ARM: zynq: Fix W=1 dtc 1.4 warnings
In-Reply-To: <2d42e25d7dd03e562e12e71fd037837737115940.1479218844.git.michal.simek@xilinx.com>
References: <2d42e25d7dd03e562e12e71fd037837737115940.1479218844.git.michal.simek@xilinx.com>
Message-ID: <90eca8dfcdcef68ce5fe39f2329c4b61d2662598.1479218844.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch removes these warnings reported by dtc 1.4:
Warning (unit_address_vs_reg): Node /pmu has a reg or ranges property,
but no unit name
Warning (unit_address_vs_reg): Node /fixedregulator at 0 has a unit name,
but no reg property
Warning (unit_address_vs_reg): Node /memory has a reg or ranges
property, but no unit name

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi      | 4 ++--
 arch/arm/boot/dts/zynq-parallella.dts | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts      | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts      | 2 +-
 arch/arm/boot/dts/zynq-zed.dts        | 2 +-
 arch/arm/boot/dts/zynq-zybo.dts       | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index f47a6c1cc752..402b5bbe3b5b 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -42,14 +42,14 @@
 		};
 	};
 
-	pmu {
+	pmu at f8891000 {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 5 4>, <0 6 4>;
 		interrupt-parent = <&intc>;
 		reg = < 0xf8891000 0x1000 0xf8893000 0x1000 >;
 	};
 
-	regulator_vccpint: fixedregulator at 0 {
+	regulator_vccpint: fixedregulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VCCPINT";
 		regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 307ed201d658..64a6390fc501 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -28,7 +28,7 @@
 		serial0 = &uart1;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index e96959b2e67a..0cdad2cc8b78 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -24,7 +24,7 @@
 		serial0 = &uart1;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index be6a986bbbd8..ad4bb06dba25 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -24,7 +24,7 @@
 		serial0 = &uart1;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 7250c1eac7f9..325379f7983c 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -23,7 +23,7 @@
 		serial0 = &uart1;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index d9e0f3e70671..590ec24b8749 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -23,7 +23,7 @@
 		serial0 = &uart1;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x20000000>;
 	};
-- 
1.9.1
