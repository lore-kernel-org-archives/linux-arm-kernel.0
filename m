From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 Jan 2015 18:44:14 +0100
Subject: [PATCH] coresight-etm: remove check for unknown Kconfig macro
Message-ID: <1421689454.9655.58.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CoreSight ETM/PTM driver contains a check for a
CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE macro. But there's no related
Kconfig symbol CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE. Remove that check
and the single line of code it hides.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Cross-compile tested only (on top of next-20150119).

 drivers/coresight/coresight-etm3x.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/coresight/coresight-etm3x.c b/drivers/coresight/coresight-etm3x.c
index 73c36696f1b6..f312dc4dd95c 100644
--- a/drivers/coresight/coresight-etm3x.c
+++ b/drivers/coresight/coresight-etm3x.c
@@ -34,11 +34,7 @@
 
 #include "coresight-etm.h"
 
-#ifdef CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE
-static int boot_enable = 1;
-#else
 static int boot_enable;
-#endif
 module_param_named(
 	boot_enable, boot_enable, int, S_IRUGO
 );
-- 
1.9.3
