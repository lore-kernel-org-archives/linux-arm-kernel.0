From: kim.phillips@linaro.org (Kim Phillips)
Date: Tue, 25 Mar 2014 17:08:13 -0500
Subject: [PATCH 1/2] ARM: KVM: Enable the KVM-VFIO device
Message-ID: <1395785294-2545-1-git-send-email-kim.phillips@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used by KVM-enabled VFIO-based device passthrough support in QEMU.

Signed-off-by: Kim Phillips <kim.phillips@linaro.org>
---
This is just a couple of patches developed during platform
device passthrough development in QEMU.  Based on linux v3.14-rc8.

 arch/arm/kvm/Kconfig  | 1 +
 arch/arm/kvm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 466bd29..22ca356 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -23,6 +23,7 @@ config KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_ARM_HOST
+	select KVM_VFIO
 	depends on ARM_VIRT_EXT && ARM_LPAE
 	---help---
 	  Support hosting virtualized guest machines. You will also
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 789bca9..21a6ee0 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -15,7 +15,7 @@ AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
 AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
 
 KVM := ../../../virt/kvm
-kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
+kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/vfio.o
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
-- 
1.9.1
