From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:36 +0100
Subject: [PATCH 25/32] arm64: dts: r8a7796: Add Cortex-A57 PMU node
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <9fccf4d6103eeb5db88c1ae026d61b87f722414a.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Enable the performance monitor unit for the Cortex-A57 cores on the
R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index d2a2110fc7fc..454e1292f910 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -252,6 +252,14 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
+		pmu_a57 {
+			compatible = "arm,cortex-a57-pmu";
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-affinity = <&a57_0>,
+					     <&a57_1>;
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a7796-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.7.0.rc3.207.g0ac5344
