From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 May 2017 17:18:15 +0900
Subject: [PATCH] arm64: dts: uniphier: reserve more memory for LD11/LD20
Message-ID: <1495786695-27954-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reserve enough space below the kernel base.
The assumed address map is:
  80000000 - 80ffffff : for IPP
  81000000 - 81ffffff : for ARM secure
  82000000 -          : for Linux

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 53ede23d68cb..702f5b175456 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -43,7 +43,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/memreserve/ 0x80000000 0x00080000;
+/memreserve/ 0x80000000 0x02000000;
 
 / {
 	compatible = "socionext,uniphier-ld11";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index aa4dad51bf46..f120059e6e24 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -43,7 +43,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/memreserve/ 0x80000000 0x00080000;
+/memreserve/ 0x80000000 0x02000000;
 
 / {
 	compatible = "socionext,uniphier-ld20";
-- 
2.7.4
