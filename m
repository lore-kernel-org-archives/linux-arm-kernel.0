From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 16 Sep 2015 10:04:55 +0800
Subject: [PATCH 2/2] arm64: dts: mt8173: add timer node
In-Reply-To: <1442369095-1094-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1442369095-1094-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1442369095-1094-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

Add device node to enable GPT timer. This timer will be
used as sched clock source.

Change-Id: Idc4e3f0ee80b5c36cae6f0f2328f94aafcca1253
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..d763803 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -238,6 +238,15 @@
 			reg = <0 0x10007000 0 0x100>;
 		};
 
+		timer: timer at 10008000 {
+			compatible = "mediatek,mt8173-timer",
+				     "mediatek,mt6577-timer";
+			reg = <0 0x10008000 0 0x1000>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_CLK_13M>,
+				 <&topckgen CLK_TOP_RTC_SEL>;
+		};
+
 		pwrap: pwrap at 1000d000 {
 			compatible = "mediatek,mt8173-pwrap";
 			reg = <0 0x1000d000 0 0x1000>;
-- 
1.9.1
