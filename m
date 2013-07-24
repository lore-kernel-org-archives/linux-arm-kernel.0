From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Jul 2013 16:58:44 -0700
Subject: [PATCH] ARM: omap2: Only select errata 798181 if SMP
Message-ID: <1374710324-24347-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoids the following warning when SMP is off:

warning: (ARCH_KEYSTONE && SOC_OMAP5) selects ARM_ERRATA_798181 which
has unmet direct dependencies (CPU_V7 && SMP)

Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---

Since this is trivial I've already applied it to fixes on arm-soc.

 arch/arm/mach-omap2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 627fa7e..3eed000 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -62,7 +62,7 @@ config SOC_OMAP5
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
-	select ARM_ERRATA_798181
+	select ARM_ERRATA_798181 if SMP
 
 config SOC_AM33XX
 	bool "AM33XX support"
-- 
1.8.1.192.gc4361b8
