From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  9 Nov 2018 20:03:42 +1300
Subject: [PATCH v6 2/9] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
In-Reply-To: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181109070349.20464-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

The macro name is too generic, so add a AURORA_ prefix.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/include/asm/hardware/cache-aurora-l2.h | 2 +-
 arch/arm/mm/cache-l2x0.c                        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
index c86124769831..dc5c479ec4c3 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -41,7 +41,7 @@
 #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
 	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
 
-#define MAX_RANGE_SIZE		1024
+#define AURORA_MAX_RANGE_SIZE	1024
 
 #define AURORA_WAY_SIZE_SHIFT	2
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index a00d6f7fd34c..7d2d2a3c67d0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1364,8 +1364,8 @@ static unsigned long aurora_range_end(unsigned long start, unsigned long end)
 	 * since cache range operations stall the CPU pipeline
 	 * until completion.
 	 */
-	if (end > start + MAX_RANGE_SIZE)
-		end = start + MAX_RANGE_SIZE;
+	if (end > start + AURORA_MAX_RANGE_SIZE)
+		end = start + AURORA_MAX_RANGE_SIZE;
 
 	/*
 	 * Cache range operations can't straddle a page boundary.
-- 
2.19.1
