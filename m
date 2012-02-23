From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:23 +0000
Subject: [PATCH-WIP 02/13] xen/arm: introduce privcmp,
 physdev_op and memory_op hypercalls.
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/hypercall.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 04eba1c..5abba48 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -187,4 +187,28 @@ HYPERVISOR_event_channel_op(int cmd, void *arg)
 	return _hypercall2(int, HYPERCALL(event_channel_op), cmd, arg);
 }
 
+static inline unsigned long HYPERVISOR_hvm_op(int op, void *arg)
+{
+       return -ENOSYS;
+}
+
+static inline int
+HYPERVISOR_memory_op(unsigned int cmd, void *arg)
+{
+	return _hypercall2(int, HYPERCALL(memory_op), cmd, arg);
+}
+
+static inline int HYPERVISOR_physdev_op(int cmd, void *arg)
+{
+	return _hypercall2(int, HYPERCALL(physdev_op), cmd, arg);
+}
+
+static inline long privcmd_call(unsigned call,
+		unsigned long a1, unsigned long a2,
+		unsigned long a3, unsigned long a4,
+		unsigned long a5)
+{
+	return _hypercall5(long, call, a1, a2, a3, a4, a5);
+}
+
 #endif /* _ASM_ARM_XEN_HYPERCALL_H */
-- 
1.7.2.5
