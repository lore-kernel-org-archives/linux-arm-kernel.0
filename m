From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 12 Sep 2016 15:49:21 +0100
Subject: [PATCH v4 07/10] ARM: Introduce MPIDR_LEVEL_SHIFT macro
In-Reply-To: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1473691764-29424-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vgic-v3 driver uses architecture specific MPIDR_LEVEL_SHIFT macro to
encode the affinity in a form compatible with ICC_SGI* registers.
Unfortunately, that macro is missing on ARM, so let's add it.

Cc: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cputype.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 1ee94c7..e2d94c1 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -55,6 +55,7 @@
 
 #define MPIDR_LEVEL_BITS 8
 #define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
+#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
 
 #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
 	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
-- 
1.7.9.5
