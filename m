From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 29 Aug 2013 08:22:17 +0900
Subject: [PATCH v2 03/03] ARM: shmobile: Add r8a7790 CA15 CPU cores
In-Reply-To: <20130828232148.7321.45739.sendpatchset@w520>
References: <20130828232148.7321.45739.sendpatchset@w520>
Message-ID: <20130828232217.7321.62854.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CA15 CPU cores to r8a7790 for a total of 4 x CA15.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Got rid of APMU DT node

 arch/arm/boot/dts/r8a7790.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-08-28 21:00:55.000000000 +0900
@@ -24,6 +24,27 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1300000000>;
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
