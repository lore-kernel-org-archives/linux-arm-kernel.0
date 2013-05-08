From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 May 2013 16:33:06 -0700
Subject: [PATCH] ARM: OMAP2: AM33XX: id: Add support for new AM335x
 PG2.1 Si
In-Reply-To: <1367691820-11875-1-git-send-email-hvaibhav@ti.com>
References: <1367691820-11875-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20130508233306.GU32546@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [130504 11:29]:
> Add support for chip id detection of AM335x PG2.1 Silicon.
> 
> Currently omap3xxx_check_revision() detects PG1.0 and PG2.0 only,
> this patch extends it by adding PG2.1 Si support.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks applying into omap-for-v3.10/fixes.

Tony

> ---
>  arch/arm/mach-omap2/id.c  |    8 ++++++--
>  arch/arm/mach-omap2/soc.h |    1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 0f4c18e..9bc5a18 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -419,11 +419,15 @@ void __init omap3xxx_check_revision(void)
>  			cpu_rev = "1.0";
>  			break;
>  		case 1:
> -		/* FALLTHROUGH */
> -		default:
>  			omap_revision = AM335X_REV_ES2_0;
>  			cpu_rev = "2.0";
>  			break;
> +		case 2:
> +		/* FALLTHROUGH */
> +		default:
> +			omap_revision = AM335X_REV_ES2_1;
> +			cpu_rev = "2.1";
> +			break;
>  		}
>  		break;
>  	case 0xb8f2:
> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
> index 18fdeeb..ccef2dd 100644
> --- a/arch/arm/mach-omap2/soc.h
> +++ b/arch/arm/mach-omap2/soc.h
> @@ -396,6 +396,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define AM335X_CLASS		0x33500033
>  #define AM335X_REV_ES1_0	AM335X_CLASS
>  #define AM335X_REV_ES2_0	(AM335X_CLASS | (0x1 << 8))
> +#define AM335X_REV_ES2_1	(AM335X_CLASS | (0x2 << 8))
> 
>  #define OMAP443X_CLASS		0x44300044
>  #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
> --
> 1.7.0.4
> 
