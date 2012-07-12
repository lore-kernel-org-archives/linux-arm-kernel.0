From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 12 Jul 2012 11:17:16 +0100
Subject: [PATCH v2] ARM: vexpress: remove automatic errata workaround selection
In-Reply-To: <1342013791-19516-2-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-2-git-send-email-pawel.moll@arm.com>
Message-ID: <1342088236-12797-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

The vexpress Kconfig setup tries to be clever^Whelpful and selects some
errata workarounds for certain revisions of the Cortex-A9 and PL310,
which may be required depending on the core tile.

Since the mach-vexpress can support A5, A7 and A15 coretiles, let's
make errata workaround selection optional.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Kconfig |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Hi Both,

Here it is. I've kept Will's Signed-off-by for now, but it seems to me
Rob should be signing this off. If you don't mind that I'll put Rob's
name in the final version for arm-soc folk.

Cheers!

Pawel

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index cf8730d..fc3730f 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -2,7 +2,8 @@ menu "Versatile Express platform type"
 	depends on ARCH_VEXPRESS
 
 config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
-	bool
+	bool "Enable A5 and A9 only errata work-arounds"
+	default y
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select PL310_ERRATA_753970 if CACHE_PL310
@@ -14,7 +15,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 
 config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
-	select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_SMP
@@ -22,7 +22,6 @@ config ARCH_VEXPRESS_CA9X4
 
 config ARCH_VEXPRESS_DT
 	bool "Device Tree support for Versatile Express platforms"
-	select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	select ARM_GIC
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
-- 
1.7.9.5
