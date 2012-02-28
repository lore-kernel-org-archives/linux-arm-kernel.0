From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 28 Feb 2012 04:10:57 -0700
Subject: [PATCH 9/9] ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16
 to 32 bits
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Message-ID: <20120228111056.808.87964.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the OCP_* register offsets in the struct
omap_hwmod_class_sysconfig to 32 bits.  This is required to add the
OMAP4+ GPU hwmod, which uses OCP_* register offsets larger than 16
bits.

Another possible solution may be to simply add a single 16 bit offset
field in this structure, and to add code to factor that offset into
all OCP_* register accesses.  This would save some memory, since
almost no modules need 32 bit offsets.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index f0a0711..083b6da 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -328,9 +328,9 @@ struct omap_hwmod_sysc_fields {
  * then this field has to be populated with the correct offset structure.
  */
 struct omap_hwmod_class_sysconfig {
-	u16 rev_offs;
-	u16 sysc_offs;
-	u16 syss_offs;
+	u32 rev_offs;
+	u32 sysc_offs;
+	u32 syss_offs;
 	u16 sysc_flags;
 	struct omap_hwmod_sysc_fields *sysc_fields;
 	u8 srst_udelay;
