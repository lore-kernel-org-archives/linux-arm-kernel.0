From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 18 Jan 2017 14:00:12 +0800
Subject: [RESEND PATCH 4/6] arm64: dts: mt8173: add a new reference clock for
 usb3 analog phy
In-Reply-To: <1484719214-11989-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1484719214-11989-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1484719214-11989-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a new reference clock which comes from 26M oscillator directly
for SuperSpeed analog phy. and the old one which comes for PLL is
48M for HighSpeed analog phy.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 12e7027..5d1663b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -754,8 +754,8 @@
 		u3phy: usb-phy at 11290000 {
 			compatible = "mediatek,mt8173-u3phy";
 			reg = <0 0x11290000 0 0x800>;
-			clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
-			clock-names = "u3phya_ref";
+			clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>, <&clk26m>;
+			clock-names = "u2ref_clk", "u3ref_clk";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
1.7.9.5
