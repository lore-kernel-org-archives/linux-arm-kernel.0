From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 29 Aug 2013 16:16:07 +0300
Subject: [PATCHv6 15/45] ARM: dts: DRA7: Add PCIe related clock nodes
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Message-ID: <1377782197-10611-16-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keerthy <j-keerthy@ti.com>

This patch adds optfclk_pciephy_clk and optfclk_pciephy_div_clk
which are used by PCIe phy. It also adds a mux clock to choose
the source of optfclk_pciephy_div_clk clock.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 397a60a..6a53d3b 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2061,3 +2061,27 @@ vip3_gclk_mux: vip3_gclk_mux at 4a009030 {
 	reg = <0x4a009030 0x4>;
 	bit-mask = <0x1>;
 };
+
+optfclk_pciephy_div: optfclk_pciephy_div at 4a00821c {
+	compatible = "divider-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	bit-mask = <0x100>;
+};
+
+optfclk_pciephy_clk: optfclk_pciephy_clk at 4a0093b0 {
+	compatible = "gate-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0093b0 0x4>;
+	bit-shift = <9>;
+};
+
+optfclk_pciephy_div_clk: optfclk_pciephy_div_clk at 4a0093b0 {
+	compatible = "gate-clock";
+	clocks = <&optfclk_pciephy_div>;
+	#clock-cells = <0>;
+	reg = <0x4a0093b0 0x4>;
+	bit-shift = <10>;
+};
-- 
1.7.9.5
