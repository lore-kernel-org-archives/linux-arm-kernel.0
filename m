From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 08 Jan 2013 13:42:45 -0500
Subject: [PATCH v5 12/12] ARM: KVM: Add VGIC configuration option
In-Reply-To: <20130108184116.46558.3558.stgit@ubuntu>
References: <20130108184116.46558.3558.stgit@ubuntu>
Message-ID: <20130108184245.46558.83229.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

It is now possible to select the VGIC configuration option.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 05227cb..d32e33f 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -51,6 +51,14 @@ config KVM_ARM_MAX_VCPUS
 	  large, so only choose a reasonable number that you expect to
 	  actually use.
 
+config KVM_ARM_VGIC
+        bool "KVM support for Virtual GIC"
+	depends on KVM_ARM_HOST && OF
+	select HAVE_KVM_IRQCHIP
+	default y
+	---help---
+	  Adds support for a hardware assisted, in-kernel GIC emulation.
+
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
