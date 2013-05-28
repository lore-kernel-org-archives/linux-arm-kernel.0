From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 28 May 2013 07:30:05 -0700
Subject: [PATCH] ARM: OMAP: fix IVA2 module base address
In-Reply-To: <1369741577-21984-1-git-send-email-aida.mynzhasova@skitlab.ru>
 (Aida Mynzhasova's message of "Tue, 28 May 2013 15:46:17 +0400")
References: <1369741577-21984-1-git-send-email-aida.mynzhasova@skitlab.ru>
Message-ID: <87bo7vdvo2.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aida Mynzhasova <aida.mynzhasova@skitlab.ru> writes:

> This patch corrects the base address of IVA2 module on omap3430.
>
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>

I know it looks a bit weird to have a negative offset like this, but
it's actually correct.  These offsets are used relative to
prm_base (on 34xx, it's OMAP3430_PRM_BASE defined in omap34xx.h).
So I suggest you double check the values there, and cross reference to
the "PRCM Register Manual" section of the TRM (last section of the PRCM
chapter.)

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/prcm-common.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index c7d355f..d5ec044 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -37,7 +37,7 @@
>  #define OMAP2430_MDM_MOD				0xc00
>  
>  /* IVA2 module is < base on 3430 */
> -#define OMAP3430_IVA2_MOD				-0x800
> +#define OMAP3430_IVA2_MOD				0x800
>  #define OMAP3430ES2_SGX_MOD				GFX_MOD
>  #define OMAP3430_CCR_MOD				PLL_MOD
>  #define OMAP3430_DSS_MOD				0x600
