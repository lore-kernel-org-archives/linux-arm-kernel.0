From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 28 Apr 2017 14:58:41 +0200
Subject: [PATCH v2 2/5] arm64: dts: r8a7796: Add external PCIe bus clock
In-Reply-To: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
References: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1493384324-29344-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the external PCIe bus clock as a zero Hz fixed-frequency clock.
Boards that provide this clock should override it.

Based on r8a7795.dtsi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Correct one-line summary prefix.
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
