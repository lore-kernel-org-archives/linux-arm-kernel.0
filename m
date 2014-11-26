From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 26 Nov 2014 10:35:15 +0900
Subject: [PATCH] ARM: exynos: print CPU id on probe
In-Reply-To: <1416884886-9896-1-git-send-email-olof@lixom.net>
References: <1416884886-9896-1-git-send-email-olof@lixom.net>
Message-ID: <060f01d00919$3aec6e30$b0c54a90$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> It's useful to get the CPU ID/rev printed during boot sometimes, so
> add a line with that information. Given that the fields have moved
> within the register over time, don't try to be clever and parse it --
> just print the raw values for now.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Kukjin, please apply if you're OK with this. Thanks!
> 
Yes, why not? I'll apply, I have small concerns for exynos5800 though ;)

Thanks,
Kukjin

> 
> -Olof
> 
>  arch/arm/plat-samsung/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
> index 360618ee39e5..71333bb61013 100644
> --- a/arch/arm/plat-samsung/cpu.c
> +++ b/arch/arm/plat-samsung/cpu.c
> @@ -40,10 +40,14 @@ void __init s3c64xx_init_cpu(void)
>  	}
> 
>  	samsung_cpu_rev = 0;
> +
> +	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
>  }
> 
>  void __init s5p_init_cpu(void __iomem *cpuid_addr)
>  {
>  	samsung_cpu_id = __raw_readl(cpuid_addr);
>  	samsung_cpu_rev = samsung_cpu_id & 0xFF;
> +
> +	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
>  }
> --
> 2.0.1.473.gc4d58ca
