From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 12:01:43 +0900
Subject: [PATCH 3/3] arm64: dts: uniphier: add /memreserve/ for spin-table
 release address
In-Reply-To: <1465873303-30754-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465873303-30754-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465873303-30754-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Documentation/arm64/booting.txt says, the cpu-release-addr
location should be reserved.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
index 644025c..c223915 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
@@ -42,6 +42,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+/memreserve/ 0x80000000 0x00000008;	/* cpu-release-addr */
+
 / {
 	compatible = "socionext,ph1-ld20";
 	#address-cells = <2>;
-- 
1.9.1
