From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 5 Nov 2015 17:09:44 +0000
Subject: [PATCH 2/3] xen/arm: introduce HYPERVISOR_dom0_op on arm and arm64
In-Reply-To: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
Message-ID: <1446743385-12848-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/hypercall.h |    2 ++
 arch/arm/xen/enlighten.c             |    1 +
 arch/arm/xen/hypercall.S             |    1 +
 arch/arm64/xen/hypercall.S           |    1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 712b50e..7a8ee15 100644
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
+int HYPERVISOR_dom0_op(void *arg);
 int HYPERVISOR_multicall(struct multicall_entry *calls, uint32_t nr);
 
 static inline int
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index f07383d..b6aea9c 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -359,5 +359,6 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_dom0_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
 EXPORT_SYMBOL_GPL(privcmd_call);
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index 10fd99c..89db58f 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -89,6 +89,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
+HYPERCALL1(dom0_op);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 8bbe940..3840b1a 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -80,6 +80,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
+HYPERCALL1(dom0_op);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
-- 
1.7.10.4
