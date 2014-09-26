From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 15:16:40 +0200
Subject: [PATCH 07/27] KVM: vgic: return int instead of bool when checking I/O
 ranges
In-Reply-To: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
References: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1411737420-9063-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

vgic_ioaddr_overlap claims to return a bool, but in reality it returns
an int. Shut sparse up by fixing the type signature.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 73eba79..d1cfe67 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1690,7 +1690,7 @@ out:
 	return ret;
 }
 
-static bool vgic_ioaddr_overlap(struct kvm *kvm)
+static int vgic_ioaddr_overlap(struct kvm *kvm)
 {
 	phys_addr_t dist = kvm->arch.vgic.vgic_dist_base;
 	phys_addr_t cpu = kvm->arch.vgic.vgic_cpu_base;
-- 
2.0.0
