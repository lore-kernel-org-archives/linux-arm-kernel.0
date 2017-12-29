From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:55 +0100
Subject: [PATCH 51/67] set_memory.h: provide set_memory_{en,de}crypted stubs
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-52-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/set_memory.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index e5140648f638..da5178216da5 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -17,4 +17,16 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
+static inline int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+
+static inline int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+#endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
+
 #endif /* _LINUX_SET_MEMORY_H_ */
-- 
2.14.2
