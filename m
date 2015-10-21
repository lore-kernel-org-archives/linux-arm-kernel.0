From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 21 Oct 2015 20:36:27 +0900
Subject: [PATCH 1/4] ARM: dts: uniphier: use stdout-path instead of console
In-Reply-To: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1445427390-22750-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specifying both console and stdout-path is redundant.  Add options
":115200n8" to stdout-path and drop "console=ttyS0,115200".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  | 3 +--
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 3 +--
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts | 3 +--
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts | 3 +--
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
index e9722a5..f1e9d40 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -57,8 +57,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &serial0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
index da2d564..5baa9fc 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
@@ -57,8 +57,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &serial0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
index 47e2edb..2462668 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -57,8 +57,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &serial0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
index adcbbc6..b7a03215 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -58,8 +58,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &serial0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
index bcf2e7c..fc7250c 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -57,8 +57,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &serial0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	aliases {
-- 
1.9.1
