From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Jun 2017 10:56:08 +0100
Subject: [PATCH 8/8] arm64: dts: allwinner: a64: add (unused) MMC clock node
In-Reply-To: <20170630095608.24943-1-andre.przywara@arm.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
Message-ID: <20170630095608.24943-9-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More of a demo than to be really useful as it this adds a clock producer
node for the MMC clock.
This can be used instead of the existing clock driver for driving a clock.
Use cases include providing clock control by hypervisors or driving new
SoCs which don't have an appropriate clock driver in the kernel.
The number here is made explicitly compatible with the in-kernel CCF
numbering, so any consumer can be switched over by just exchaning the
phandle.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 30cad44..6949a70 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -162,6 +162,15 @@
 				clock-indices = <0>;
 				clock-output-names = "cpu_clk";
 			};
+
+			scpi_clk: scpi_clocks {
+				compatible = "arm,scpi-variable-clocks";
+				#clock-cells = <1>;
+				clock-indices = <75>, <76>,
+						<77>;
+				clock-output-names = "mmc0_clk", "mmc1_clk",
+						     "mmc2_clk";
+			};
 		};
 
 		scpi_sensors0: sensors {
-- 
2.9.0
