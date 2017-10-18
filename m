From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 18 Oct 2017 13:24:37 +0900
Subject: [PATCH 6/6] arm64: dts: uniphier: add GPIO hog definition
In-Reply-To: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1508300677-23190-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt lines from on-board devices are connected to the GPIO
controller.  Add GPIO hogging so that the corresponding GPIO line
is automatically requested.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 8 ++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 77f50fd..dd7193a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -48,6 +48,14 @@
 	status = "okay";
 };
 
+&gpio {
+	xirq0 {
+		gpio-hog;
+		gpios = <120 0>;
+		input;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 1f55fe1..d99e373 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -48,6 +48,14 @@
 	status = "okay";
 };
 
+&gpio {
+	xirq0 {
+		gpio-hog;
+		gpios = <120 0>;
+		input;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 };
-- 
2.7.4
