From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 19:08:07 +0900
Subject: [PATCH 02/02] ARM: shmobile: Add r8a7790 CA15 CPU cores and APMU as
 DTS
In-Reply-To: <20130809100744.10827.62207.sendpatchset@w520>
References: <20130809100744.10827.62207.sendpatchset@w520>
Message-ID: <20130809100807.10827.89924.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CA15 CPU cores to r8a7790 for a total of 4 x CA15
and also add an APMU node for SMP power management.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-08-07 20:14:31.000000000 +0900
@@ -24,6 +24,33 @@
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
+	};
+
+	apmu at e6152000 {
+		compatible = "renesas,r8a7790-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x88>;
+		cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
 	};
 
 	gic: interrupt-controller at f1001000 {
