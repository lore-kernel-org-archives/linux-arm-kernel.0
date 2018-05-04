From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 May 2018 17:15:58 +0100
Subject: [PATCH 3/4] KVM: arm/arm64: vgic_init: Cleanup reference to
 process_maintenance
In-Reply-To: <20180504161559.22852-1-marc.zyngier@arm.com>
References: <20180504161559.22852-1-marc.zyngier@arm.com>
Message-ID: <20180504161559.22852-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentin Schneider <valentin.schneider@arm.com>

One comment still mentioned process_maintenance operations after
commit af0614991ab6 ("KVM: arm/arm64: vgic: Get rid of unnecessary
process_maintenance operation")

Update the comment to point to vgic_fold_lr_state instead, which
is where maintenance interrupts are taken care of.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 68378fe17a0e..e07156c30323 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -423,7 +423,7 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 	 * We cannot rely on the vgic maintenance interrupt to be
 	 * delivered synchronously. This means we can only use it to
 	 * exit the VM, and we perform the handling of EOIed
-	 * interrupts on the exit path (see vgic_process_maintenance).
+	 * interrupts on the exit path (see vgic_fold_lr_state).
 	 */
 	return IRQ_HANDLED;
 }
-- 
2.14.2
