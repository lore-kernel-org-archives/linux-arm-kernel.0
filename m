From: linux@baker-net.org.uk (Adam Baker)
Date: Sun, 02 Jun 2013 22:59:50 +0100
Subject: [PATCH] ARM: Kirkwood add cpus definition needed by cpufreq driver
 to dtsi
Message-ID: <51ABC056.5000804@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood CPU Freq driver needs a CPU definition in order for the probe
routine to activate it. Add a suitable definition to kirkwood.dtsi

This definition is only correct for single core SoCs. There is a dual core
SoC in the kirkwood family (88F632X) but the rest of the Kirkwood drivers in
the kernel don't currently support it. If they ever do the cpus definition
would need to be duplicated in each of the SoC specific include files.

Signed-off-by: Adam Baker <linux@baker-net.org.uk>


--- a/arch/arm/boot/dts/kirkwood.dtsi	2013-05-19 22:57:07.000000000 +0100
+++ b/arch/arm/boot/dts/kirkwood.dtsi	2013-05-30 23:32:18.000000000 +0100
@@ -4,6 +4,18 @@
 	compatible = "marvell,kirkwood";
 	interrupt-parent = <&intc>;
 
+        cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+		      device_type = "cpu";
+		      compatible = "marvell,feroceon";
+		      clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
+		      clock-names = "cpu_clk", "ddrclk", "powersave";
+		};
+	};
+
 	aliases {
 	       gpio0 = &gpio0;
 	       gpio1 = &gpio1;
