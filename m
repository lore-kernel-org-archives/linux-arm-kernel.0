From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 13 Aug 2014 10:11:23 +0800
Subject: [RESEND PATCH v2 3/4] arm: mediatek: Add intpol in mt6589.dtsi
In-Reply-To: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1407895884-18131-4-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add intpol settings for mt6589.
This also correct timer interrupt flag setting. The old setting
works because 6589 boot loader already set polarity for time
interrupt. Without intpol support, the setting was not changed
so gic can get the irq correctly.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/mt6589.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index d0297a0..18df47f 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -76,11 +76,16 @@
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt6577-timer";
 			reg = <0x10008000 0x80>;
-			interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&system_clk>, <&rtc_clk>;
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		intpol: intpol at 10200100 {
+			compatible = "mediatek,mt6577-intpol";
+			reg = <0x10200100 0x1c>;
+		};
+
 		gic: interrupt-controller at 10212000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
-- 
1.8.1.1.dirty
