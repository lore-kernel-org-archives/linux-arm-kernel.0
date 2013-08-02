From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 2 Aug 2013 19:08:04 +0530
Subject: [PATCH v2 10/13] ARM: OMAP2+: hwmod: AM43x operations
In-Reply-To: <cover.1375443858.git.afzal@ti.com>
References: <cover.1375443858.git.afzal@ti.com>
Message-ID: <838ab5ad788f64cef1e8859409490aa2b495d1ee.1375443858.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse OMAP4 operations on AM43x.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7f4db12..a1b7e20 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4123,6 +4123,14 @@ void __init omap_hwmod_init(void)
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
+	} else if (soc_is_am43xx()) {
+		soc_ops.enable_module = _omap4_enable_module;
+		soc_ops.disable_module = _omap4_disable_module;
+		soc_ops.wait_target_ready = _omap4_wait_target_ready;
+		soc_ops.assert_hardreset = _omap4_assert_hardreset;
+		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
+		soc_ops.init_clkdm = _init_clkdm;
 	} else if (soc_is_am33xx()) {
 		soc_ops.enable_module = _am33xx_enable_module;
 		soc_ops.disable_module = _am33xx_disable_module;
-- 
1.7.9.5
