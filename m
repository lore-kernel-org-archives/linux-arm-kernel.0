From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:26:00 +0800
Subject: [PATCH v2 16/30] arm: dts: mt7623: add crypto engine nodes to the
 mt7623.dtsi file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-17-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add crypto engine nodes to the mt7623.dtsi file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index c4be7a5..ad7c50a 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -505,4 +505,19 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	crypto: crypto at 1b240000 {
+		compatible = "mediatek,mt7623-crypto";
+		reg = <0 0x1b240000 0 0x20000>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+			 <&ethsys CLK_ETHSYS_CRYPTO>;
+		clock-names = "ethif","cryp";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+		status = "disabled";
+	};
 };
-- 
1.9.1
