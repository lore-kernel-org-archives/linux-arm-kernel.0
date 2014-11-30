From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Sun, 30 Nov 2014 12:18:04 +0800
Subject: [PATCH] kvm: arm: vgic: Let one looping code instead of two looping
 code
Message-ID: <547A9A7C.1080508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use one looping instead of two, so can let code more simpler and get a
little better performance.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 virt/kvm/arm/vgic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index cf23c13..eb1a51b 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1959,9 +1959,6 @@ int kvm_vgic_create(struct kvm *kvm)
 		if (!mutex_trylock(&vcpu->mutex))
 			goto out_unlock;
 		vcpu_lock_idx = i;
-	}
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (vcpu->arch.has_run_once)
 			goto out_unlock;
 	}
-- 
1.9.3
