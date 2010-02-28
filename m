From: albert_herranz@yahoo.es (Albert Herranz)
Date: Sun, 28 Feb 2010 15:07:59 +0100
Subject: [RFC PATCH v2 6/9] powerpc: add optional per-device dmabounce support
In-Reply-To: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
Message-ID: <1267366082-15248-7-git-send-email-albert_herranz@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the PowerPC architecture for using the generic dmabounce
support on a per-device basis.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/include/asm/device.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 6d94d27..b9a47e8 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -28,6 +28,9 @@ struct dev_archdata {
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
+#ifdef CONFIG_DMABOUNCE
+	struct dmabounce_info	*dmabounce;
+#endif
 };
 
 static inline void dev_archdata_set_node(struct dev_archdata *ad,
-- 
1.6.3.3
