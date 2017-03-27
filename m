From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 27 Mar 2017 22:38:47 +0800
Subject: [PATCH 2/2] ARM: dts: sun5i: Add interrupt for display backend
In-Reply-To: <20170327143847.16259-1-wens@csie.org>
References: <20170327143847.16259-1-wens@csie.org>
Message-ID: <20170327143847.16259-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display backend on sun5i shares the same interrupt line as the
display frontend. Add it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This won't directly apply to old releases. We may want to backport
them though?

---
 arch/arm/boot/dts/sun5i.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index fc338ce7af79..5175f9cc9bed 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -689,6 +689,7 @@
 		be0: display-backend at 01e60000 {
 			compatible = "allwinner,sun5i-a13-display-backend";
 			reg = <0x01e60000 0x10000>;
+			interrupts = <47>;
 			clocks = <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
 				 <&ccu CLK_DRAM_DE_BE>;
 			clock-names = "ahb", "mod",
-- 
2.11.0
