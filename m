From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 17 Nov 2017 14:24:48 +0900
Subject: [PATCH 4/4] arm64: dts: uniphier: add GPIO hog definition for PXs3
In-Reply-To: <1510896288-31212-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510896288-31212-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1510896288-31212-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 15e85695e500 ("arm64: dts: uniphier: add GPIO hog definition")
missed to update the PXs3 DTS for some reason.  Do it now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 5c5e9cb..c36106f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -45,6 +45,14 @@
 	status = "okay";
 };
 
+&gpio {
+	xirq4 {
+		gpio-hog;
+		gpios = <UNIPHIER_GPIO_IRQ(4) 0>;
+		input;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 };
-- 
2.7.4
