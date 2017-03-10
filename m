From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 10 Mar 2017 09:23:58 +0000
Subject: [PATCH v3 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
In-Reply-To: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1489137839-549-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, we have dedicated non-cacheable region for consistent DMA
operations. However, that region can still be marked as bufferable by
MPU, so it'd be safer to have barriers by default.

Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d731f28..7dd46ae 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1050,7 +1050,7 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
-	default y if CPU_V6 || CPU_V6K || CPU_V7
+	default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
 	help
 	  Historically, the kernel has used strongly ordered mappings to
 	  provide DMA coherent memory.  With the advent of ARMv7, mapping
-- 
2.0.0
