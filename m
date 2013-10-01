From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 17:13:07 +0900
Subject: [PATCH 08/10] ARM: shmobile: r8a7791 SMP device tree node
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
Message-ID: <20131001081307.4136.88788.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a device node for the r8a7791 secondary CPU core.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0006/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-10-01 16:37:38.000000000 +0900
@@ -25,6 +25,13 @@
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
 	};
 
 	gic: interrupt-controller at f1001000 {
