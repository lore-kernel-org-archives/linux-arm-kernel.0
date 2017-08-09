From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 01:43:29 +0900
Subject: [PATCH 4/6] arm64: dts: uniphier: use cross-arch include instead of
 symlinks
In-Reply-To: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1502297011-30201-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On UniPhier platform, some DTSI files are shared between arm and arm64.
Recently, inclusion of DT material of different architectures has been
supported by the build system level.  Use #include <arm/...>, which
will work without relying on the exact same hierarchy as the kernel.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi      | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 mode change 120000 => 100644 arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
 mode change 120000 => 100644 arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
 mode change 120000 => 100644 arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi

diff --git a/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
deleted file mode 120000
index f42fb6f38bd3..000000000000
--- a/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/uniphier-pinctrl.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
new file mode 100644
index 000000000000..9caabbb8bae3
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
@@ -0,0 +1 @@
+#include <arm/uniphier-pinctrl.dtsi>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
deleted file mode 120000
index 4685a8d89cba..000000000000
--- a/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/uniphier-ref-daughter.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
new file mode 100644
index 000000000000..e66d999d9f5d
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
@@ -0,0 +1 @@
+#include <arm/uniphier-ref-daughter.dtsi>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi b/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
deleted file mode 120000
index 1246db9be2a1..000000000000
--- a/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/uniphier-support-card.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi b/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
new file mode 100644
index 000000000000..28c5b4ed1d95
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
@@ -0,0 +1 @@
+#include <arm/uniphier-support-card.dtsi>
-- 
2.7.4
