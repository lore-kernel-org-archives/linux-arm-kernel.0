From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 12 Jul 2016 12:50:31 -0500
Subject: [PATCH 1/4] ARM: OMAP4+: hwmod: Add hwmod flag for
 HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET
In-Reply-To: <20160712175034.743-1-d-gerlach@ti.com>
References: <20160712175034.743-1-d-gerlach@ti.com>
Message-ID: <20160712175034.743-2-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nearly all modules on OMAP4 and newer platforms have clkctrl offsets
that are non-zero except for the RTC on am335x. Because we rely on a
clkctrl_offset of zero to indicate no clkctrl_offset being present,
lets add a HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET flag to use to indicate
hwmods that have a valid clkctrl_offset of 0.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 4041bad79a9a..78904017f18c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -443,8 +443,12 @@ struct omap_hwmod_omap2_prcm {
  * HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT: Some IP blocks don't have a PRCM
  *     module-level context loss register associated with them; this
  *     flag bit should be set in those cases
+ * HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET: Some IP blocks have a valid CLKCTRL
+ *	offset of zero; this flag bit should be set in those cases to
+ *	distinguish from hwmods that have no clkctrl offset.
  */
 #define HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT		(1 << 0)
+#define HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET		(1 << 1)
 
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
-- 
2.9.0
