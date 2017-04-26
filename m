From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:25:59 +0800
Subject: [PATCH v2 15/30] arm: dts: mt7623: add ethernet nodes to the
 mt7623.dtsi file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-16-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add ethernet nodes to the mt7623.dtsi file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index cfafaea..c4be7a5 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -485,4 +485,24 @@
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
 	};
+
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
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+		mediatek,ethsys = <&ethsys>;
+		mediatek,pctl = <&syscfg_pctl_a>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.9.1
