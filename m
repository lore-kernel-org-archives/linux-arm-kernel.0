From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 19 May 2017 10:46:44 +0100
Subject: [RFC PATCH v2 5/7] ARM: Kconfig: Kill CONFIG_VECTORS_BASE
In-Reply-To: <1495187206-14303-1-git-send-email-vladimir.murzin@arm.com>
References: <1495187206-14303-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1495187206-14303-6-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last user of CONFIG_VECTORS_BASE has gone, so kill it.

Reported-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9eb2529..332b6f2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -236,15 +236,6 @@ config NEED_RET_TO_USER
 config ARCH_MTD_XIP
 	bool
 
-config VECTORS_BASE
-	hex
-	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
-	default DRAM_BASE if REMAP_VECTORS_TO_RAM
-	default 0x00000000
-	help
-	  The base address of exception vectors.  This must be two pages
-	  in size.
-
 config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime" if EMBEDDED
 	default y
-- 
2.0.0
