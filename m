From: will.deacon@arm.com (Will Deacon)
Date: Wed,  1 Feb 2012 13:52:34 +0000
Subject: [PATCH 2/2] ARM: errata: fix PL310 erratum #753970 workaround
 selection
In-Reply-To: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
References: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
Message-ID: <1328104354-7553-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fa0ce403 ("ARM: 7162/1: errata: tidy up Kconfig options for PL310
errata workarounds") introduced a consistent naming scheme for errata
workarounds, but forgot to update the platforms selecting workarounds
using the old names.

This patch updates ux500 and vexpress to select the appropriate PL310
errata workarounds.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ux500/Kconfig    |    2 +-
 arch/arm/mach-vexpress/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index a3e0c86..9c8a9e7 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -5,7 +5,7 @@ config UX500_SOC_COMMON
 	default y
 	select ARM_GIC
 	select HAS_MTU
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_ERRATA_754322
 
 menu "Ux500 SoC"
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9b3d0fb..88c3ba1 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -7,7 +7,7 @@ config ARCH_VEXPRESS_CA9X4
 	select ARM_GIC
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 
-- 
1.7.4.1
