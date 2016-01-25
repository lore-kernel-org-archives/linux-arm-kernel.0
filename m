From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jan 2016 20:40:44 +0900
Subject: [PATCH] ARM: tango: use "depends on" instead of "if" after prompt
Message-ID: <1453722044-23005-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform was recently added, so missed the global fixup by
commit e32465429490 ("ARM: use "depends on" for SoC configs instead
of "if" after prompt").  Fix it now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-tango/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tango/Kconfig b/arch/arm/mach-tango/Kconfig
index d6a3714..ebe15b9 100644
--- a/arch/arm/mach-tango/Kconfig
+++ b/arch/arm/mach-tango/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_TANGO
-	bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
+	bool "Sigma Designs Tango4 (SMP87xx)"
+	depends on ARCH_MULTI_V7
 	# Cortex-A9 MPCore r3p0, PL310 r3p2
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARM_ERRATA_754322
-- 
1.9.1
