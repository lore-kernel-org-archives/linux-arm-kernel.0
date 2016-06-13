From: javi.merino@arm.com (Javi Merino)
Date: Mon, 13 Jun 2016 16:15:15 +0100
Subject: [PATCH 2/2] arm64: dts: juno: add thermal zones for scpi sensors
In-Reply-To: <1465830915-16342-1-git-send-email-javi.merino@arm.com>
References: <1465830915-16342-1-git-send-email-javi.merino@arm.com>
Message-ID: <1465830915-16342-3-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The juno dts have entries for the hwmon scpi, let's create thermal zones
for the temperature sensors described in the Juno ARM Development
Platform Implementation Details.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 42 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    | 16 +++++++++++++
 arch/arm64/boot/dts/arm/juno-r2.dts    | 16 +++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index dee2386d3b9b..61ec045125ce 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -125,6 +125,48 @@
 		};
 	};
 
+	thermal-zones {
+		pmic {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&scpi_sensors0 0>;
+		};
+
+		soc {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&scpi_sensors0 3>;
+		};
+
+		big_cluster_thermal_zone: big_cluster {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&scpi_sensors0 21>;
+			status = "disabled";
+		};
+
+		little_cluster_thermal_zone: little_cluster {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&scpi_sensors0 22>;
+			status = "disabled";
+		};
+
+		gpu0_thermal_zone: gpu0 {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&scpi_sensors0 23>;
+			status = "disabled";
+		};
+
+		gpu1_thermal_zone: gpu1 {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&scpi_sensors0 24>;
+			status = "disabled";
+		};
+	};
+
 	/include/ "juno-clocks.dtsi"
 
 	dma at 7ff00000 {
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index d95d9e7e2dc0..0f9c32ae1ce9 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -181,3 +181,19 @@
 &pcie_ctlr {
 	status = "okay";
 };
+
+&big_cluster_thermal_zone {
+	status = "okay";
+};
+
+&little_cluster_thermal_zone {
+	status = "okay";
+};
+
+&gpu0_thermal_zone {
+	status = "okay";
+};
+
+&gpu1_thermal_zone {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 88ecd6182b67..f20cf5654cca 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -181,3 +181,19 @@
 &pcie_ctlr {
 	status = "okay";
 };
+
+&big_cluster_thermal_zone {
+	status = "okay";
+};
+
+&little_cluster_thermal_zone {
+	status = "okay";
+};
+
+&gpu0_thermal_zone {
+	status = "okay";
+};
+
+&gpu1_thermal_zone {
+	status = "okay";
+};
-- 
1.9.1
