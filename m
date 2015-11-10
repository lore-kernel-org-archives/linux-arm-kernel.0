From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 11:57:51 +0000
Subject: [PATCH v2 3/7] xen/arm: introduce HYPERVISOR_platform_op on arm and
 arm64
In-Reply-To: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
Message-ID: <1447156675-7418-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v2:
- rename dom0_op to platform_op
---
 arch/arm/include/asm/xen/hypercall.h |    2 ++
 arch/arm/xen/enlighten.c             |    1 +
 arch/arm/xen/hypercall.S             |    1 +
 arch/arm64/xen/hypercall.S           |    1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 712b50e..c3e00d0 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -35,6 +35,7 @@
 
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
+#include <xen/interface/platform.h>
 
 long privcmd_call(unsigned call, unsigned long a1,
 		unsigned long a2, unsigned long a3,
@@ -49,6 +50,7 @@ int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
 int HYPERVISOR_physdev_op(int cmd, void *arg);
 int HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args);
 int HYPERVISOR_tmem_op(void *arg);
+int HYPERVISOR_platform_op(void *arg);
 int HYPERVISOR_multicall(struct multicall_entry *calls, uint32_t nr);
 
 static inline int
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 15621b1..2f57ba3 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -328,5 +328,6 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
 EXPORT_SYMBOL_GPL(privcmd_call);
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index 10fd99c..d4539f4 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -89,6 +89,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
+HYPERCALL1(platform_op);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 8bbe940..f7d5724 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -80,6 +80,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
+HYPERCALL1(platform_op);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
-- 
1.7.10.4
