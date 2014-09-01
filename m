From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  1 Sep 2014 14:52:42 +0200
Subject: [RFC v2 3/9] ARM: KVM: Enable the KVM-VFIO device
In-Reply-To: <1409575968-5329-1-git-send-email-eric.auger@linaro.org>
References: <1409575968-5329-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1409575968-5329-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kim Phillips <kim.phillips@linaro.org>

Used by KVM-enabled VFIO-based device passthrough support in QEMU.

Signed-off-by: Kim Phillips <kim.phillips@linaro.org>
---
 arch/arm/kvm/Kconfig  | 1 +
 arch/arm/kvm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index e519a40..aace254 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -24,6 +24,7 @@ config KVM
 	select KVM_MMIO
 	select KVM_ARM_HOST
 	depends on ARM_VIRT_EXT && ARM_LPAE
+	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	---help---
 	  Support hosting virtualized guest machines. You will also
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 859db09..ea1fa76 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -15,7 +15,7 @@ AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
 AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
 
 KVM := ../../../virt/kvm
-kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
+kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o $(KVM)/vfio.o
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
-- 
1.9.1
