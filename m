From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  9 May 2018 17:23:23 +0200
Subject: [PATCH v2 2/2] arm64: dts: renesas: r8a77970: Add Cortex-A53 PMU node
In-Reply-To: <1525879403-12207-1-git-send-email-geert+renesas@glider.be>
References: <1525879403-12207-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1525879403-12207-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the performance monitor unit for the Cortex-A53 cores on the
R-Car V3M (r8a77970) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Move the pmu node from the soc subnode to the root node, as it
    doesn't have registers.
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index ccc955e89cea4d32..71157ad893910a97 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -73,6 +73,13 @@
 		clock-frequency = <0>;
 	};
 
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>, <&a53_1>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.7.4
