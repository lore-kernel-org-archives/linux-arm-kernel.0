From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 10 Jan 2017 14:18:44 +0000
Subject: [RFC PATCH v4 4/5] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class
 cpus
In-Reply-To: <1484057925-23586-1-git-send-email-vladimir.murzin@arm.com>
References: <1484057925-23586-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1484057925-23586-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, we have dedicated non-cacheable region for consistent DMA
operations. However, that region can still be marked as bufferable by
MPU, so it'd be safer to have barriers by default.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 0b79f12..64a1465c 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1029,7 +1029,7 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
-	default y if CPU_V6 || CPU_V6K || CPU_V7
+	default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
 	help
 	  Historically, the kernel has used strongly ordered mappings to
 	  provide DMA coherent memory.  With the advent of ARMv7, mapping
-- 
2.0.0
