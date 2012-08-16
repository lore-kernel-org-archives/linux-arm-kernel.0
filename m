From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 16 Aug 2012 16:36:12 +0100
Subject: [PATCH v3 20/25] xen/arm: compile netback
In-Reply-To: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
Message-ID: <1345131377-14713-20-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/arm/include/asm/xen/hypercall.h |   19 +++++++++++++++++++
 drivers/net/xen-netback/netback.c    |    1 +
 drivers/net/xen-netfront.c           |    1 +
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 4ac0624..8a82325 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -47,4 +47,23 @@ unsigned long HYPERVISOR_hvm_op(int op, void *arg);
 int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
 int HYPERVISOR_physdev_op(int cmd, void *arg);
 
+static inline void
+MULTI_update_va_mapping(struct multicall_entry *mcl, unsigned long va,
+			unsigned int new_val, unsigned long flags)
+{
+	BUG();
+}
+
+static inline void
+MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
+		 int count, int *success_count, domid_t domid)
+{
+	BUG();
+}
+
+static inline int
+HYPERVISOR_multicall(void *call_list, int nr_calls)
+{
+	BUG();
+}
 #endif /* _ASM_ARM_XEN_HYPERCALL_H */
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index f4a6fca..ab4f81c 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -40,6 +40,7 @@
 
 #include <net/tcp.h>
 
+#include <xen/xen.h>
 #include <xen/events.h>
 #include <xen/interface/memory.h>
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 3089990..bf4ba2b 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <net/ip.h>
 
+#include <asm/xen/page.h>
 #include <xen/xen.h>
 #include <xen/xenbus.h>
 #include <xen/events.h>
-- 
1.7.2.5
