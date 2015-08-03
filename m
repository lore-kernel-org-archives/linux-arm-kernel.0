From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  3 Aug 2015 19:20:41 +0200
Subject: [PATCH v4 2/5] KVM: arm/arm64: select IRQ_BYPASS_MANAGER
In-Reply-To: <1438622444-25444-1-git-send-email-eric.auger@linaro.org>
References: <1438622444-25444-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438622444-25444-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select IRQ_BYPASS_MANAGER when CONFIG_KVM is set
Also add compilation of virt/lib.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Feng Wu <feng.wu@intel.com>

---

v3 -> v4:
- add compilation of virt/lib in arm/arm64 KVM

v2 -> v3:
- [Feng Wu] Correct a typo in 'arch/arm64/kvm/Kconfig'

v1 -> v2:
- also set IRQ_BYPASS_MANAGER for arm64
---
 arch/arm/kvm/Kconfig    | 2 ++
 arch/arm/kvm/Makefile   | 1 +
 arch/arm64/kvm/Kconfig  | 2 ++
 arch/arm64/kvm/Makefile | 1 +
 4 files changed, 6 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index bfb915d..3c565b9 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 source "virt/kvm/Kconfig"
+source "virt/lib/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -31,6 +32,7 @@ config KVM
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
+	select IRQ_BYPASS_MANAGER
 	depends on ARM_VIRT_EXT && ARM_LPAE && ARM_ARCH_TIMER
 	---help---
 	  Support hosting virtualized guest machines.
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index c5eef02c..a6a41dd 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -24,3 +24,4 @@ obj-y += $(KVM)/arm/vgic.o
 obj-y += $(KVM)/arm/vgic-v2.o
 obj-y += $(KVM)/arm/vgic-v2-emul.o
 obj-y += $(KVM)/arm/arch_timer.o
+obj-y += ../../../virt/lib/
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index bfffe8f..2509539 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 source "virt/kvm/Kconfig"
+source "virt/lib/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -31,6 +32,7 @@ config KVM
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
+	select IRQ_BYPASS_MANAGER
 	---help---
 	  Support hosting virtualized guest machines.
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index f90f4aa..55eec69 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -27,3 +27,4 @@ kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic-v3.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic-v3-emul.o
 kvm-$(CONFIG_KVM_ARM_HOST) += vgic-v3-switch.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/arch_timer.o
+kvm-$(CONFIG_KVM_ARM_HOST) += ../../../virt/lib/
-- 
1.9.1
