From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  4 Nov 2015 15:49:57 +0100
Subject: [PULL 18/21] KVM: arm: Do not indent the arguments of DECLARE_BITMAP
In-Reply-To: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
References: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1446648600-27297-19-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Marek <mmarek@suse.com>

Besides being a coding style issue, it confuses make tags:

ctags: Warning: include/kvm/arm_vgic.h:307: null expansion of name pattern "\1"
ctags: Warning: include/kvm/arm_vgic.h:308: null expansion of name pattern "\1"
ctags: Warning: include/kvm/arm_vgic.h:309: null expansion of name pattern "\1"
ctags: Warning: include/kvm/arm_vgic.h:317: null expansion of name pattern "\1"

Cc: kvmarm at lists.cs.columbia.edu
Signed-off-by: Michal Marek <mmarek@suse.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_vgic.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 7bc5d02..8065801 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -299,9 +299,9 @@ struct vgic_cpu {
 	u8		*vgic_irq_lr_map;
 
 	/* Pending/active/both interrupts on this VCPU */
-	DECLARE_BITMAP(	pending_percpu, VGIC_NR_PRIVATE_IRQS);
-	DECLARE_BITMAP(	active_percpu, VGIC_NR_PRIVATE_IRQS);
-	DECLARE_BITMAP(	pend_act_percpu, VGIC_NR_PRIVATE_IRQS);
+	DECLARE_BITMAP(pending_percpu, VGIC_NR_PRIVATE_IRQS);
+	DECLARE_BITMAP(active_percpu, VGIC_NR_PRIVATE_IRQS);
+	DECLARE_BITMAP(pend_act_percpu, VGIC_NR_PRIVATE_IRQS);
 
 	/* Pending/active/both shared interrupts, dynamically sized */
 	unsigned long	*pending_shared;
@@ -309,7 +309,7 @@ struct vgic_cpu {
 	unsigned long   *pend_act_shared;
 
 	/* Bitmap of used/free list registers */
-	DECLARE_BITMAP(	lr_used, VGIC_V2_MAX_LRS);
+	DECLARE_BITMAP(lr_used, VGIC_V2_MAX_LRS);
 
 	/* Number of list registers on this CPU */
 	int		nr_lr;
-- 
2.1.2.330.g565301e.dirty
