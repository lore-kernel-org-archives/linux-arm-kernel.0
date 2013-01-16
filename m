From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:00:21 -0500
Subject: [PATCH v6 01/13] ARM: gic: add missing distributor defintions
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180021.29393.69480.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing register map offsets for the distributor and rename
GIC_DIST_ACTIVE_BIT to GIC_DIST_ACTIVE_SET to be consistent.

Cc: Marc Zyniger <marc.zyngier@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/hardware/gic.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 4b1ce6c..caf5df3 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -22,11 +22,13 @@
 
 #define GIC_DIST_CTRL			0x000
 #define GIC_DIST_CTR			0x004
+#define GIC_DIST_IGROUP			0x080
 #define GIC_DIST_ENABLE_SET		0x100
 #define GIC_DIST_ENABLE_CLEAR		0x180
 #define GIC_DIST_PENDING_SET		0x200
 #define GIC_DIST_PENDING_CLEAR		0x280
-#define GIC_DIST_ACTIVE_BIT		0x300
+#define GIC_DIST_ACTIVE_SET		0x300
+#define GIC_DIST_ACTIVE_CLEAR		0x380
 #define GIC_DIST_PRI			0x400
 #define GIC_DIST_TARGET			0x800
 #define GIC_DIST_CONFIG			0xc00
