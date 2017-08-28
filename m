From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Aug 2017 13:10:41 +0200
Subject: [PATCH v3 3/3] arm64: dts: realtek: Add RTD1295 RTC node
In-Reply-To: <20170828111041.17946-1-afaerber@suse.de>
References: <20170828111041.17946-1-afaerber@suse.de>
Message-ID: <20170828111041.17946-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTC node to the Realtek RTD1295 Device Tree.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Rebased to no longer depend on reset controller series
 
 v1 -> v2: Unchanged
 
 Depends on the pending clock bindings.
 
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index ab72255f843f..fbbd6456079e 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -164,6 +164,12 @@
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
