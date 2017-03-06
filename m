From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:18 +0100
Subject: [PATCH v3 03/19] arm/arm64: vgic: turn vgic_find_mmio_region into
 public
In-Reply-To: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1488800074-21991-4-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We plan to use vgic_find_mmio_region in vgic-its.c so let's
turn it into a public function.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 3 +--
 virt/kvm/arm/vgic/vgic-mmio.h | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 3654b4c..0427ddb 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -430,8 +430,7 @@ static int match_region(const void *key, const void *elt)
 	return 0;
 }
 
-/* Find the proper register handler entry given a certain address offset. */
-static const struct vgic_register_region *
+const struct vgic_register_region *
 vgic_find_mmio_region(const struct vgic_register_region *region, int nr_regions,
 		      unsigned int offset)
 {
diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
index 98bb566..055ad42 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.h
+++ b/virt/kvm/arm/vgic/vgic-mmio.h
@@ -192,4 +192,9 @@ u64 vgic_sanitise_shareability(u64 reg);
 u64 vgic_sanitise_field(u64 reg, u64 field_mask, int field_shift,
 			u64 (*sanitise_fn)(u64));
 
+/* Find the proper register handler entry given a certain address offset */
+const struct vgic_register_region *
+vgic_find_mmio_region(const struct vgic_register_region *region,
+		      int nr_regions, unsigned int offset);
+
 #endif
-- 
2.5.5
