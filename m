From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  4 Aug 2016 13:40:32 +0200
Subject: [PULL 4/8] KVM: Move kvm_setup_default/empty_irq_routing declaration
 in arch specific header
In-Reply-To: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
References: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1470310836-10371-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

kvm_setup_default_irq_routing and kvm_setup_empty_irq_routing are
not used by generic code. So let's move the declarations in x86 irq.h
header instead of kvm_host.h.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Radim Kr?m?? <rkrcmar@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/x86/kvm/irq.h       | 3 +++
 include/linux/kvm_host.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 61ebdc1..035731e 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -120,4 +120,7 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu);
 
 int apic_has_pending_timer(struct kvm_vcpu *vcpu);
 
+int kvm_setup_default_irq_routing(struct kvm *kvm);
+int kvm_setup_empty_irq_routing(struct kvm *kvm);
+
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a15828f..a7eb5c4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1052,8 +1052,6 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
 #define KVM_MAX_IRQ_ROUTES 1024
 #endif
 
-int kvm_setup_default_irq_routing(struct kvm *kvm);
-int kvm_setup_empty_irq_routing(struct kvm *kvm);
 int kvm_set_irq_routing(struct kvm *kvm,
 			const struct kvm_irq_routing_entry *entries,
 			unsigned nr,
-- 
1.9.1
