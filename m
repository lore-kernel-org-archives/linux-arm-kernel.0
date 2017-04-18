From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 18 Apr 2017 18:57:59 +0100
Subject: [PATCH 2/2] arm64: dts: juno: add information about L1 and L2 caches
In-Reply-To: <1492538279-16405-1-git-send-email-sudeep.holla@arm.com>
References: <1492538279-16405-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1492538279-16405-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based cache
information probing") removed mechanism to extract cache information
based on CCSIDR register as the architecture explicitly states no
inference about the actual sizes of caches based on CCSIDR registers.

Commit 9a802431c527 ("arm64: cacheinfo: add support to override cache
levels via device tree") had already provided options to override cache
information from the device tree.

This patch adds the information about L1 and L2 caches on all variants
of Juno platform.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 42 +++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r2.dts | 42 +++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts    | 42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 0033c59a64b5..0e8943ab94d7 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -89,6 +89,12 @@
 			reg = <0x0 0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -100,6 +106,12 @@
 			reg = <0x0 0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -111,6 +123,12 @@
 			reg = <0x0 0x100>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -122,6 +140,12 @@
 			reg = <0x0 0x101>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -133,6 +157,12 @@
 			reg = <0x0 0x102>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -144,6 +174,12 @@
 			reg = <0x0 0x103>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -152,10 +188,16 @@

 		A57_L2: l2-cache0 {
 			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
 		};

 		A53_L2: l2-cache1 {
 			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 	};

diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 218d0e4736a8..405e2fba025b 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -89,6 +89,12 @@
 			reg = <0x0 0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&A72_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -100,6 +106,12 @@
 			reg = <0x0 0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&A72_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -111,6 +123,12 @@
 			reg = <0x0 0x100>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -122,6 +140,12 @@
 			reg = <0x0 0x101>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -133,6 +157,12 @@
 			reg = <0x0 0x102>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -144,6 +174,12 @@
 			reg = <0x0 0x103>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -152,10 +188,16 @@

 		A72_L2: l2-cache0 {
 			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
 		};

 		A53_L2: l2-cache1 {
 			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 	};

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index bb2820ef3d5b..0220494c9b80 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -88,6 +88,12 @@
 			reg = <0x0 0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -99,6 +105,12 @@
 			reg = <0x0 0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -110,6 +122,12 @@
 			reg = <0x0 0x100>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -121,6 +139,12 @@
 			reg = <0x0 0x101>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -132,6 +156,12 @@
 			reg = <0x0 0x102>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -143,6 +173,12 @@
 			reg = <0x0 0x103>;
 			device_type = "cpu";
 			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
@@ -151,10 +187,16 @@

 		A57_L2: l2-cache0 {
 			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
 		};

 		A53_L2: l2-cache1 {
 			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 	};

--
2.7.4
