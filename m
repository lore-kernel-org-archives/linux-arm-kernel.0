From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 23 Jun 2014 11:01:44 +0200
Subject: [PATCH v2] ARM: mvebu: rename ARM_ERRATA_753970
In-Reply-To: <20140620205340.GX32514@n2100.arm.linux.org.uk>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com> <1396805315.7723.8.camel@x220>
 <1401094871.25902.20.camel@x220>
 <20140620202100.GG21711@titan.lakedaemon.net>
 <20140620205340.GX32514@n2100.arm.linux.org.uk>
Message-ID: <1403514104.12982.20.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970 in v3.2, through
commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
PL310 errata workarounds"). Two selects were added in v3.15 that still
use the previous name. Rename these.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
v2: redone on top of next-21040623, and therefor on top of commit
a641f3a6abce ("ARM: l2c: fix dependencies on PL310 errata symbols").

Dropped the "if CACHE_PL310" fragments used in v1. No need to use "if
CACHE_L2X0" instead. Both CACHE_PL310 and CACHE_L2X0 will be
(indirectly) selected if MACH_ARMADA_375 or MACH_ARMADA_38X are set.

Tested only with "make ARCH=arm menuconfig". So not compile tested! If
that's not acceptable please let me know. (I have no access to these
machines so runtime testing is not possible for me.)

Perhaps we want something similar for v3.15+ stable. But that would
require a different patch (v1 could probably be used for stable).

 arch/arm/mach-mvebu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 955d4a3afabd..8d4cf4fa118a 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -33,7 +33,7 @@ config MACH_ARMADA_370
 config MACH_ARMADA_375
 	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_375_CLK
 	select HAVE_ARM_SCU
@@ -48,7 +48,7 @@ config MACH_ARMADA_375
 config MACH_ARMADA_38X
 	bool "Marvell Armada 380/385 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_38X_CLK
 	select HAVE_ARM_SCU
-- 
1.9.3
