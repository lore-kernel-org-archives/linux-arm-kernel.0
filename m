From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:55:50 +0900
Subject: [PATCH 02/02] ARM: shmobile: Add r8a73a4 CA15 CPU cores and APMU as
 DTS
In-Reply-To: <20130807225531.9856.18974.sendpatchset@w520>
References: <20130807225531.9856.18974.sendpatchset@w520>
Message-ID: <20130807225550.9856.13251.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CA15 CPU cores to r8a73a4 for a total of 4 x CA15
and also add an APMU node for SMP power management.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a73a4.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0001/arch/arm/boot/dts/r8a73a4.dtsi
+++ work/arch/arm/boot/dts/r8a73a4.dtsi	2013-08-07 19:20:37.000000000 +0900
@@ -25,6 +25,33 @@
 			reg = <0>;
 			clock-frequency = <1500000000>;
 		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1500000000>;
+		};
+	};
+
+	apmu at e6152000 {
+		compatible = "renesas,r8a73a4-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x88>;
+		cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
 	};
 
 	gic: interrupt-controller at f1001000 {
