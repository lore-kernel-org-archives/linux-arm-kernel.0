From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 12:06:50 +0100
Subject: [PATCH 2/5] clk: ux500: fix erroneous bit assignment
In-Reply-To: <1382087097-31627-1-git-send-email-linus.walleij@linaro.org>
References: <1382087097-31627-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131018110650.GX19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Linus Walleij wrote:

> Due to a typo or similar, the peripheral group 2 clock 11
> gate was set to bit 1 instead of bit 11. We need to fix this
> to be able to set the correct enable bit in the device tree:
> when trying to correct the bit assignment in the device tree,
> the system would hang.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mike: seeking an ACK for this as it needs to be taken into
> ARM SoC with the rest of the fixes so as not to cause
> bisection problems between the trees.
> ---
>  drivers/clk/ux500/u8500_of_clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
> index b768b50..cdeff29 100644
> --- a/drivers/clk/ux500/u8500_of_clk.c
> +++ b/drivers/clk/ux500/u8500_of_clk.c
> @@ -339,7 +339,7 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
>  
>  	clk = clk_reg_prcc_pclk("p2_pclk11", "per2clk", clkrst2_base,
>  				BIT(11), 0);
> -	PRCC_PCLK_STORE(clk, 2, 1);
> +	PRCC_PCLK_STORE(clk, 2, 11);

Ah, you found it already. Nice.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
