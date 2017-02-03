From: jintack@cs.columbia.edu (Jintack Lim)
Date: Fri,  3 Feb 2017 10:20:02 -0500
Subject: [RFC v4 04/10] KVM: arm/arm64: Add the EL1 physical timer context
In-Reply-To: <1486135208-13415-1-git-send-email-jintack@cs.columbia.edu>
References: <1486135208-13415-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1486135208-13415-5-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EL1 physical timer context.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
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
@@ -75,4 +76,5 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
 void kvm_timer_init_vhe(void);
 
 #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
+#define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
 #endif
-- 
1.9.1
