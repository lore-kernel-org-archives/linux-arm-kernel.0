From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 11 May 2012 11:32:43 +0530
Subject: [PATCH] ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from struct
 dpll_data
Message-ID: <1336716163-2960-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

There are certain fields inside 'struct dpll_data' which are
included under ARCH_OMAP3 and ARCH_OMAP4 option, which makes it
difficult to use it for new devices like, am33xx, ti81xx, etc...

So remove the ifdef completely, this will add few fields to the struct
unused, but it improves readability and maintainability of the code.

Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>
---
Since Kevin had provided this idea and code change,
making this patch under his authorship.

 arch/arm/plat-omap/include/plat/clock.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d0ef57c..656b986 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -156,7 +156,6 @@ struct dpll_data {
 	u8			min_divider;
 	u16			max_divider;
 	u8			modes;
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
@@ -167,7 +166,6 @@ struct dpll_data {
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-#  endif
 	u8			flags;
 };

--
1.7.0.4
