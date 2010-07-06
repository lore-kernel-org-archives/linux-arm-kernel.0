From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 6 Jul 2010 11:26:03 +0530
Subject: [PATCH 21/33] Removing dead OMAP2_VENC_OUT_TYPE_SVIDEO,
	OMAP2_VENC_OUT_TYPE_COMPOSITE
In-Reply-To: <2709d1406900af2436f6f8af00555507baf8dac9.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<2709d1406900af2436f6f8af00555507baf8dac9.1277911346.git.siccegge@cs.fau.de>
Message-ID: <19F8576C6E063C45BE387C64729E7394044EAAD9EF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Christoph Egger
> Sent: Wednesday, June 30, 2010 9:31 PM
> To: Tony Lindgren; Russell King; Jason Lam; linux-omap at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: vamos at i4.informatik.uni-erlangen.de
> Subject: [PATCH 21/33] Removing dead OMAP2_VENC_OUT_TYPE_SVIDEO,
> OMAP2_VENC_OUT_TYPE_COMPOSITE
> 
> OMAP2_VENC_OUT_TYPE_SVIDEO, OMAP2_VENC_OUT_TYPE_COMPOSITE doesn't
> exist in Kconfig, therefore removing all references for it from the
> source code.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-omap2/board-omap3stalker.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-
> omap2/board-omap3stalker.c
> index f848ba8..b38afd5 100644
> --- a/arch/arm/mach-omap2/board-omap3stalker.c
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -181,11 +181,6 @@ static struct omap_dss_device omap3_stalker_tv_device =
> {
>  	.name			= "tv",
>  	.driver_name		= "venc",
>  	.type			= OMAP_DISPLAY_TYPE_VENC,
> -#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
> -	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
> -#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
> -	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
> -#endif
[Hiremath, Vaibhav] I understand that currently we do not have any mechanism to dynamically change the VENC output type, but I think we should make some default type assumption and keep that initialization here, which is anyway happening to CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE. But explicitly initialize it to CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE for completeness/readability.

Just wanted to add one more thing here is, in our internal releases we do have config option to choose between this. But ideally it would be configurable dynamically.

Thanks,
Vaibhav
>  	.platform_enable	= omap3_stalker_enable_tv,
>  	.platform_disable	= omap3_stalker_disable_tv,
>  };
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
