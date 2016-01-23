From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 24 Jan 2016 04:23:24 +0900
Subject: [PATCH] ARM: pxa: let PXA27x select PINCTRL
Message-ID: <1453577004-15295-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use the newly added PXA27x pinctrl driver, this commit is needed
as well as commit 4b15ec9d42b2 ("pinctrl: activate pxa architecture").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f096836..35bc0fe 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -618,6 +618,7 @@ config PXA25x
 config PXA27x
 	bool
 	select CPU_XSCALE
+	select PINCTRL
 	help
 	  Select code specific to PXA27x variants
 
-- 
1.9.1
