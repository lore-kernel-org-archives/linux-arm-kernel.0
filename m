From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 14 Sep 2011 15:23:59 +0300
Subject: [PATCH 3/6] OMAP3: id: use explicit omap_revision codes for
	3505/3517 ES levels
In-Reply-To: <20110913212803.26161.31753.stgit@dusk>
References: <20110913212638.26161.62284.stgit@dusk>
	<20110913212803.26161.31753.stgit@dusk>
Message-ID: <4E709CDF.8080703@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

This patch does not apply, after the v2 of 1_6, see below:

On 09/14/11 00:28, Paul Walmsley wrote:
> Use explicit revision codes for OMAP/AM 3505/3517 ES levels, as the rest
> of the OMAP2+ SoCs do in mach-omap2/cpu.c.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |   10 +++++++++-
>  arch/arm/plat-omap/include/plat/cpu.h |    3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 46bc2f9..6810c52 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -312,7 +312,15 @@ static void __init omap3_check_revision(void)
>  		 *
>  		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
>  		 */
> -		omap_revision = OMAP3517_REV(rev);
> +		switch (rev) {
> +		case 0:
> +			omap_revision = OMAP3517_REV_ES1_0;
> +			break;
> +		case 1:
> +		/* FALLTHROUGH */
> +		default:
> +			omap_revision = OMAP3517_REV_ES1_1;
> +		}
>  		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
>  		break;
>  	case 0xb891:
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index b6bd8f7..566975c 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -398,7 +398,8 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (OMAP_REVBITS_02 << 8))
>  
>  #define OMAP3517_CLASS		0x35170000

After applying the v2 of 1_6, the above value should be 0x35170034

> -#define OMAP3517_REV(v)		(OMAP3517_CLASS | (v << 8))
> +#define OMAP3517_REV_ES1_0	OMAP3517_CLASS
> +#define OMAP3517_REV_ES1_1	(OMAP3517_CLASS | (OMAP_REVBITS_01 << 8))
>  
>  #define TI816X_CLASS		0x81600034
>  #define TI8168_REV_ES1_0	TI816X_CLASS
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Regards,
Igor.
