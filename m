From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 18:56:58 +0100
Subject: [PATCH v4 1/3] KVM: arm/arm64: unset CONFIG_HAVE_KVM_IRQCHIP
In-Reply-To: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
References: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1416765420-12057-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HAVE_KVM_IRQCHIP is needed to support IRQ routing (along
with irq_comm.c and irqchip.c usage). This is not the case for
arm/arm64 currently.

This patch unsets the flag for both arm and arm64.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 arch/arm/kvm/Kconfig   | 2 --
 arch/arm64/kvm/Kconfig | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 466bd29..9f581b1 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -55,7 +55,6 @@ config KVM_ARM_MAX_VCPUS
 config KVM_ARM_VGIC
 	bool "KVM support for Virtual GIC"
 	depends on KVM_ARM_HOST && OF
-	select HAVE_KVM_IRQCHIP
 	default y
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.
@@ -63,7 +62,6 @@ config KVM_ARM_VGIC
 config KVM_ARM_TIMER
 	bool "KVM support for Architected Timers"
 	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
-	select HAVE_KVM_IRQCHIP
 	default y
 	---help---
 	  Adds support for the Architected Timers in virtual machines
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8ba85e9..279e1a0 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -50,7 +50,6 @@ config KVM_ARM_MAX_VCPUS
 config KVM_ARM_VGIC
 	bool
 	depends on KVM_ARM_HOST && OF
-	select HAVE_KVM_IRQCHIP
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.
 
-- 
1.9.1
