From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 Jan 2015 10:32:17 +0100
Subject: [PATCH v4] ARM: mvebu: remove two selects of ARM_ERRATA_753970
Message-ID: <1421659937.9655.16.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970 in v3.2, through
commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
PL310 errata workarounds"). Still, two selects were added in v3.15 that
used the previous name. So these selects have always been nops.

It is clear that the intention here was to select PL310_ERRATA_753970.
But as, apparently, nothing broke for four releases we can assume
PL310_ERRATA_753970 isn't actually needed. So let's not rename these two
selects but just drop them instead.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
v4: Do no bother anymore to rename these selects. I've tried to do that
a few times ever since v3.15-rc1 was released. Last time, v3, was in
https://lkml.org/lkml/2014/9/12/231 . And since the people who
intruduced this issue apparently aren't bothered by it, neither should
I. So just do the safe and easy thing, which is removing these two
selects, as they are nops now.

Done on top of next-20150119.

 arch/arm/mach-mvebu/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index c1e4567a5ab3..e8e5fa25121c 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -37,7 +37,6 @@ config MACH_ARMADA_370
 config MACH_ARMADA_375
 	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_375_CLK
 	select HAVE_ARM_SCU
@@ -52,7 +51,6 @@ config MACH_ARMADA_375
 config MACH_ARMADA_38X
 	bool "Marvell Armada 380/385 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_38X_CLK
 	select HAVE_ARM_SCU
-- 
1.9.3
