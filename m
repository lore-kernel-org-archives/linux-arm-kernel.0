From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:28:31 +0100
Subject: [PATCH 14/55] arm/arm64: KVM: Export __hyp_text_start/end symbols
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare the __hyp_text_start/end symbols in asm/virt.h so that
they can be reused without having to declare them locally.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/virt.h   | 4 ++++
 arch/arm/kvm/mmu.c            | 2 --
 arch/arm64/include/asm/virt.h | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index d4ceaf5..a2e75b8 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -80,6 +80,10 @@ static inline bool is_kernel_in_hyp_mode(void)
 	return false;
 }
 
+/* The section containing the hypervisor idmap text */
+extern char __hyp_idmap_text_start[];
+extern char __hyp_idmap_text_end[];
+
 /* The section containing the hypervisor text */
 extern char __hyp_text_start[];
 extern char __hyp_text_end[];
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 679608f..f004e70 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -32,8 +32,6 @@
 
 #include "trace.h"
 
-extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
-
 static pgd_t *boot_hyp_pgd;
 static pgd_t *hyp_pgd;
 static pgd_t *merged_hyp_pgd;
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index dcbcf8d..88aa8ec 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -82,6 +82,10 @@ extern void verify_cpu_run_el(void);
 static inline void verify_cpu_run_el(void) {}
 #endif
 
+/* The section containing the hypervisor idmap text */
+extern char __hyp_idmap_text_start[];
+extern char __hyp_idmap_text_end[];
+
 /* The section containing the hypervisor text */
 extern char __hyp_text_start[];
 extern char __hyp_text_end[];
-- 
2.8.1
