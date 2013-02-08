From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Feb 2013 17:21:01 +0200
Subject: [PATCH] ARM: OMAP2+: Remove duplicate omap4430_init_late()
 declaration
In-Reply-To: <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130208152101.GI23979@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 08:41:45PM +0530, Santosh Shilimkar wrote:
> Commit bbd707ac {ARM: omap2: use machine specific hook for late init}
> accidentally added two declarations for omap4430_init_late().
> 
> Remove the duplicate declaration.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

nice catch

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/common.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 948bcaa..e0f9ea7 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -108,7 +108,6 @@ void omap35xx_init_late(void);
>  void omap3630_init_late(void);
>  void am35xx_init_late(void);
>  void ti81xx_init_late(void);
> -void omap4430_init_late(void);
>  int omap2_common_pm_late_init(void);
>  
>  #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/faaeef3e/attachment-0001.sig>
