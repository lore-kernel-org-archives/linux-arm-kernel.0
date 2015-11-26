From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Nov 2015 13:26:20 +0900
Subject: [PATCH] ARM: shmobile: r8a7793: remove deprecated #gpio-range-cells
Message-ID: <1448511980-12173-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
declares the above property deprecated. That was more than 2 years ago.
Remove it, so it doesn't get copied around needlessly.

Based on similar work for the r8a7791 and r8a7794 by Wolfram Sang.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
* Lightly tested on renesas-devel-20151126-v4.4-rc2
---
 arch/arm/boot/dts/r8a7793.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index cbcda80f4658..4c74a9229e71 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -233,7 +233,6 @@
 	pfc: pfc at e6060000 {
 		compatible = "renesas,pfc-r8a7793";
 		reg = <0 0xe6060000 0 0x250>;
-		#gpio-range-cells = <3>;
 	};
 
 	dmac0: dma-controller at e6700000 {
-- 
2.1.4
