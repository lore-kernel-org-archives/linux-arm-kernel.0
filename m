From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Nov 2012 12:22:49 +0100
Subject: [PATCH 05/10] arn: at91: move at91_tc.h to arch/arm/mach-at91
In-Reply-To: <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352287374-25176-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/{include/mach => }/at91_tc.h |    0
 arch/arm/mach-at91/at91x40_time.c               |    3 ++-
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/arm/mach-at91/{include/mach => }/at91_tc.h (100%)

diff --git a/arch/arm/mach-at91/include/mach/at91_tc.h b/arch/arm/mach-at91/at91_tc.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/at91_tc.h
rename to arch/arm/mach-at91/at91_tc.h
diff --git a/arch/arm/mach-at91/at91x40_time.c b/arch/arm/mach-at91/at91x40_time.c
index ee06d7b..0e57e44 100644
--- a/arch/arm/mach-at91/at91x40_time.c
+++ b/arch/arm/mach-at91/at91x40_time.c
@@ -26,7 +26,8 @@
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <asm/mach/time.h>
-#include <mach/at91_tc.h>
+
+#include "at91_tc.h"
 
 #define at91_tc_read(field) \
 	__raw_readl(AT91_IO_P2V(AT91_TC) + field)
-- 
1.7.10.4
