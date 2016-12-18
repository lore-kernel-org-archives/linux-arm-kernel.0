From: aaron@atamisk.net (Aaron Moore)
Date: Sun, 18 Dec 2016 00:48:32 -0500
Subject: [PATCH] staging: vc04_services: Fix bracing on single statement blocks
Message-ID: <20161218054822.GA16024@mainline.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix coding style issue caught by checkpatch.pl relating to braces on
single statement blocks. This issue was corrected in 3 locations.

Signed-off-by: Aaron Moore <aaron@atamisk.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index f76f4d7..e0ba0ed 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -80,9 +80,8 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 		return;
 
 	while (queue->write == queue->read + queue->size) {
-		if (down_interruptible(&queue->pop) != 0) {
+		if (down_interruptible(&queue->pop) != 0)
 			flush_signals(current);
-		}
 	}
 
 	/*
@@ -107,9 +106,8 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 VCHIQ_HEADER_T *vchiu_queue_peek(VCHIU_QUEUE_T *queue)
 {
 	while (queue->write == queue->read) {
-		if (down_interruptible(&queue->push) != 0) {
+		if (down_interruptible(&queue->push) != 0)
 			flush_signals(current);
-		}
 	}
 
 	up(&queue->push); // We haven't removed anything from the queue.
@@ -128,9 +126,8 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 	VCHIQ_HEADER_T *header;
 
 	while (queue->write == queue->read) {
-		if (down_interruptible(&queue->push) != 0) {
+		if (down_interruptible(&queue->push) != 0)
 			flush_signals(current);
-		}
 	}
 
 	/*
-- 
2.10.2
