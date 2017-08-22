From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:50 +0530
Subject: [PATCH v3 01/17] dmaengine: bcm-sba-raid: Minor improvments in
 comments
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does following improvments to comments:
1. Make section comments consistent across the driver by
avoiding " SBA " in some of the comments
2. Add/update few more section comments

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index e41bbc7..76999b7 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -48,7 +48,8 @@
 
 #include "dmaengine.h"
 
-/* SBA command related defines */
+/* ====== Driver macros and defines ===== */
+
 #define SBA_TYPE_SHIFT					48
 #define SBA_TYPE_MASK					GENMASK(1, 0)
 #define SBA_TYPE_A					0x0
@@ -88,6 +89,8 @@
 #define to_sba_device(dchan)		\
 	container_of(dchan, struct sba_device, dma_chan)
 
+/* ===== Driver data structures ===== */
+
 enum sba_request_state {
 	SBA_REQUEST_STATE_FREE = 1,
 	SBA_REQUEST_STATE_ALLOCED = 2,
@@ -164,7 +167,7 @@ struct sba_device {
 	int reqs_free_count;
 };
 
-/* ====== SBA command helper routines ===== */
+/* ====== Command helper routines ===== */
 
 static inline u64 __pure sba_cmd_enc(u64 cmd, u32 val, u32 shift, u32 mask)
 {
@@ -196,7 +199,7 @@ static inline u32 __pure sba_cmd_pq_c_mdata(u32 d, u32 b1, u32 b0)
 	       ((d & SBA_C_MDATA_DNUM_MASK) << SBA_C_MDATA_DNUM_SHIFT);
 }
 
-/* ====== Channel resource management routines ===== */
+/* ====== General helper routines ===== */
 
 static struct sba_request *sba_alloc_request(struct sba_device *sba)
 {
-- 
2.7.4
