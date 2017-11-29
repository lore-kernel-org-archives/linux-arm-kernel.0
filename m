From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Wed, 29 Nov 2017 14:08:29 -0500
Subject: [PATCH 11/22] media: mtk-vpu: add description for wdt fields at
 struct mtk_vpu
In-Reply-To: <73497577f67fbb917e40ab4328104ff310a7c356.1511982439.git.mchehab@s-opensource.com>
References: <73497577f67fbb917e40ab4328104ff310a7c356.1511982439.git.mchehab@s-opensource.com>
Message-ID: <51d70fd5c5c5d154674ba93655b4bb333f4cc96e.1511982439.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix those warnings:
  drivers/media/platform/mtk-vpu/mtk_vpu.c:223: warning: No description found for parameter 'wdt'
  drivers/media/platform/mtk-vpu/mtk_vpu.c:223: warning: No description found for parameter 'wdt_refcnt'

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 853d598937f6..1ff6a93262b7 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -181,6 +181,7 @@ struct share_obj {
  * @extmem:		VPU extended memory information
  * @reg:		VPU TCM and configuration registers
  * @run:		VPU initialization status
+ * @wdt:		VPU watchdog workqueue
  * @ipi_desc:		VPU IPI descriptor
  * @recv_buf:		VPU DTCM share buffer for receiving. The
  *			receive buffer is only accessed in interrupt context.
@@ -194,7 +195,7 @@ struct share_obj {
  *			suppose a client is using VPU to decode VP8.
  *			If the other client wants to encode VP8,
  *			it has to wait until VP8 decode completes.
- * @wdt_refcnt		WDT reference count to make sure the watchdog can be
+ * @wdt_refcnt:		WDT reference count to make sure the watchdog can be
  *			disabled if no other client is using VPU service
  * @ack_wq:		The wait queue for each codec and mdp. When sleeping
  *			processes wake up, they will check the condition
-- 
2.14.3
