From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 20 Aug 2017 17:45:59 +0800
Subject: [PATCH 1/4] arm: dts: mediatek: update audio node for mt2701 and
 mt7623
Message-ID: <9c4a8be621ac76594fad303d5d49ed32bd530605.1503222289.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds interrupt-names property in audio node so that
binding can be agnostic of the IRQ order [1][2].

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
CC: Garlic Tseng <garlic.tseng@mediatek.com>
CC: Erin Lo <erin.lo@mediatek.com>
CC: Sean Wang <sean.wang@mediatek.com>
---
[1]https://patchwork.kernel.org/patch/9901225/
[2]https://lkml.org/lkml/2017/8/18/292
---
---
 arch/arm/boot/dts/mt2701.dtsi | 4 +++-
 arch/arm/boot/dts/mt7623.dtsi | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index afe12e5..fd88cbc 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -430,7 +430,9 @@
 		compatible = "mediatek,mt2701-audio";
 		reg = <0 0x11220000 0 0x2000>,
 		      <0 0x112a0000 0 0x20000>;
-		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names	= "afe", "asys";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
 
 		clocks = <&infracfg CLK_INFRA_AUDIO>,
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index ec8a074..381843e 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -544,7 +544,9 @@
 			     "mediatek,mt2701-audio";
 		reg = <0 0x11220000 0 0x2000>,
 		      <0 0x112a0000 0 0x20000>;
-		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names	= "afe", "asys";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
 
 		clocks = <&infracfg CLK_INFRA_AUDIO>,
-- 
1.9.1
