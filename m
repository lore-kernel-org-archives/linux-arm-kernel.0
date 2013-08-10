From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 10 Aug 2013 10:05:14 -0300
Subject: [PATCH for v3.12] memory: mvebu-devbus: Remove unused variable
Message-ID: <1376139914-27318-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This variable is not being used anywhere and it's only forgotten
garbage that should have been removed in the previous commit:

  commit 9b6e4c0a58e24c28bd757c9365824a37e80b751c
  Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
  Date:   Fri Jul 26 10:17:38 2013 -0300

  memory: mvebu-devbus: Remove address decoding window workaround

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/memory/mvebu-devbus.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 94c9248..110c036 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -44,14 +44,6 @@
 #define READ_PARAM_OFFSET	0x0
 #define WRITE_PARAM_OFFSET	0x4
 
-static const char * const devbus_wins[] = {
-	"devbus-boot",
-	"devbus-cs0",
-	"devbus-cs1",
-	"devbus-cs2",
-	"devbus-cs3",
-};
-
 struct devbus_read_params {
 	u32 bus_width;
 	u32 badr_skew;
-- 
1.8.1.5
