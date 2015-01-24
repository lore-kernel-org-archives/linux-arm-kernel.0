From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Sat, 24 Jan 2015 13:59:55 +0200
Subject: [PATCH v3 4/5] ARM/ARM64: enable linking against eventfd
In-Reply-To: <20150124115815.11052.20755.stgit@i3820>
References: <20150124115815.11052.20755.stgit@i3820>
Message-ID: <20150124115955.11052.62024.stgit@i3820>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables compilation of the eventfd feature on ARM/ARM64.

Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
---
 arch/arm/kvm/Kconfig    |    1 +
 arch/arm/kvm/Makefile   |    2 +-
 arch/arm64/kvm/Kconfig  |    1 +
 arch/arm64/kvm/Makefile |    2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index a8d1ace..ca23ded 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -20,6 +20,7 @@ config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 443b8be..539c1a5 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -15,7 +15,7 @@ AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
 AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
 
 KVM := ../../../virt/kvm
-kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
+kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 3ce389b..2cc985c 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -21,6 +21,7 @@ config KVM
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 4e6e09e..0dffb5f 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -11,7 +11,7 @@ ARM=../../../arch/arm/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
 
-kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
+kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/arm.o $(ARM)/mmu.o $(ARM)/mmio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/psci.o $(ARM)/perf.o
 
