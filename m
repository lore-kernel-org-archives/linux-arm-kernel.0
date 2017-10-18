From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 18 Oct 2017 13:24:36 +0900
Subject: [PATCH 5/6] ARM: dts: uniphier: add GPIO hog definition
In-Reply-To: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508300677-23190-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1508300677-23190-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt lines from on-board devices are connected to the GPIO
controller.  Add GPIO hogging so that the corresponding GPIO line
is automatically requested.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts  | 8 ++++++++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts | 8 ++++++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts | 8 ++++++++
 arch/arm/boot/dts/uniphier-sld8-ref.dts | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 148e7bb..0056852 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -53,6 +53,14 @@
 	status = "okay";
 };
 
+&gpio {
+	xirq1 {
+		gpio-hog;
+		gpios = <121 0>;
+		input;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index ec2a098..0e510a7 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -55,6 +55,14 @@
 	status = "okay";
 };
 
+&gpio {
+	xirq4 {
+		gpio-hog;
+		gpios = <124 0>;
+		input;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 7316cc6..be99467 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -55,6 +55,14 @@
 	status = "okay";
 };
 
+&gpio {
+	xirq2 {
+		gpio-hog;
+		gpios = <122 0>;
+		input;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index 4ec48a1..1c0e707 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -53,6 +53,14 @@
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
