From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:35 +0100
Subject: [PATCH 7/7] kvmtool: virtio: enable arm/arm64 support for
 bi-endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502195-8263-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 tools/kvm/arm/include/arm-common/kvm-arch.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/kvm/arm/include/arm-common/kvm-arch.h b/tools/kvm/arm/include/arm-common/kvm-arch.h
index 72b204f..91836cb 100644
--- a/tools/kvm/arm/include/arm-common/kvm-arch.h
+++ b/tools/kvm/arm/include/arm-common/kvm-arch.h
@@ -27,6 +27,8 @@
 
 #define VIRTIO_DEFAULT_TRANS	VIRTIO_MMIO
 
+#define VIRTIO_RING_ENDIAN	((1UL << VIRTIO_RING_F_GUEST_LE) | (1UL << VIRTIO_RING_F_GUEST_BE))
+
 static inline bool arm_addr_in_ioport_region(u64 phys_addr)
 {
 	u64 limit = KVM_IOPORT_AREA + ARM_IOPORT_SIZE;
-- 
1.8.2.3
