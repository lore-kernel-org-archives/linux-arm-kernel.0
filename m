From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 16 Apr 2016 02:58:58 +0900
Subject: [PATCH] arm64: dts: uniphier: add /memreserve/ for spin-table release
 address
Message-ID: <1460743138-17768-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Documentation/arm64/booting.txt says, the cpu-release-addr
location should be reserved.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
index 651c9d9..90909d2 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
@@ -42,6 +42,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+/memreserve/ 0x80000100 0x00000008;
+
 / {
 	compatible = "socionext,ph1-ld20";
 	#address-cells = <2>;
-- 
1.9.1
