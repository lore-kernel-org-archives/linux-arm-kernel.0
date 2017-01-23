From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 23 Jan 2017 12:53:36 +0100
Subject: [PATCH] char: xilinx_hwicap: Remove pointless local variables
Message-ID: <74883b63b1a4a0273c7d049c2e9d54dfd58ffde3.1485172413.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused variables which generates these warnings:
[linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c:301]: (style)
Variable 'num_writes' is modified but its new value is never used.
[linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c:356]: (style)
Variable 'read_count' is modified but its new value is never used.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/char/xilinx_hwicap/buffer_icap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/buffer_icap.c b/drivers/char/xilinx_hwicap/buffer_icap.c
index 53c3882e4981..35981cae1afa 100644
--- a/drivers/char/xilinx_hwicap/buffer_icap.c
+++ b/drivers/char/xilinx_hwicap/buffer_icap.c
@@ -269,7 +269,6 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
 {
 	int status;
 	s32 buffer_count = 0;
-	s32 num_writes = 0;
 	bool dirty = false;
 	u32 i;
 	void __iomem *base_address = drvdata->base_address;
@@ -298,7 +297,6 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
 		}
 
 		buffer_count = 0;
-		num_writes++;
 		dirty = false;
 	}
 
@@ -328,7 +326,6 @@ int buffer_icap_get_configuration(struct hwicap_drvdata *drvdata, u32 *data,
 {
 	int status;
 	s32 buffer_count = 0;
-	s32 read_count = 0;
 	u32 i;
 	void __iomem *base_address = drvdata->base_address;
 
@@ -353,7 +350,6 @@ int buffer_icap_get_configuration(struct hwicap_drvdata *drvdata, u32 *data,
 			}
 
 			buffer_count = 0;
-			read_count++;
 		}
 
 		/* Copy data from bram */
-- 
1.9.1
