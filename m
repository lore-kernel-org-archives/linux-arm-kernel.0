From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 15 Oct 2015 20:32:05 +0900
Subject: [PATCH v2] ARM: dts: uniphier: fix IRQ number for devices on PH1-LD6b
 ref board
Message-ID: <1444908725-6069-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ signal from external devices on this board is connected to
the XIRQ4 pin of the SoC.  The IRQ number should be 52, not 50.

Fixes: a5e921b4771f ("ARM: dts: uniphier: add ProXstream2 and PH1-LD6b SoC/board support")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - change IRQ to 52

 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
index 33963ac..f80f772 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
@@ -85,7 +85,7 @@
 };
 
 &ethsc {
-	interrupts = <0 50 4>;
+	interrupts = <0 52 4>;
 };
 
 &serial0 {
-- 
1.9.1
