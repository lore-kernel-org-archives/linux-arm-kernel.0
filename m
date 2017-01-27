From: jintack@cs.columbia.edu (Jintack Lim)
Date: Thu, 26 Jan 2017 20:04:54 -0500
Subject: [RFC v2 04/10] KVM: arm/arm64: Add the EL1 physical timer context
In-Reply-To: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1485479100-4966-5-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EL1 physical timer context.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 include/kvm/arm_arch_timer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index d921d20..69f648b 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -40,6 +40,7 @@ struct arch_timer_context {
 
 struct arch_timer_cpu {
 	struct arch_timer_context	vtimer;
+	struct arch_timer_context	ptimer;
 
 	/* Background timer used when the guest is not running */
 	struct hrtimer			timer;
@@ -77,4 +78,5 @@ bool kvm_timer_should_fire(struct kvm_vcpu *vcpu,
 void kvm_timer_init_vhe(void);
 
 #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
+#define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
 #endif
-- 
1.9.1
