From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Thu, 28 Sep 2017 21:04:00 +0300
Subject: [PATCH v1 03/14] tee: shm: add accessors for buffer size and page
 offset
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1506621851-6929-4-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

These two function will be needed for shared memory registration in OP-TEE

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 include/linux/tee_drv.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 49d6361..6ba8b76 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -384,6 +384,26 @@ void *tee_shm_get_va(struct tee_shm *shm, size_t offs);
 int tee_shm_get_pa(struct tee_shm *shm, size_t offs, phys_addr_t *pa);
 
 /**
+ * tee_shm_get_size() - Get size of shared memory buffer
+ * @shm:	Shared memory handle
+ * @returns size of shared memory
+ */
+static inline size_t tee_shm_get_size(struct tee_shm *shm)
+{
+	return shm->size;
+}
+
+/**
+ * tee_shm_get_page_offset() - Get shared buffer offset from page start
+ * @shm:	Shared memory handle
+ * @returns page offset of shared buffer
+ */
+static inline size_t tee_shm_get_page_offset(struct tee_shm *shm)
+{
+	return shm->offset;
+}
+
+/**
  * tee_shm_get_id() - Get id of a shared memory object
  * @shm:	Shared memory handle
  * @returns id
-- 
2.7.4
