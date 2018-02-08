From: ran.wang_1@nxp.com (Ran Wang)
Date: Thu, 8 Feb 2018 15:54:36 +0800
Subject: [PATCH 3/3] arm64: dts: update the cpu idle node
In-Reply-To: <20180208075436.38443-1-ran.wang_1@nxp.com>
References: <20180208075436.38443-1-ran.wang_1@nxp.com>
Message-ID: <20180208075436.38443-3-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuantian Tang <andy.tang@nxp.com>

According to PSCI standard v0.2, for CPU_SUSPEND call, which is
used by cpu idle framework, bit[16] of state parameter must be 0.
So update bit[16] of property 'arm,psci-suspend-param', which is
used as state parameter, to 0.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 15421ef..3463b09 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -84,7 +84,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 18828b9..82ca0d9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -126,7 +126,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 06b5e12..2c56f9d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -122,7 +122,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8ff2688..fa6820b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -130,7 +130,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index aeaef01..0884e1a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -143,7 +143,7 @@
 	CPU_PW20: cpu-pw20 {
 		compatible = "arm,idle-state";
 		idle-state-name = "PW20";
-		arm,psci-suspend-param = <0x00010000>;
+		arm,psci-suspend-param = <0x0>;
 		entry-latency-us = <2000>;
 		exit-latency-us = <2000>;
 		min-residency-us = <6000>;
-- 
1.7.1
