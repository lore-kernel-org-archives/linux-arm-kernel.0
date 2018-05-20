From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 20 May 2018 19:23:53 +0200
Subject: [PATCH 2/2] ARM: meson: merge Kconfig symbol MACH_MESON8B into
 MACH_MESON8
In-Reply-To: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
References: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180520172353.19256-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there are no differences between the MACH_MESON8 and
MACH_MESON8B Kconfig symbols (except the help text). Since both
platforms are very similar (Meson8b being a slightly updated,
cost-reduced version of Meson8 which even shares some peripherals with
Meson8m2) no notable differences are expected in the future either.

Suggested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/mach-meson/Kconfig | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 2bc630471beb..d51cfda953d4 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -19,14 +19,7 @@ config MACH_MESON6
 	select MESON6_TIMER
 
 config MACH_MESON8
-	bool "Amlogic Meson8 and Meson8m2 SoCs support"
-	default ARCH_MESON
-	select MESON6_TIMER
-	select COMMON_CLK_MESON8B
-	select MESON_IRQ_GPIO
-
-config MACH_MESON8B
-	bool "Amlogic Meson8b SoCs support"
+	bool "Amlogic Meson8, Meson8b and Meson8m2 SoCs support"
 	default ARCH_MESON
 	select MESON6_TIMER
 	select COMMON_CLK_MESON8B
-- 
2.17.0
