From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 14 Jun 2016 13:38:04 +0200
Subject: [PATCH] ARM: sunxi/dt: make the CHIP inherit from allwinner, sun5i-a13
Message-ID: <1465904284-329-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i-timer driver registers its sched_clock only if the machine is
compatible with "allwinner,sun5i-a13", "allwinner,sun5i-a10s" or
"allwinner,sun4i-a10".
Add the missing "allwinner,sun5i-a13" string to the machine compatible.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 751b1a8..5273c15 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -52,7 +52,7 @@
 
 / {
 	model = "NextThing C.H.I.P.";
-	compatible = "nextthing,chip", "allwinner,sun5i-r8";
+	compatible = "nextthing,chip", "allwinner,sun5i-r8", "allwinner,sun5i-a13";
 
 	aliases {
 		i2c0 = &i2c0;
-- 
2.7.4
