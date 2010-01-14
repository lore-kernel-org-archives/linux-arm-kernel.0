From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 14 Jan 2010 02:19:14 +0000
Subject: [PATCH v2] S3C: NAND: Check the existence of nr_map before copying
In-Reply-To: <1263435305-21767-1-git-send-email-ramaxlo@gmail.com>
References: <1263435305-21767-1-git-send-email-ramaxlo@gmail.com>
Message-ID: <20100114021914.GQ18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 10:15:05AM +0800, Ramax Lo wrote:
> Since the structure field nr_map is optional, we need to check whether the
> chip number map is provided to avoid unexpected NULL pointer exception.

ok, will merge this for linus
 
> Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
> ---
>  arch/arm/plat-s3c/dev-nand.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
> index 84808cc..a52fb6c 100644
> --- a/arch/arm/plat-s3c/dev-nand.c
> +++ b/arch/arm/plat-s3c/dev-nand.c
> @@ -58,8 +58,8 @@ static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
>  			return -ENOMEM;
>  	}
>  	
> -	size = sizeof(int) * set->nr_chips;
> -	if (size) {
> +	if (set->nr_map && set->nr_chips) {
> +		size = sizeof(int) * set->nr_chips;
>  		ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
>  		set->nr_map = ptr;
>  
> -- 
> 1.5.4.3
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
