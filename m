From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 30 Mar 2012 21:33:53 +0530
Subject: [PATCH-V4 2/4] ARM: OMAP3/4: omap_hwmod: Add rstst_off field to
 struct omap_hwmod_omap4_prcm
In-Reply-To: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1333123435-27186-3-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of AM33XX device, XXX_RSTST register offset is not
consistent across PRM modules/instances,

PRM_XXX            RSTST
=========================
PRM_PER_MOD:       0x04
PRM_WKUP_MOD:      0x0C
PRM_MPU_MOD:       NA
PRM_DEVICE_MOD:    0x08

This means, we need to pass on XXX_RSTST register offset
information through omap_hwmod data, similar to XXX_RSTCTRL.

Currently, this field is only applicable and used for AM33XX
devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 9ae87eb..50f42ec 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -374,11 +374,13 @@ struct omap_hwmod_omap2_prcm {
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
  * @clkctrl_reg: PRCM address of the clock control register
  * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
+ * @rstst_reg: (AM33XX Only) address of the XXX_RSTST register located in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  */
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
 	u16		rstctrl_offs;
+	u16		rstst_offs;
 	u16		context_offs;
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
--
1.7.0.4
