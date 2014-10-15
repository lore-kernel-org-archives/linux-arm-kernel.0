From: embedded24@evers-fischer.de (Rolf Evers-Fischer)
Date: Wed, 15 Oct 2014 15:29:45 +0200
Subject: [PATCH] arch: arm: mach-shmobile: Remove ARCH_HAS_OPP completely
Message-ID: <1413379785-14468-1-git-send-email-embedded24@evers-fischer.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol ARCH_HAS_OPP became redundant in v3.16: commit
049d595a4db3 ("PM / OPP: Make OPP invisible to users in Kconfig")
removed the only dependency that used it. Setting it had no effect
anymore.

So commit 78c5e0bb145d ("PM / OPP: Remove ARCH_HAS_OPP") removed it. For
some reason that commit did not remove all select statements for that
symbol. These statements are now useless.

Commit adad5621f3e1 ("PM / devfreq: Remove ARCH_HAS_OPP completely")
removed it for devfreq. Remove one from mach-shmobile too.

Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 arch/arm/mach-shmobile/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 21f457b..f59019d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -36,7 +36,6 @@ menuconfig ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_OPP
 
 if ARCH_SHMOBILE_MULTI
 
-- 
1.9.1
