From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Tue, 28 Feb 2017 16:52:12 +0100
Subject: [PATCH 2/2] ARM: dts: socfpga: Add support for PMU
In-Reply-To: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <1488297132-21553-3-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dual Cortex-A9 MPCore inside socfpga has a standard PMU unit for
each core mapped in the DAP memory space. Add support for it!

Tested with perf on a Cyclone 5 SoC DK.

Reported-by: Alberto Dassatti <alberto.dassatti@heig-vd.ch>
Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Tested-by: Alberto Dassatti <alberto.dassatti@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 478047e..a892de9 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -52,6 +52,15 @@
 		};
 	};
 
+	pmu: pmu at ff111000 {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&intc>;
+		interrupts = <0 176 4>, <0 177 4>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+		reg = <0xff111000 0x1000>,
+		      <0xff113000 0x1000>;
+	};
+
 	intc: intc at fffed000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
2.7.4
