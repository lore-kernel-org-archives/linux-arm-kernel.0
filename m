From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 10 Jan 2017 11:38:55 +0000
Subject: [PATCH v3 8/9] arm: KVM: Enable support for host pmu
In-Reply-To: <20170110113856.7183-1-punit.agrawal@arm.com>
References: <20170110113856.7183-1-punit.agrawal@arm.com>
Message-ID: <20170110113856.7183-9-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Kconfig option and Makefile updates to enable the recently added
support for host pmu.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kvm/Kconfig  | 4 ++++
 arch/arm/kvm/Makefile | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 90d0176fb30d..198d16c36220 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -16,6 +16,9 @@ menuconfig VIRTUALIZATION
 
 if VIRTUALIZATION
 
+config KVM_HOST_PMU
+	bool
+
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on MMU && OF
@@ -30,6 +33,7 @@ config KVM
 	select SRCU
 	select MMU_NOTIFIER
 	select KVM_VFIO
+	select KVM_HOST_PMU if PERF_EVENTS
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQCHIP
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index d571243ab4d1..09d358499ce1 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -35,3 +35,4 @@ obj-y += $(KVM)/arm/vgic/vgic-kvm-device.o
 obj-y += $(KVM)/arm/vgic/vgic-its.o
 obj-y += $(KVM)/irqchip.o
 obj-y += $(KVM)/arm/arch_timer.o
+obj-$(CONFIG_KVM_HOST_PMU) += $(KVM)/arm/host_pmu.o
-- 
2.11.0
