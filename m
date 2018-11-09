From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  9 Nov 2018 20:03:41 +1300
Subject: [PATCH v6 1/9] ARM: l2c: move cache-aurora-l2.h to asm/hardware
In-Reply-To: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181109070349.20464-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

This include file will be used by the AURORA EDAC code.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/{mm => include/asm/hardware}/cache-aurora-l2.h | 0
 arch/arm/mm/cache-l2x0.c                                | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/{mm => include/asm/hardware}/cache-aurora-l2.h (100%)

diff --git a/arch/arm/mm/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
similarity index 100%
rename from arch/arm/mm/cache-aurora-l2.h
rename to arch/arm/include/asm/hardware/cache-aurora-l2.h
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 808efbb89b88..a00d6f7fd34c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,8 +30,8 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/cache-aurora-l2.h>
 #include "cache-tauros3.h"
-#include "cache-aurora-l2.h"
 
 struct l2c_init_data {
 	const char *type;
-- 
2.19.1
