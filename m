From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Jul 2011 01:52:01 +0200
Subject: [PATCH 3/7] at91_mci: move register header to drivers
In-Reply-To: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1310687525-22486-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc at vger.kernel.org
---
 drivers/mmc/host/at91_mci.c                        |    3 ++-
 .../include/mach => drivers/mmc/host}/at91_mci.h   |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
 rename {arch/arm/mach-at91/include/mach => drivers/mmc/host}/at91_mci.h (99%)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index d3e6a96..a4aa3af 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -77,7 +77,8 @@
 
 #include <mach/board.h>
 #include <mach/cpu.h>
-#include <mach/at91_mci.h>
+
+#include "at91_mci.h"
 
 #define DRIVER_NAME "at91_mci"
 
diff --git a/arch/arm/mach-at91/include/mach/at91_mci.h b/drivers/mmc/host/at91_mci.h
similarity index 99%
rename from arch/arm/mach-at91/include/mach/at91_mci.h
rename to drivers/mmc/host/at91_mci.h
index 02182c1..eec3a6b 100644
--- a/arch/arm/mach-at91/include/mach/at91_mci.h
+++ b/drivers/mmc/host/at91_mci.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-at91/include/mach/at91_mci.h
+ * drivers/mmc/host/at91_mci.h
  *
  * Copyright (C) 2005 Ivan Kokshaysky
  * Copyright (C) SAN People
-- 
1.7.5.4
