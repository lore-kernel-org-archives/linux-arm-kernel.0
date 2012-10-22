From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:52:43 -0400
Subject: [PATCH v3 13/13] ARM: KVM: Add VGIC configuration option
In-Reply-To: <20121022065104.18672.52989.stgit@ubuntu>
References: <20121022065104.18672.52989.stgit@ubuntu>
Message-ID: <20121022065243.18672.67674.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

It is now possible to select the VGIC configuration option.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/Kconfig |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 47c5500..867551e 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -40,6 +40,13 @@ config KVM_ARM_HOST
 	---help---
 	  Provides host support for ARM processors.
 
+config KVM_ARM_VGIC
+        bool "KVM support for Virtual GIC"
+	depends on KVM_ARM_HOST && OF
+	select HAVE_KVM_IRQCHIP
+	---help---
+	  Adds support for a hardware assisted, in-kernel GIC emulation.
+
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
