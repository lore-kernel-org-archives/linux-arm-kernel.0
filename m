From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon,  8 Nov 2010 20:37:48 +0800
Subject: [PATCH 7/9] ARM: mmp: select CPU_PJ4
In-Reply-To: <1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-4-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-5-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289219870-17807-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CPU_PJ4 is shared between PXA95x and MMP2, select CPU_PJ4 in MMP2
configuration.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/Kconfig |    5 +++--
 arch/arm/mm/Kconfig       |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 0711d3b..8b7a053 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -39,6 +39,7 @@ config MACH_TTC_DKB
 
 config MACH_FLINT
 	bool "Marvell's Flint Development Platform"
+	depends on !(CPU_MOHAWK)
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-based
@@ -49,6 +50,7 @@ config MACH_FLINT
 
 config MACH_MARVELL_JASPER
 	bool "Marvell's Jasper Development Platform"
+	depends on !(CPU_MOHAWK)
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-base
@@ -80,8 +82,7 @@ config CPU_PXA910
 
 config CPU_MMP2
 	bool
-	select CPU_V6
-	select CPU_32v6K
+	select CPU_PJ4
 	help
 	  Select code specific to MMP2. MMP2 is ARMv6 compatible.
 endif
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 674aba5..873f042 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -788,7 +788,7 @@ config CACHE_L2X0
 
 config CACHE_TAUROS2
 	bool "Enable the Tauros2 L2 cache controller"
-	depends on (ARCH_DOVE || ARCH_MMP || CPU_PJ4)
+	depends on (ARCH_DOVE || CPU_PJ4)
 	default y
 	select OUTER_CACHE
 	help
-- 
1.5.6.5
