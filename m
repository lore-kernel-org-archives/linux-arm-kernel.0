From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Dec 2015 11:12:09 +0000
Subject: [PATCH 01/31] KVM: arm/arm64: vgic: make vgic_io_ops static
In-Reply-To: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
References: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1450955559-15639-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

vgic_io_ops is only referenced within vgic.c, so it can be declared
static.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 65461f8..0c739a7 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -878,7 +878,7 @@ static int vgic_handle_mmio_write(struct kvm_vcpu *vcpu,
 				       true);
 }
 
-struct kvm_io_device_ops vgic_io_ops = {
+static struct kvm_io_device_ops vgic_io_ops = {
 	.read	= vgic_handle_mmio_read,
 	.write	= vgic_handle_mmio_write,
 };
-- 
2.1.4
