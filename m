From: labbott@redhat.com (Laura Abbott)
Date: Thu,  2 Mar 2017 13:44:33 -0800
Subject: [RFC PATCH 01/12] staging: android: ion: Remove dmap_cnt
In-Reply-To: <1488491084-17252-1-git-send-email-labbott@redhat.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
Message-ID: <1488491084-17252-2-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



The reference counting of dma_map calls was removed. Remove the
associated counter field as well.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion_priv.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_priv.h b/drivers/staging/android/ion/ion_priv.h
index 5b3059c..46d3ff5 100644
--- a/drivers/staging/android/ion/ion_priv.h
+++ b/drivers/staging/android/ion/ion_priv.h
@@ -44,7 +44,6 @@
  * @lock:		protects the buffers cnt fields
  * @kmap_cnt:		number of times the buffer is mapped to the kernel
  * @vaddr:		the kernel mapping if kmap_cnt is not zero
- * @dmap_cnt:		number of times the buffer is mapped for dma
  * @sg_table:		the sg table for the buffer if dmap_cnt is not zero
  * @pages:		flat array of pages in the buffer -- used by fault
  *			handler and only valid for buffers that are faulted in
@@ -70,7 +69,6 @@ struct ion_buffer {
 	struct mutex lock;
 	int kmap_cnt;
 	void *vaddr;
-	int dmap_cnt;
 	struct sg_table *sg_table;
 	struct page **pages;
 	struct list_head vmas;
-- 
2.7.4
