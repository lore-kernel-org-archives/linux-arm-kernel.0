From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 May 2013 12:22:48 -0700
Subject: [PATCH] clk: ux500: abx500-clk: rename ux500 audio codec aliases
In-Reply-To: <1366964092-7672-1-git-send-email-fabio.baltieri@linaro.org>
References: <1366964092-7672-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130514192248.10068.29001@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Baltieri (2013-04-26 01:14:52)
> Change soc-audio related clk_register_clkdev() device names to reflect
> the ones actually used in current snd-soc-mop500 and ab8500-codec
> drivers.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Taken into clk-next.

Thanks!
Mike

> ---
>  drivers/clk/ux500/abx500-clk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/ux500/abx500-clk.c b/drivers/clk/ux500/abx500-clk.c
> index a0fca00..e7bd62c 100644
> --- a/drivers/clk/ux500/abx500-clk.c
> +++ b/drivers/clk/ux500/abx500-clk.c
> @@ -45,7 +45,7 @@ static int ab8500_reg_clks(struct device *dev)
>                                 CLK_IS_ROOT);
>         clk_register_clkdev(clk, "sysclk", "ab8500-usb.0");
>         clk_register_clkdev(clk, "sysclk", "ab-iddet.0");
> -       clk_register_clkdev(clk, "sysclk", "ab85xx-codec.0");
> +       clk_register_clkdev(clk, "sysclk", "snd-soc-mop500.0");
>         clk_register_clkdev(clk, "sysclk", "shrm_bus");
>  
>         /* ab8500_sysclk2 */
> @@ -70,19 +70,19 @@ static int ab8500_reg_clks(struct device *dev)
>                 AB8500_SYSULPCLKCTRL1, AB8500_SYSULPCLKCTRL1_ULPCLKREQ,
>                 AB8500_SYSULPCLKCTRL1_ULPCLKREQ,
>                 38400000, 9000, CLK_IS_ROOT);
> -       clk_register_clkdev(clk, "ulpclk", "ab85xx-codec.0");
> +       clk_register_clkdev(clk, "ulpclk", "snd-soc-mop500.0");
>  
>         /* ab8500_intclk */
>         clk = clk_reg_sysctrl_set_parent(dev , "intclk", intclk_parents, 2,
>                 intclk_reg_sel, intclk_reg_mask, intclk_reg_bits, 0);
> -       clk_register_clkdev(clk, "intclk", "ab85xx-codec.0");
> +       clk_register_clkdev(clk, "intclk", "snd-soc-mop500.0");
>         clk_register_clkdev(clk, NULL, "ab8500-pwm.1");
>  
>         /* ab8500_audioclk */
>         clk = clk_reg_sysctrl_gate(dev , "audioclk", "intclk",
>                 AB8500_SYSULPCLKCTRL1, AB8500_SYSULPCLKCTRL1_AUDIOCLKENA,
>                 AB8500_SYSULPCLKCTRL1_AUDIOCLKENA, 0, 0);
> -       clk_register_clkdev(clk, "audioclk", "ab85xx-codec.0");
> +       clk_register_clkdev(clk, "audioclk", "ab8500-codec.0");
>  
>         return 0;
>  }
> -- 
> 1.8.1.3
