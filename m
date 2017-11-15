From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 15 Nov 2017 13:15:12 +0900
Subject: [URGENT PATCH] arm64: dts: uniphier: route on-board device IRQ to
 GPIO controller for PXs3
Message-ID: <1510719312-22269-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 429f203eb712 ("arm64: dts: uniphier: route on-board device IRQ
to GPIO controller") missed to update this DTS.  It becames a real
problem when arm and arm64 trees are merged together.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd, Olof,

I think you are sending pull-requests for v4.15-rc1 shortly.
Can you apply this on top your arm64 tree?

With DT tree merged in Linus' tree today,
I realized my mistake that was hidden before.

arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dtb: Warning (interrupts_property):
interrupts size is (12), expected multiple of 8 in /soc at 0/system-bus at 58c00000/support-card at 1,1f00000/ethernet at 0

We do not have much time, so I am sending this patch
instead of a pull-reuqest.

Please pick up.


 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index dad4743..864feeb 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -38,7 +38,8 @@
 };
 
 &ethsc {
-	interrupts = <0 52 4>;
+	interrupt-parent = <&gpio>;
+	interrupts = <0 8>;
 };
 
 &serial0 {
-- 
2.7.4
