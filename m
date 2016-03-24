From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Thu, 24 Mar 2016 22:44:24 +0800
Subject: [PATCH v7 05/17] xen: memory : Add new XENMAPSPACE type
 XENMAPSPACE_dev_mmio
In-Reply-To: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1458830676-27075-6-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new type of Xen map space for Dom0 to map device's MMIO region.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 include/xen/interface/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index 2ecfe4f..9aa8988 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -160,6 +160,7 @@ DEFINE_GUEST_HANDLE_STRUCT(xen_machphys_mapping_t);
 #define XENMAPSPACE_gmfn_foreign 4 /* GMFN from another dom,
 				    * XENMEM_add_to_physmap_range only.
 				    */
+#define XENMAPSPACE_dev_mmio     5 /* device mmio region */
 
 /*
  * Sets the GPFN at which a particular page appears in the specified guest's
-- 
2.1.4
