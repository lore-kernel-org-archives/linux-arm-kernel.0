From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Feb 2013 19:20:06 +0000
Subject: [PATCH 3.9-rc1 1/3] ARM: KVM: fix kvm_arch_{prepare,
 commit}_memory_region
In-Reply-To: <1360956008-5925-1-git-send-email-marc.zyngier@arm.com>
References: <1360956008-5925-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1360956008-5925-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f82a8cfe9 (KVM: struct kvm_memory_slot.user_alloc -> bool)
broke the ARM KVM port by changing the prototype of two global
functions.

Apply the same change to fix the compilation breakage.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9ada554..5a93698 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -232,7 +232,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *memslot,
 				   struct kvm_memory_slot old,
 				   struct kvm_userspace_memory_region *mem,
-				   int user_alloc)
+				   bool user_alloc)
 {
 	return 0;
 }
@@ -240,7 +240,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   struct kvm_userspace_memory_region *mem,
 				   struct kvm_memory_slot old,
-				   int user_alloc)
+				   bool user_alloc)
 {
 }
 
-- 
1.8.1.2
