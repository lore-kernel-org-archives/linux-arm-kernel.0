From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Aug 2016 11:46:53 +0100
Subject: [PATCH v2 2/7] arm64: KVM: Move vgic-v3 save/restore to
 virt/kvm/arm/hyp
In-Reply-To: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471344418-19568-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So we can reuse the code under arch/arm

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/kvm/hyp/Makefile                       |    2 +-
 {arch/arm64/kvm => virt/kvm/arm}/hyp/vgic-v3-sr.c |    0
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
1.7.9.5
