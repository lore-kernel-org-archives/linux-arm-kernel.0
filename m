From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 15 Jun 2016 13:20:19 +0200
Subject: [PATCH v2] ARM: sunxi/dt: make the CHIP inherit from allwinner,
 sun5i-a13
Message-ID: <1465989619-2337-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i-timer driver registers its sched_clock only if the machine is
compatible with "allwinner,sun5i-a13", "allwinner,sun5i-a10s" or
"allwinner,sun4i-a10".
Add the missing "allwinner,sun5i-a13" string to the machine compatible.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: 5a33893dd079 ("ARM: sunxi/dt: make the CHIP inherit from allwinner,sun5i-a13")
Cc: <stable@vger.kernel.org>
---
Changes since v1:
- added the Fixes and Cc stable tags
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index a8d8b4582397..f694482bdeb6 100644
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
