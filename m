From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Nov 2015 14:53:51 +0000
Subject: [PATCH v4 01/13] KVM: arm/arm64: select IRQ_BYPASS_MANAGER
In-Reply-To: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
References: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1447944843-17731-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select IRQ_BYPASS_MANAGER when CONFIG_KVM is set

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 arch/arm/kvm/Kconfig   | 2 ++
 arch/arm64/kvm/Kconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 95a0005..73d7201 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 source "virt/kvm/Kconfig"
+source "virt/lib/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -32,6 +33,7 @@ config KVM
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
+	select IRQ_BYPASS_MANAGER
 	depends on ARM_VIRT_EXT && ARM_LPAE && ARM_ARCH_TIMER
 	---help---
 	  Support hosting virtualized guest machines.
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a5272c0..64f460d 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 source "virt/kvm/Kconfig"
+source "virt/lib/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -36,6 +37,7 @@ config KVM
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
 	select KVM_ARM_VGIC_V3
+	select IRQ_BYPASS_MANAGER
 	---help---
 	  Support hosting virtualized guest machines.
 	  We don't support KVM with 16K page tables yet, due to the multiple
-- 
1.9.1
