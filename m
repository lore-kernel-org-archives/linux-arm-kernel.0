From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Apr 2017 14:55:18 +0200
Subject: [PATCH 2/5] arm64: renesas: r8a7796: Add external PCIe bus clock
In-Reply-To: <1492779321-23939-1-git-send-email-geert+renesas@glider.be>
References: <1492779321-23939-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1492779321-23939-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the external PCIe bus clock as a zero Hz fixed-frequency clock.
Boards that provide this clock should override it.

Based on r8a7795.dtsi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 101cd41d693a7ab5..8e2aab8b6b103cc9 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -157,6 +157,13 @@
 		clock-frequency = <0>;
 	};
 
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.7.4
