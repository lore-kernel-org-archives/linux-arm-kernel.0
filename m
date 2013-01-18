From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 17 Jan 2013 19:57:39 -0800
Subject: [PATCH] arm: mach-s3c24xx/common.c: fix uninitialized variable
 warning
In-Reply-To: <1358185860-5425-1-git-send-email-dinggnu@gmail.com>
References: <1358185860-5425-1-git-send-email-dinggnu@gmail.com>
Message-ID: <00bf01cdf52f$f7c7d8f0$e7578ad0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cong Ding wrote:
> 
> the use of variable tmp is uninitialized, so we fix it.
> 
> Signed-off-by: Cong Ding <dinggnu@gmail.com>
> ---
>  arch/arm/mach-s3c24xx/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-
> s3c24xx/common.c
> index 0c9e9a7..6bcf87f 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -197,7 +197,7 @@ static unsigned long s3c24xx_read_idcode_v4(void)
> 
>  static void s3c24xx_default_idle(void)
>  {
> -	unsigned long tmp;
> +	unsigned long tmp = 0;
>  	int i;
> 
>  	/* idle the system by using the idle mode which will wait for an
> --
> 1.7.9.5

Yes, correct. Applied.

Thanks.

- Kukjin
