From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Feb 2014 07:19:19 +0900
Subject: [PATCH] ARM: SAMSUNG: remove unneeded s3c24xx_init_cpu()
In-Reply-To: <3865198.Kyn1P03kbU@phil>
References: <3865198.Kyn1P03kbU@phil>
Message-ID: <52FD44E7.3080004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/14 05:34, Heiko St?bner wrote:
> The function is nearly empty and samsung_cpu_rev is static so already 0
> making the function obsolete, therefore remove it.
>
> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
> ---
>   arch/arm/mach-s3c24xx/common.c           |    1 -
>   arch/arm/plat-samsung/cpu.c              |    7 -------
>   arch/arm/plat-samsung/include/plat/cpu.h |    1 -
>   3 files changed, 9 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
> index bf57d4c..97edd4d 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -232,7 +232,6 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
>   	} else {
>   		samsung_cpu_id = s3c24xx_read_idcode_v4();
>   	}
> -	s3c24xx_init_cpu();
>
>   	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
>
> diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
> index 46b426e..364963a 100644
> --- a/arch/arm/plat-samsung/cpu.c
> +++ b/arch/arm/plat-samsung/cpu.c
> @@ -28,13 +28,6 @@ unsigned int samsung_rev(void)
>   }
>   EXPORT_SYMBOL(samsung_rev);
>
> -void __init s3c24xx_init_cpu(void)
> -{
> -	/* nothing here yet */
> -
> -	samsung_cpu_rev = 0;
> -}
> -
>   void __init s3c64xx_init_cpu(void)
>   {
>   	samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0x118);
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
> index 8f09488..262ef86 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -207,7 +207,6 @@ extern void s5p_init_irq(u32 *vic, u32 num_vic);
>
>   extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
>
> -extern void s3c24xx_init_cpu(void);
>   extern void s3c64xx_init_cpu(void);
>   extern void s5p_init_cpu(void __iomem *cpuid_addr);
>

Applied, thanks.
- Kukjin
