From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 28 Oct 2014 13:28:22 +0900
Subject: [PATCHv2 1/2] ARM: EXYNOS: Add EXYNOS4415 SoC ID
In-Reply-To: <544F15F0.9080102@samsung.com>
References: <1414373759-4362-1-git-send-email-cw00.choi@samsung.com>
 <1414373759-4362-2-git-send-email-cw00.choi@samsung.com>
 <02b501cff262$127d44b0$3777ce10$@kernel.org> <544F15F0.9080102@samsung.com>
Message-ID: <031101cff267$9b8daba0$d2a902e0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanwoo Choi wrote:
> 
> Dear Kukjin,
> 

[...]

> >>
> >> +config SOC_EXYNOS4415
> >> +	bool "SAMSUNG EXYNOS4415"
> >> +	default y
> >> +	depends on ARCH_EXYNOS4
> >> +
> >
> > I think, this is not required more...
> 
> But,
> The clock driver must need to CONFIG_SOC_EXYNOS4415 configuration
> to build it. The clock driver[1] of exynos4415 used CONFIG_SOC_EXYNOS4415 as following diff:
>   [1] https://lkml.org/lkml/2014/10/26/159
> 
Oh, yes. OK.

Thanks for quick reply.

- Kukjin

> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index 8909c93..4561297 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o clk-cpu.o
>  obj-$(CONFIG_SOC_EXYNOS3250)	+= clk-exynos3250.o
>  obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
> +obj-$(CONFIG_SOC_EXYNOS4415)	+= clk-exynos4415.o
> 
> Best Regards,
> Chanwoo Choi
