From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jan 2016 20:42:44 +0900
Subject: [PATCH] ARM: realview: use "depends on" instead of "if" after prompt
Message-ID: <1453722164-23198-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform recently moved to multi-platform, so missed the global
fixup by commit e32465429490 ("ARM: use "depends on" for SoC configs
instead of "if" after prompt").  Fix it now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-realview/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index def40a0..70ab4a2 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,5 +1,6 @@
 menuconfig ARCH_REALVIEW
-	bool "ARM Ltd. RealView family" if ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
+	bool "ARM Ltd. RealView family"
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select COMMON_CLK_VERSATILE
-- 
1.9.1
