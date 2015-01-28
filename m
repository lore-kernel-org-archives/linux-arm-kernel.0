From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:12 +0100
Subject: [PATCH 05/15] ARM: no longer expose CPU_ARM7TDMI/CPU_ARM9TDMI
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atmel at91x40 is gone, so we no longer have any platform using
either of these two, and we get randconfig failures on NOMMU
kernels if they accidentally get enabled on something that conflicts
with ARMv4T.

This stops short of removing the entire CPU support for now,
but as nothing selects these, it is basically dead code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index bacf3c42857d..f9c9da090554 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -6,7 +6,7 @@ comment "Processor Type"
 
 # ARM7TDMI
 config CPU_ARM7TDMI
-	bool "Support ARM7TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -56,7 +56,7 @@ config CPU_ARM740T
 
 # ARM9TDMI
 config CPU_ARM9TDMI
-	bool "Support ARM9TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
-- 
2.1.0.rc2
