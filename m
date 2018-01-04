From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  4 Jan 2018 23:58:46 +0100
Subject: [PATCH] arm64: dts: sprd: remove broken header inclusion
Message-ID: <20180104225906.696789-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The added header inclusion broke the 'allmodconfig' build in
arm-soc, presumably since the file is added in a different tree:

In file included from arch/arm64/boot/dts/sprd/sp9860g-1h10.dts:11:0:
arch/arm64/boot/dts/sprd/sc9860.dtsi:10:10: fatal error: dt-bindings/clock/sprd,sc9860-clk.h: No such file or directory

It turns out we don't actually need to include it at all, so
I'm removing the line again to fix the build.

Fixes: 22f37a242925 ("arm64: dts: add clocks for SC9860")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've added this one as a fixup now.

 arch/arm64/boot/dts/sprd/sc9860.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index bf03da45336a..5dbfb796d9f9 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -7,7 +7,6 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/sprd,sc9860-clk.h>
 #include "whale2.dtsi"
 
 / {
-- 
2.9.0
