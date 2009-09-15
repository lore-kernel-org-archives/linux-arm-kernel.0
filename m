From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:57:34 +0100
Subject: [PATCH 2/4] s3c6410: update clk->parent when setting clock source
In-Reply-To: <1252387848-21869-1-git-send-email-thomas.ab@samsung.com>
References: <1252387848-21869-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20090915235734.GH13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2009 at 02:30:48PM +0900, thomas.ab at samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This ensures the clock hierarchy data structures are
> updated when we change the clock source in the actual
> hardware registers.

Applied to next-s3c64xx-fixes.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index c972d2f..54eef93 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -328,6 +328,8 @@ static int s3c64xx_setparent_clksrc(struct clk *clk, struct clk *parent)
>  		clksrc |= src_nr << sclk->shift;
>  
>  		__raw_writel(clksrc, S3C_CLK_SRC);
> +
> +		clk->parent = parent;
>  		return 0;
>  	}
>  
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
