From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 19 May 2017 12:25:57 +0800
Subject: [PATCH v10 10/10] arm64: dts: juno: Add Coresight CPU debug nodes
In-Reply-To: <1495167957-14923-1-git-send-email-leo.yan@linaro.org>
References: <1495167957-14923-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1495167957-14923-11-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add Coresight CPU debug nodes for Juno r0, r1 & r2. The CPU
debug areas are mapped at the same address for all revisions,
like the ETM, even though the CPUs have changed from r1 to r2.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.porier@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 54 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    | 24 +++++++++++++++
 arch/arm64/boot/dts/arm/juno-r2.dts    | 24 +++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts       | 24 +++++++++++++++
 4 files changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index bfe7d68..784a80a 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -216,6 +216,15 @@
 		};
 	};
 
+	cpu_debug0: cpu_debug at 22010000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x22010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	funnel at 220c0000 { /* cluster0 funnel */
 		compatible = "arm,coresight-funnel", "arm,primecell";
 		reg = <0 0x220c0000 0 0x1000>;
@@ -266,6 +275,15 @@
 		};
 	};
 
+	cpu_debug1: cpu_debug at 22110000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x22110000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	etm2: etm at 23040000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x23040000 0 0x1000>;
@@ -280,6 +298,15 @@
 		};
 	};
 
+	cpu_debug2: cpu_debug at 23010000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	funnel at 230c0000 { /* cluster1 funnel */
 		compatible = "arm,coresight-funnel", "arm,primecell";
 		reg = <0 0x230c0000 0 0x1000>;
@@ -344,6 +371,15 @@
 		};
 	};
 
+	cpu_debug3: cpu_debug at 23110000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23110000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	etm4: etm at 23240000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x23240000 0 0x1000>;
@@ -358,6 +394,15 @@
 		};
 	};
 
+	cpu_debug4: cpu_debug at 23210000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23210000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	etm5: etm at 23340000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x23340000 0 0x1000>;
@@ -372,6 +417,15 @@
 		};
 	};
 
+	cpu_debug5: cpu_debug at 23310000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23310000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	replicator at 20120000 {
 		compatible = "qcom,coresight-replicator1x", "arm,primecell";
 		reg = <0 0x20120000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 0e8943a..aed6389 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -281,3 +281,27 @@
 &stm_out_port {
 	remote-endpoint = <&csys1_funnel_in_port0>;
 };
+
+&cpu_debug0 {
+	cpu = <&A57_0>;
+};
+
+&cpu_debug1 {
+	cpu = <&A57_1>;
+};
+
+&cpu_debug2 {
+	cpu = <&A53_0>;
+};
+
+&cpu_debug3 {
+	cpu = <&A53_1>;
+};
+
+&cpu_debug4 {
+	cpu = <&A53_2>;
+};
+
+&cpu_debug5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 405e2fb..b39b6d6 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -281,3 +281,27 @@
 &stm_out_port {
 	remote-endpoint = <&csys1_funnel_in_port0>;
 };
+
+&cpu_debug0 {
+	cpu = <&A72_0>;
+};
+
+&cpu_debug1 {
+	cpu = <&A72_1>;
+};
+
+&cpu_debug2 {
+	cpu = <&A53_0>;
+};
+
+&cpu_debug3 {
+	cpu = <&A53_1>;
+};
+
+&cpu_debug4 {
+	cpu = <&A53_2>;
+};
+
+&cpu_debug5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 0220494..c9236c4 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -268,3 +268,27 @@
 		};
 	};
 };
+
+&cpu_debug0 {
+	cpu = <&A57_0>;
+};
+
+&cpu_debug1 {
+	cpu = <&A57_1>;
+};
+
+&cpu_debug2 {
+	cpu = <&A53_0>;
+};
+
+&cpu_debug3 {
+	cpu = <&A53_1>;
+};
+
+&cpu_debug4 {
+	cpu = <&A53_2>;
+};
+
+&cpu_debug5 {
+	cpu = <&A53_3>;
+};
-- 
2.7.4
