From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 19:35:54 +0100
Subject: [PATCH v3 2/8] KVM: arm64: Enable the KVM-VFIO device
In-Reply-To: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
References: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1416767760-14487-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used by KVM-enabled VFIO-based device passthrough support in QEMU.

Signed-off-by: Joel Schopp <joel.schopp@amd.com>
Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

Extracted from [RFC PATCH] arm64: KVM: add irqfd support
http://www.spinics.net/lists/kvm-arm/msg10798.html
---
 arch/arm64/kvm/Kconfig  | 1 +
 arch/arm64/kvm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 09c25c2..2edf926 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -26,6 +26,7 @@ config KVM
 	select KVM_ARM_HOST
 	select KVM_ARM_VGIC
 	select KVM_ARM_TIMER
+	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	---help---
 	  Support hosting virtualized guest machines.
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 2e6b827..81ed091 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -11,7 +11,7 @@ ARM=../../../arch/arm/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
 
-kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
+kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o $(KVM)/vfio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/arm.o $(ARM)/mmu.o $(ARM)/mmio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/psci.o $(ARM)/perf.o
 
-- 
1.9.1
