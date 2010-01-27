From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 28 Jan 2010 08:34:11 +0900
Subject: [PATCH] ARM: MM: Add ARM_L1_CACHE_SHIFT_BY6 for handle inside each
	ARCH Kconfig
Message-ID: <1264635251-29987-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARM_L1_CACHE_SHIFT_BY6 into arch/arm/Kconfig. Basically,
ARM L1 cache line size is 32Bytes. Therefore, whenever new ARCH which
has 64Bytes L1 cache line size is added, have to set ARM_L1_CACHE_SHIFT
to 6. That is, have to add/modify arch/arm/mm/Kconfig.
This patch is for handle it in each ARCH Kconfig.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig    |    5 +++++
 arch/arm/mm/Kconfig |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a5602ec..c7e98ed 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -161,6 +161,11 @@ config ARCH_MTD_XIP
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	def_bool y
 
+config ARM_L1_CACHE_SHIFT_BY6
+	bool
+	help
+	  Setting ARM L1 cache line size to 64 Bytes.
+
 if OPROFILE
 
 config OPROFILE_ARMV6
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 91617f7..ad0b8d3 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -779,5 +779,5 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT
 	int
-	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
+	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX || ARM_L1_CACHE_SHIFT_BY6
 	default 5
-- 
1.6.2.5
