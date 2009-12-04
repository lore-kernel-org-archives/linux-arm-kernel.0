From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Dec 2009 10:38:24 +0100
Subject: [RFC][PATCH 04/10] arm: mxc: Fix Drive Strength Field in the
	IOMUX controller
In-Reply-To: <a079a0627e77f2df590840e4798fc067f4436160.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<a079a0627e77f2df590840e4798fc067f4436160.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <20091204093824.GB10910@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Dec 04, 2009 at 04:47:04AM +0200, Amit Kucheria wrote:
> i.MX51 defines 4 values:
> 
> 00: Low Drive Strength
> 01: Medium Drive Strength
> 10: High Drive Strength
> 11: Max Drive Strength
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-v3.h |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> index a0fa402..8c351d6 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> @@ -81,11 +81,13 @@ struct pad_desc {
>  
>  #define PAD_CTL_ODE			(1 << 3)
>  
> -#define PAD_CTL_DSE_STANDARD		(0 << 1)
> -#define PAD_CTL_DSE_HIGH		(1 << 1)
> -#define PAD_CTL_DSE_MAX			(2 << 1)
> +#define PAD_CTL_DSE_LOW			(0 << 1)
> +#define PAD_CTL_DSE_MED			(1 << 1)
> +#define PAD_CTL_DSE_HIGH		(2 << 1)
> +#define PAD_CTL_DSE_MAX			(3 << 1)
Does the new values work on other SOCs having iomux-v3, too?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
