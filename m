From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:57:51 +0100
Subject: [PATCH 3/4] s3c6410: Fix divider value calculation in
	s3c64xx_roundrate_clksrc
In-Reply-To: <1252388129-22722-1-git-send-email-thomas.ab@samsung.com>
References: <1252388129-22722-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20090915235751.GI13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2009 at 02:35:29PM +0900, thomas.ab at samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> In s3c64xx_roundrate_clksrc function, the calculation is wrong. This
> patch fixes this calculation.

Applied to next-s3c64xx-fixes.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index 54eef93..9745852 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -345,7 +345,7 @@ static unsigned long s3c64xx_roundrate_clksrc(struct clk *clk,
>  	if (rate > parent_rate)
>  		rate = parent_rate;
>  	else {
> -		div = rate / parent_rate;
> +		div = parent_rate / rate;
>  
>  		if (div == 0)
>  			div = 1;
> -- 
> 1.5.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
