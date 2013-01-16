From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:01:43 -0500
Subject: [PATCH v6 13/13] ARM: KVM: Add VGIC configuration option
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180143.29393.90017.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

It is now possible to select the VGIC configuration option.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 05227cb..d8126f2 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -51,6 +51,14 @@ config KVM_ARM_MAX_VCPUS
 	  large, so only choose a reasonable number that you expect to
 	  actually use.
 
+config KVM_ARM_VGIC
+	bool "KVM support for Virtual GIC"
+	depends on KVM_ARM_HOST && OF
+	select HAVE_KVM_IRQCHIP
+	default y
+	---help---
+	  Adds support for a hardware assisted, in-kernel GIC emulation.
+
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
