From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 16 Feb 2018 17:04:23 +0000
Subject: [PATCH 2/2] arm64: cputype: Silence Sparse warnings
In-Reply-To: <6efdc36edd90ab33506c03fb58946fab1bbddf26.1518800663.git.robin.murphy@arm.com>
References: <6efdc36edd90ab33506c03fb58946fab1bbddf26.1518800663.git.robin.murphy@arm.com>
Message-ID: <69caa31c38c24f5914f809aa0e9607beb9698702.1518800663.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparse makes a fair bit of noise about our MPIDR mask being implicitly
long - let's explicitly describe it as such rather than just relying on
the value forcing automatic promotion.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index be7bd19c87ec..eda8c5f629fc 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -20,7 +20,7 @@
 
 #define MPIDR_UP_BITMASK	(0x1 << 30)
 #define MPIDR_MT_BITMASK	(0x1 << 24)
-#define MPIDR_HWID_BITMASK	0xff00ffffff
+#define MPIDR_HWID_BITMASK	0xff00ffffffUL
 
 #define MPIDR_LEVEL_BITS_SHIFT	3
 #define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
-- 
2.16.1.dirty
