From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:08 +0900
Subject: [PATCH 03/10] ARM: shmobile: r8a7778: Update DTS to include CPU
 frequency
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
Message-ID: <869f92aed207f2f6e595ea41c841bd9ad0c0d0d4.1408927601.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the r8a7778 DTS file. This
will allow us to use the shared C code on r8a7778 and BockW
which reads out the clock frequency from DT and calculates the
delay settings from there.

Also add other missing CPU information to the r8a7778 DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index ecfdf4b..315ec62 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -23,8 +23,14 @@
 	interrupt-parent = <&gic>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clock-frequency = <800000000>;
 		};
 	};
 
-- 
2.0.1
