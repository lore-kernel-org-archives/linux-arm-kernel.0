From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 28 Jan 2015 17:27:55 +0800
Subject: [PATCH 1/2] dt: bindings: Add Mediatek RTC driver binding document
In-Reply-To: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1422437276-41334-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MT63xx RTC driver binding document.

Signed-off-by: Tianping Fang <tianping.fang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 .../devicetree/bindings/rtc/mediatek,mt63xx-rtc.txt    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/mediatek,mt63xx-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt63xx-rtc.txt b/Documentation/devicetree/bindings/rtc/mediatek,mt63xx-rtc.txt
new file mode 100644
index 0000000..6347d4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/mediatek,mt63xx-rtc.txt
@@ -0,0 +1,18 @@
+Mediatek MT63xx real-time clock
+
+MT63xx is Mediatek PMIC chip series. RTC is one submodule of PMIC chip.
+The RTC maintains seconds counter, also provide alarm function.
+
+Required properties:
+- compatible: Should be "mediatek,mt6397-rtc".
+- reg: base physical address and size of the registers.
+- interrupt-parent: phandle for the interrupt controller
+- interrupts: RTC alarm interrupt.
+
+Examples:
+rtc: rtc at e000 {
+	compatible = "mediatek,mt6397-rtc";
+	reg = <0xe000 0x3e>;
+	interrupt-parent = <&pmic>;
+	interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.8.1.1.dirty
