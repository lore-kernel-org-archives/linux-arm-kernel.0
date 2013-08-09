From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 08 Aug 2013 18:37:49 -0700
Subject: [PATCH 1/1] clk: prima2: Fix incorrect placement of __initdata
In-Reply-To: <1375936286-32075-1-git-send-email-sachin.kamat@linaro.org>
References: <1375936286-32075-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20130809013749.5348.31283@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-08-07 21:31:26)
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Taken into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/clk-prima2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-prima2.c b/drivers/clk/clk-prima2.c
> index 643ca65..5ab95f1 100644
> --- a/drivers/clk/clk-prima2.c
> +++ b/drivers/clk/clk-prima2.c
> @@ -1034,7 +1034,7 @@ enum prima2_clk_index {
>         usb0,  usb1,  maxclk,
>  };
>  
> -static __initdata struct clk_hw* prima2_clk_hw_array[maxclk] = {
> +static struct clk_hw *prima2_clk_hw_array[maxclk] __initdata = {
>         NULL, /* dummy */
>         NULL,
>         &clk_pll1.hw,
> -- 
> 1.7.9.5
