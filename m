From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Sep 2017 10:05:41 +0100
Subject: [PATCH v3 5/8] ARM: Kconfig: Kill CONFIG_VECTORS_BASE
In-Reply-To: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1506330344-31556-6-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last user of CONFIG_VECTORS_BASE has gone, so kill it.

Reported-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7888c98..550b5ab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -239,15 +239,6 @@ config NEED_RET_TO_USER
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
1.9.1
