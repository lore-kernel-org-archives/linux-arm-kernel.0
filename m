From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:59 +0200
Subject: [PATCH 32/42] ARM: dts: r8a7779: Add clocks for CA9 CPU cores
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <fa9f95a3d1bf827e7b83310e5e5c83f36382e25f.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve hardware description by adding clocks properties to the device
nodes corresponding to the CA9 CPU cores.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index ccef2cfab6e0..e8eb94748b27 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -29,12 +29,14 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			clocks = <&cpg_clocks R8A7779_CLK_Z>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			clocks = <&cpg_clocks R8A7779_CLK_Z>;
 			power-domains = <&sysc R8A7779_PD_ARM1>;
 		};
 		cpu at 2 {
@@ -42,6 +44,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clock-frequency = <1000000000>;
+			clocks = <&cpg_clocks R8A7779_CLK_Z>;
 			power-domains = <&sysc R8A7779_PD_ARM2>;
 		};
 		cpu at 3 {
@@ -49,6 +52,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clock-frequency = <1000000000>;
+			clocks = <&cpg_clocks R8A7779_CLK_Z>;
 			power-domains = <&sysc R8A7779_PD_ARM3>;
 		};
 	};
-- 
2.11.0
