From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Aug 2017 02:33:28 +0200
Subject: [PATCH v2 3/3] arm64: dts: realtek: Add RTD1295 RTC node
In-Reply-To: <20170827003328.28370-1-afaerber@suse.de>
References: <20170827003328.28370-1-afaerber@suse.de>
Message-ID: <20170827003328.28370-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTC node to the Realtek RTD1295 Device Tree.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 
 Depends on the pending clock bindings.
 
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 503e2d5fc334..8ae0949ad89e 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -192,6 +192,12 @@
 			status = "disabled";
 		};
 
+		rtc at 9801b600 {
+			compatible = "realtek,rtd1295-rtc";
+			reg = <0x9801b600 0x100>;
+			clocks = <&clkc RTD1295_CLK_EN_MISC_RTC>;
+		};
+
 		gic: interrupt-controller at ff011000 {
 			compatible = "arm,gic-400";
 			reg = <0xff011000 0x1000>,
-- 
2.12.3
