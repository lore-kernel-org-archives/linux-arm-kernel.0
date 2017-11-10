From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri, 10 Nov 2017 10:03:02 +0100
Subject: [PATCH v3 1/7] ARM: l2c: move cache-aurora-l2.h to asm/hardware
In-Reply-To: <20171110090308.21562-1-jlu@pengutronix.de>
References: <20171110090308.21562-1-jlu@pengutronix.de>
Message-ID: <20171110090308.21562-2-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This include file will be used by the AURORA EDAC code.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
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
2.11.0
