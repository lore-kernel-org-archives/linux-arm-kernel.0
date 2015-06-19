From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jun 2015 13:53:16 +0100
Subject: [PATCH 12/12] KVM: arm/arm64: vgic: Remove useless arm-gic.h #include
In-Reply-To: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
References: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1434718396-13110-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Back in the days, vgic.c used to have an intimate knowledge of
the actual GICv2. These days, this has been abstracted away into
hardware-specific backends.

Remove the now useless arm-gic.h #include directive, making it
clear that GICv2 specific code doesn't belong here.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 950064a..f94d887 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -26,8 +26,6 @@
 #include <linux/of_irq.h>
 #include <linux/uaccess.h>
 
-#include <linux/irqchip/arm-gic.h>
-
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
-- 
2.1.4
