From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Feb 2017 14:59:17 +0000
Subject: [PATCH 19/25] KVM: arm/arm64: Add the EL1 physical timer context
In-Reply-To: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
References: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1486652363-7696-20-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jintack Lim <jintack@cs.columbia.edu>

Add the EL1 physical timer context.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_arch_timer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index f46fa3b..6445a3d 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -40,6 +40,7 @@ struct arch_timer_context {
 
 struct arch_timer_cpu {
 	struct arch_timer_context	vtimer;
+	struct arch_timer_context	ptimer;
 
 	/* Background timer used when the guest is not running */
 	struct hrtimer			timer;
@@ -75,4 +76,5 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);
 void kvm_timer_init_vhe(void);
 
 #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
+#define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
 #endif
-- 
2.1.4
