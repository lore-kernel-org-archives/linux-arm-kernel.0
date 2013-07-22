From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 22 Jul 2013 11:40:38 +0800
Subject: [PATCH] ARM64: include: asm: use 'int' instead of 'u32' for variable
 'target' in kvm_host.h.
Message-ID: <51ECA9B6.3010808@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'target' will be set to '-1' in kvm_arch_vcpu_init(), and it need check
'target' whether less than zero or not in kvm_vcpu_initialized().

So need define target as 'int' instead of 'u32', just like ARM has done.


The related warning:

  arch/arm64/kvm/../../../arch/arm/kvm/arm.c:497:2: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/include/asm/kvm_host.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 644d739..0859a4d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -129,7 +129,7 @@ struct kvm_vcpu_arch {
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
 	/* Target CPU and feature flags */
-	u32 target;
+	int target;
 	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
 
 	/* Detect first run of a vcpu */
-- 
1.7.7.6
