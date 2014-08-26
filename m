From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:13:24 +0100
Subject: [PATCH 05/11] KVM: vgic: return int instead of bool when checking I/O
 ranges
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409062410-25891-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vgic_ioaddr_overlap claims to return a bool, but in reality it returns
an int. Shut sparse up by fixing the type signature.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 73eba793b17f..d1cfe672b9d7 100644
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
2.1.0.rc1
