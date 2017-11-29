From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 29 Nov 2017 18:10:36 +0800
Subject: [PATCH 2/3] arm: dts: mt7623: update mmc related nodes with the
 appropriate fallback
In-Reply-To: <cover.1511949769.git.sean.wang@mediatek.com>
References: <cover.1511949769.git.sean.wang@mediatek.com>
Message-ID: <e2ef3ec5c4b6646d3d11aa28b46304c3ff0032ec.1511949769.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The current mmc related nodes should be falling back to MT2701
as the dt-binding defines and which has more appropriate setup
for MT7623.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 0640fb7..343d3b1 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -641,7 +641,7 @@
 
 	mmc0: mmc at 11230000 {
 		compatible = "mediatek,mt7623-mmc",
-			     "mediatek,mt8135-mmc";
+			     "mediatek,mt2701-mmc";
 		reg = <0 0x11230000 0 0x1000>;
 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_MSDC30_0>,
@@ -652,7 +652,7 @@
 
 	mmc1: mmc at 11240000 {
 		compatible = "mediatek,mt7623-mmc",
-			     "mediatek,mt8135-mmc";
+			     "mediatek,mt2701-mmc";
 		reg = <0 0x11240000 0 0x1000>;
 		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_MSDC30_1>,
-- 
2.7.4
