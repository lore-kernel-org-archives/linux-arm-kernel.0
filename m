From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:31:44 +0530
Subject: [RFC v2 05/18] ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__
 macros in header files
In-Reply-To: <1356959231-17335-6-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-6-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC34D8.5010105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> This is necessary to ensure that macros declared here can
> be reused from assembly files.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> v1->v2:
> 	Split out the header file changes in a separate patch
> 	based on the feedback from Santosh
>
>   arch/arm/mach-omap2/cm33xx.h  |    3 +++
>   arch/arm/mach-omap2/prm33xx.h |    3 +++
>   2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
> index 8009e13..2f215cd 100644
> --- a/arch/arm/mach-omap2/cm33xx.h
> +++ b/arch/arm/mach-omap2/cm33xx.h
> @@ -376,6 +376,7 @@
>   #define AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL			AM33XX_CM_REGADDR(AM33XX_CM_CEFUSE_MOD, 0x0020)
>
>
> +#ifndef __ASSEMBLER__
>   extern bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs);
>   extern void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs);
>   extern void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs);
> @@ -412,4 +413,6 @@ static inline int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
>   }
>   #endif
>
> +#endif /* ASSEMBLER */
> +
Drop that extra line.
>   #endif
> diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
> index 3f25c56..2f2eaa0 100644
> --- a/arch/arm/mach-omap2/prm33xx.h
> +++ b/arch/arm/mach-omap2/prm33xx.h
> @@ -117,6 +117,7 @@
>   #define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
>   #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
>
> +#ifndef __ASSEMBLER__
>   extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
>   extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
>   extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
> @@ -126,4 +127,6 @@ extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
>   extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
>   extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
>   		u16 rstctrl_offs, u16 rstst_offs);
> +#endif /* ASSEMBLER */
> +
ditto

Otherwise looks fine.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
