From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:58 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of 'select' in the ux500 platform is a huge mess, we should
not be selecting most of the drivers that are currently selected
there, but rather enable them from the defconfig.

As a fixup for 3.10, let's at least select the dependencies for
the other drivers we already select, to make it consistent.

warning: (UX500_SOC_COMMON) selects AB8500_CORE which has unmet direct dependencies (HAS_IOMEM && GENERIC_HARDIRQS && ABX500_CORE && MFD_DB8500_PRCMU)

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index f66d7de..6a4387e 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -19,6 +19,8 @@ if ARCH_U8500
 config UX500_SOC_COMMON
 	bool
 	default y
+	select ABX500_CORE
+	select AB8500_CORE
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
-- 
1.8.1.2
