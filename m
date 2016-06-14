From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 11:59:46 +0900
Subject: [PATCH 3/3] ARM: dts: uniphier: renumber serial aliases for
 Gentil/Vodka boards
In-Reply-To: <1465873186-30658-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465873186-30658-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465873186-30658-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On these two boards, the serial0 is used for inter-chip connection,
so cannot be used for login console.  The serial2 is used instead
for them, but it is tedious to use because upper level deployment
projects must switch login console per board.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts | 8 ++++----
 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
index bf2619e..98d895b 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
@@ -55,13 +55,13 @@
 	};
 
 	chosen {
-		stdout-path = "serial2:115200n8";
+		stdout-path = "serial0:115200n8";
 	};
 
 	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
+		serial0 = &serial2;
+		serial1 = &serial0;
+		serial2 = &serial1;
 		i2c0 = &i2c0;
 		i2c2 = &i2c2;
 		i2c4 = &i2c4;
diff --git a/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts b/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
index 498acac..1fb8bd7 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
@@ -55,13 +55,13 @@
 	};
 
 	chosen {
-		stdout-path = "serial2:115200n8";
+		stdout-path = "serial0:115200n8";
 	};
 
 	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
+		serial0 = &serial2;
+		serial1 = &serial0;
+		serial2 = &serial1;
 		i2c0 = &i2c0;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-- 
1.9.1
