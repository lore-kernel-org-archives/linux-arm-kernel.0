From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 17 Nov 2017 14:24:46 +0900
Subject: [PATCH 2/4] arm64: dts: uniphier: remove unnecessary interrupt-parent
In-Reply-To: <1510896288-31212-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510896288-31212-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1510896288-31212-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These were added to make the ARM64 branch self-contained because
updates for ARM and ARM64 are supposed to be sent as separate
pull requests.

Now, they were merged together in Linus' tree and interrupt-parent
from the arch/arm/boot/dts/uniphier-support-card.dtsi is visible from
ARM64 DT files by the cross-arch reference.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 1 -
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 1 -
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index dd7193a..6bdefb2 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -40,7 +40,6 @@
 };
 
 &ethsc {
-	interrupt-parent = <&gpio>;
 	interrupts = <0 8>;
 };
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index d99e373..254d679 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -40,7 +40,6 @@
 };
 
 &ethsc {
-	interrupt-parent = <&gpio>;
 	interrupts = <0 8>;
 };
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 864feeb..5c5e9cb 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -38,7 +38,6 @@
 };
 
 &ethsc {
-	interrupt-parent = <&gpio>;
 	interrupts = <0 8>;
 };
 
-- 
2.7.4
