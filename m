From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 May 2014 19:03:59 +0530
Subject: [PATCH 13/17] ARM: dts: dra7: Add dt data for PCIe PHY
In-Reply-To: <1399383244-14556-1-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
Message-ID: <1399383244-14556-14-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added dt data for PCIe PHY as a child node of ocp2scp3.
The documention for this node can be found @ ../bindings/phy/ti-phy.txt.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 0d3c8c0..653b5f6 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -903,6 +903,29 @@
 				clock-names = "sysclk";
 				#phy-cells = <0>;
 			};
+
+			pcie1_phy: pciephy at 4a094000 {
+				compatible = "ti,phy-pipe3-pcie";
+				reg = <0x4A094000 0x80>, /* phy_rx */
+				      <0x4A094400 0x64>; /* phy_tx */
+				reg-names = "phy_rx", "phy_tx";
+				ctrl-module = <&omap_control_pcie1phy>;
+				clocks = <&dpll_pcie_ref_ck>,
+					 <&dpll_pcie_ref_m2ldo_ck>,
+					 <&optfclk_pciephy_32khz>,
+					 <&optfclk_pciephy_clk>,
+					 <&optfclk_pciephy_div_clk>,
+					 <&optfclk_pciephy_div>,
+					 <&apll_pcie_in_clk_mux>,
+					 <&pciesref_acs_clk_ck>;
+				clock-names = "dpll_ref", "dpll_ref_m2",
+					      "wkupclk", "refclk",
+					      "div-clk", "phy-div",
+					      "apll_mux", "refclk_ext";
+				#phy-cells = <0>;
+				ti,hwmods = "pcie1-phy";
+				ti,ext-clk;
+			};
 		};
 
 		omap_dwc3_1 at 48880000 {
-- 
1.7.9.5
