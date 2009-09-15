From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:41:27 +0100
Subject: [PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.
In-Reply-To: <1252388401-31529-1-git-send-email-thomas.ab@samsung.com>
References: <1252388401-31529-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20090915234127.GA24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2009 at 02:40:01PM +0900, thomas.ab at samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch removes the redundant MPLL parent assignment
> in the function s3c6400_register_clocks.

Where is the other assignment being done from?
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index 9745852..72c03ab 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -758,6 +758,5 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
>  		}
>  	}
>  
> -	clk_mpll.parent = &clk_mout_mpll.clk;
>  	clk_epll.parent = &clk_mout_epll.clk;
>  }
> -- 
> 1.5.3.4
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
