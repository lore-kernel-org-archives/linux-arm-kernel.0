From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:47 +0200
Subject: [PULL 39/50] arm64: KVM: Move vgic-v3 save/restore to virt/kvm/arm/hyp
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-40-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

So we can reuse the code under arch/arm

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/Makefile                       | 2 +-
 {arch/arm64/kvm => virt/kvm/arm}/hyp/vgic-v3-sr.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {arch/arm64/kvm => virt/kvm/arm}/hyp/vgic-v3-sr.c (100%)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 0c85feb..aaf42ae 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -5,9 +5,9 @@
 KVM=../../../../virt/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
+obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
 
-obj-$(CONFIG_KVM_ARM_HOST) += vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += sysreg-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += debug-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += entry.o
diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
similarity index 100%
rename from arch/arm64/kvm/hyp/vgic-v3-sr.c
rename to virt/kvm/arm/hyp/vgic-v3-sr.c
-- 
2.9.0
