From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 17 Feb 2013 11:57:29 +0800
Subject: [PATCH] ARM:plat-s3c24xx: for memcpy, reading more things out
 of boundary
In-Reply-To: <5100C643.5010101@asianux.com>
References: <5100C643.5010101@asianux.com>
Message-ID: <51205529.60601@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello relative members:

  please give a glance for this patch, when you have time.

  thanks.

  :-)


gchen.


? 2013?01?24? 13:27, Chen Gang ??:
> 
>   the size is made by "plls_no + 1".
>   so when copy from original buffer, need dec 1, or reading out of boundary.
> 
> additional info:
>   plls_no is ARRARY_SIZE(plls).
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/plat-s3c24xx/cpu-freq.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/cpu-freq.c b/arch/arm/plat-s3c24xx/cpu-freq.c
> index 4680799..df093b2 100644
> --- a/arch/arm/plat-s3c24xx/cpu-freq.c
> +++ b/arch/arm/plat-s3c24xx/cpu-freq.c
> @@ -700,7 +700,8 @@ int __init s3c_plltab_register(struct cpufreq_frequency_table *plls,
>  
>  	vals = kmalloc(size, GFP_KERNEL);
>  	if (vals) {
> -		memcpy(vals, plls, size);
> +		memcpy(vals, plls,
> +			size - sizeof(struct cpufreq_frequency_table));
>  		pll_reg = vals;
>  
>  		/* write a terminating entry, we don't store it in the
> 


-- 
Chen Gang

Asianux Corporation
