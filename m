From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 07:49:35 -0700
Subject: [PATCH 14/15] KVM: ARM: Fix spelling in error message
In-Reply-To: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
References: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <1367333376-30983-15-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s/unkown/unknown/

Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/kvm/handle_exit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index 26ad173..3d74a0b 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -115,7 +115,7 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 
 	if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers) ||
 	    !arm_exit_handlers[hsr_ec]) {
-		kvm_err("Unkown exception class: hsr: %#08x\n",
+		kvm_err("Unknown exception class: hsr: %#08x\n",
 			(unsigned int)kvm_vcpu_get_hsr(vcpu));
 		BUG();
 	}
-- 
1.7.9.5
