From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 17 Mar 2016 17:57:04 +0800
Subject: [PATCH v6 05/17] xen: memory : Add new XENMAPSPACE type
 XENMAPSPACE_dev_mmio
In-Reply-To: <1458208636-12960-1-git-send-email-zhaoshenglong@huawei.com>
References: <1458208636-12960-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1458208636-12960-6-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

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
2.0.4
