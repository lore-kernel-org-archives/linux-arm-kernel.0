From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 1 Aug 2017 15:03:29 +0800
Subject: [PATCH 1/5] arm: dts: mt2701: Add ethernet device node
In-Reply-To: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
References: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1501571013-22327-2-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add ethernet device node for MT2701

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index f1efdc6..0619b86 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -597,6 +597,30 @@
 		#clock-cells = <1>;
 	};
 
+	eth: ethernet at 1b100000 {
+		compatible = "mediatek,mt2701-eth", "syscon";
+		reg = <0 0x1b100000 0 0x20000>;
+		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 199 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+			 <&ethsys CLK_ETHSYS_ESW>,
+			 <&ethsys CLK_ETHSYS_GP1>,
+			 <&ethsys CLK_ETHSYS_GP2>,
+			 <&apmixedsys CLK_APMIXED_TRGPLL>;
+		clock-names = "ethif", "esw", "gp1", "gp2", "trgpll";
+		resets = <&ethsys MT2701_ETHSYS_FE_RST>,
+			 <&ethsys MT2701_ETHSYS_GMAC_RST>,
+			 <&ethsys MT2701_ETHSYS_PPE_RST>;
+		reset-names = "fe", "gmac", "ppe";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+		mediatek,ethsys = <&ethsys>;
+		mediatek,pctl = <&syscfg_pctl_a>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	bdpsys: syscon at 1c000000 {
 		compatible = "mediatek,mt2701-bdpsys", "syscon";
 		reg = <0 0x1c000000 0 0x1000>;
-- 
1.9.1
