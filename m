From: shailendra.capricorn@gmail.com (Shailendra Verma)
Date: Tue, 26 May 2015 01:11:03 +0530
Subject: [PATCH] char:xilinx_hwicap:buffer_icap - change 1/0 to true/false for
 bool type variable in function buffer_icap_set_configuration().
Message-ID: <1432582863-5012-1-git-send-email-shailendra.capricorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable dirty is bool type. Hence assign the variable with
bool value true/false instead of 1/0.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/char/xilinx_hwicap/buffer_icap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/buffer_icap.c b/drivers/char/xilinx_hwicap/buffer_icap.c
index 05d8977..53c3882 100644
--- a/drivers/char/xilinx_hwicap/buffer_icap.c
+++ b/drivers/char/xilinx_hwicap/buffer_icap.c
@@ -270,7 +270,7 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
 	int status;
 	s32 buffer_count = 0;
 	s32 num_writes = 0;
-	bool dirty = 0;
+	bool dirty = false;
 	u32 i;
 	void __iomem *base_address = drvdata->base_address;
 
@@ -279,7 +279,7 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
 
 		/* Copy data to bram */
 		buffer_icap_set_bram(base_address, buffer_count, data[i]);
-		dirty = 1;
+		dirty = true;
 
 		if (buffer_count < XHI_MAX_BUFFER_INTS - 1) {
 			buffer_count++;
@@ -299,7 +299,7 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
 
 		buffer_count = 0;
 		num_writes++;
-		dirty = 0;
+		dirty = false;
 	}
 
 	/* Write unwritten data to ICAP */
-- 
1.7.9.5
