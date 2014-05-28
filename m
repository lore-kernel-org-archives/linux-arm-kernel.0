From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 28 May 2014 00:57:07 -0700
Subject: [PATCH 1/1] clk/exynos4: Fix compilation warning
In-Reply-To: <1401077788-31427-1-git-send-email-sachin.kamat@linaro.org>
References: <1401077788-31427-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140528075707.10062.7113@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2014-05-25 21:16:28)
> Fixes the following warning:
> WARNING: drivers/built-in.o(.text.unlikely+0x2c50): Section mismatch in reference from the function exynos4_clk_sleep_init() to the (unknown reference) .init.data:(unknown)
>    The function exynos4_clk_sleep_init() references
>    the (unknown reference) __initdata (unknown).
>    This is often because exynos4_clk_sleep_init lacks a __initdata
>    annotation or the annotation of (unknown) is wrong.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>

Applied to clk-next.

Thanks!
Mike

> ---
>  drivers/clk/samsung/clk-exynos4.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index c4df294bb7fb..4f150c9dd38c 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -324,7 +324,7 @@ static struct syscore_ops exynos4_clk_syscore_ops = {
>         .resume = exynos4_clk_resume,
>  };
>  
> -static void exynos4_clk_sleep_init(void)
> +static void __init exynos4_clk_sleep_init(void)
>  {
>         exynos4_save_common = samsung_clk_alloc_reg_dump(exynos4_clk_regs,
>                                         ARRAY_SIZE(exynos4_clk_regs));
> @@ -359,7 +359,7 @@ err_warn:
>                 __func__);
>  }
>  #else
> -static void exynos4_clk_sleep_init(void) {}
> +static void __init exynos4_clk_sleep_init(void) {}
>  #endif
>  
>  /* list of all parent clock list */
> -- 
> 1.7.9.5
> 
