From: saaguirre@ti.com (Aguirre, Sergio)
Date: Wed, 13 Jan 2010 12:26:23 -0600
Subject: [PATCH] S3C: NAND: Check the existence of nr_map before copying
In-Reply-To: <1263403884-8495-1-git-send-email-ramaxlo@gmail.com>
References: <> <1263403884-8495-1-git-send-email-ramaxlo@gmail.com>
Message-ID: <A24693684029E5489D1D202277BE8944514AD033@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ramax,

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Ramax Lo
> Sent: Wednesday, January 13, 2010 11:31 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: ben-linux at fluff.org
> Subject: [PATCH] S3C: NAND: Check the existence of nr_map before copying
> 
> We need to check whether the chip number map is provided to avoid
> unexpected
> NULL pointer exception.
> 
> Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
> ---
>  arch/arm/plat-s3c/dev-nand.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
> index 84808cc..34697de 100644
> --- a/arch/arm/plat-s3c/dev-nand.c
> +++ b/arch/arm/plat-s3c/dev-nand.c
> @@ -58,8 +58,8 @@ static int __init s3c_nand_copy_set(struct
> s3c2410_nand_set *set)
>  			return -ENOMEM;
>  	}
> 
> -	size = sizeof(int) * set->nr_chips;
> -	if (size) {
> +	if (set->nr_map) {

Shouldn't the above condition be:

	if (set->nr_map && set->nr_chips) {

?

Regards,
Sergio

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
