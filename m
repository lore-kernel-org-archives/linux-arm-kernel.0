From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 17 Apr 2017 18:34:49 +0800
Subject: [PATCH] ARM: sunxi: h3/h5: fix the compatible of R_CCU
Message-ID: <20170417103449.31910-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R_CCU of H3/H5 currently wrongly used A64 R_CCU compatible.

Fix it by changing it to the correct H3 compatible.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 1aeeacb3a884..d0067fec99de 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -558,7 +558,7 @@
 		};
 
 		r_ccu: clock at 1f01400 {
-			compatible = "allwinner,sun50i-a64-r-ccu";
+			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
 			clocks = <&osc24M>, <&osc32k>, <&iosc>;
 			clock-names = "hosc", "losc", "iosc";
-- 
2.12.2
