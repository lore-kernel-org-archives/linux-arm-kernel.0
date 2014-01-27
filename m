From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 27 Jan 2014 13:52:57 -0800
Subject: [PATCH-next] drivers/clk: make max77686 driver bool for now
In-Reply-To: <1390505535-30229-1-git-send-email-paul.gortmaker@windriver.com>
References: <1390505535-30229-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20140127215257.4167.26286@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Paul Gortmaker (2014-01-23 11:32:15)
> Commit 3966c947f45911e093114371462687134d5e8d40 ("clk: max77686:
> Refactor driver data handling") added a call to __clk_get_hw()
> but this function is not exported (as __<name> is typically a
> private/internal thing).
> 
> Hence this driver fails to build modular, and has been causing
> allmodconfig build breakage in arch outside of just ARM.  Since
> the only defconfig that uses it sets it as =y, lets just make
> it non-modular for now.
> 
> Mike says that changes are pending to export similar functionality
> in the future[1], so at that point in time, it can be returned to
> tristate if desired.

Hi Paul,

I've just sent off my 2nd pull request for 3.14 and it includes the
export for __clk_get_hw.

Regards,
Mike

> 
> [1] https://lkml.org/lkml/2014/1/20/21
> 
> Reported-by: SeongJae Park <sj38.park@gmail.com>
> Cc: SeongJae Park <sj38.park@gmail.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index efb508a..009fb9b 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -40,7 +40,7 @@ config COMMON_CLK_VERSATILE
>           - Versatile Express
>  
>  config COMMON_CLK_MAX77686
> -       tristate "Clock driver for Maxim 77686 MFD"
> +       bool "Clock driver for Maxim 77686 MFD"
>         depends on MFD_MAX77686
>         ---help---
>           This driver supports Maxim 77686 crystal oscillator clock. 
> -- 
> 1.8.5.2
> 
