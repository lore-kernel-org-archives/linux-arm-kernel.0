From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 17 Jun 2017 00:31:01 +0800
Subject: [PATCH] arm64: dts: mt6797: fixup build breakage from no such file
Message-ID: <df54b5e599b47ca9a73a0b6f5f9ca2e4139a4a7f.1497630282.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

fixup build error from no such file as the following complains
from branch v4.12-next/dts64 in linux mediatek tree

arch/arm64/boot/dts/mediatek/mt6797.dtsi:15:44: fatal error:
dt-bindings/power/mt6797-power.h: No such file or directory
 #include <dt-bindings/power/mt6797-power.h>

Fixes: 003f5d0c3462 ("arm64: dts: mediatek: add clk and scp nodes for MT6797")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 3512c8e..31088a9f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -12,7 +12,6 @@
  */
 
 #include <dt-bindings/clock/mt6797-clk.h>
-#include <dt-bindings/power/mt6797-power.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-- 
2.7.4
