From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:33 +0100
Subject: [PATCH 36/62] ARM: rpc: autoselect CPU_SA110
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-37-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_RPC no longer supports other CPUs aside from StrongARM110,
so we can make the option implicitly selected by the platform
and no longer give the option of building a kernel without CPU
support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig    | 1 +
 arch/arm/mm/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5776c12..4721007 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -696,6 +696,7 @@ config ARCH_RPC
 	select ARCH_MAY_HAVE_PC_FDC
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_USES_GETTIMEOFFSET
+	select CPU_SA110
 	select FIQ
 	select HAVE_IDE
 	select HAVE_PATA_PLATFORM
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index dccd7e1..297b63b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -264,7 +264,7 @@ config CPU_ARM1026
 
 # SA110
 config CPU_SA110
-	bool "Support StrongARM(R) SA-110 processor" if ARCH_RPC
+	bool
 	select CPU_32v3 if ARCH_RPC
 	select CPU_32v4 if !ARCH_RPC
 	select CPU_ABRT_EV4
-- 
1.8.3.2
