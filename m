From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:57 +0200
Subject: [PATCH 8/9] ARM: SIRF: select SMP_ON_UP only on SMP builds
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like all other platforms, we can only select SMP_ON_UP if SMP
is also enabled.

warning: (SOC_IMX31 && SOC_IMX35 && ARCH_MARCO) selects
 SMP_ON_UP which has unmet direct dependencies (SMP && !XIP_KERNEL)

Cc: Barry Song <baohua.song@csr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-prima2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 80ca974..6988b11 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -38,7 +38,7 @@ config ARCH_MARCO
 	select CPU_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
-	select SMP_ON_UP
+	select SMP_ON_UP if SMP
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
-- 
1.8.1.2
