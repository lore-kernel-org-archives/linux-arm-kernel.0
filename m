From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 14 May 2015 19:53:26 +0200
Subject: [PATCH v3 6/6] Documentation: dmaengine: document DMA_CTRL_ACK
In-Reply-To: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
References: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1431626006-1708-6-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation about acking the transfers, and their
reusability.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 Documentation/dmaengine/provider.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/dmaengine/provider.txt b/Documentation/dmaengine/provider.txt
index 05d2280..33a81ce 100644
--- a/Documentation/dmaengine/provider.txt
+++ b/Documentation/dmaengine/provider.txt
@@ -345,11 +345,12 @@ where to put them)
       that abstracts it away.
 
   * DMA_CTRL_ACK
-    - Undocumented feature
-    - No one really has an idea of what it's about, besides being
-      related to reusing the DMA transaction descriptors or having
-      additional transactions added to it in the async-tx API
-    - Useless in the case of the slave API
+    - if set, the TX transfer can be reused after being completed.
+    - there is a guarantee the TX won't be freed until it is acked
+      by async_tx_ack()
+    - as a consequence, if a device driver wants to skip the dma_map_sg() and
+      dma_unmap_sg() because the DMA'd data wasn't used, it can resubmit the
+      transfer right after its completion.
 
 General Design Notes
 --------------------
-- 
2.1.4
