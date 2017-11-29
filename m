From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Wed, 29 Nov 2017 14:48:28 +0200
Subject: [RESEND PATCH v2 04/14] tee: shm: add page accessor functions
In-Reply-To: <1511959718-5421-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1507923164-12796-1-git-send-email-volodymyr_babchuk@epam.com>
 <1511959718-5421-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1511959718-5421-5-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

In order to register a shared buffer in TEE, we need accessor
function that return list of pages for that buffer.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 include/linux/tee_drv.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 0d7f2a5..5489c38 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -394,6 +394,19 @@ static inline size_t tee_shm_get_size(struct tee_shm *shm)
 }
 
 /**
+ * tee_shm_get_pages() - Get list of pages that hold shared buffer
+ * @shm:	Shared memory handle
+ * @num_pages:	Number of pages will be stored there
+ * @returns pointer to pages array
+ */
+static inline struct page **tee_shm_get_pages(struct tee_shm *shm,
+					      size_t *num_pages)
+{
+	*num_pages = shm->num_pages;
+	return shm->pages;
+}
+
+/**
  * tee_shm_get_page_offset() - Get shared buffer offset from page start
  * @shm:	Shared memory handle
  * @returns page offset of shared buffer
-- 
2.7.4
