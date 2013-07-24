From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 24 Jul 2013 16:26:00 -0700
Subject: [PATCH 2/2] clk: fixup argument order when setting VCO parameters
In-Reply-To: <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
Message-ID: <20130724232600.7598.95231@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jonathan Austin (2013-07-23 08:42:18)
> The order of arguments in the call to vco_set() for the ICST clocks appears to
> have been switched in error, which results in the VCO not being initialised
> correctly. This in turn stops the integrated LCD on things like Integrator/CP
> from working correctly.
> 
> This patch fixes the order and restores the expected functionality.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>

Thanks for the fix. Will send out with the next batch.

Regards,
Mike

> ---
>  drivers/clk/versatile/clk-icst.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
> index 67ccf4a..f5e4c21 100644
> --- a/drivers/clk/versatile/clk-icst.c
> +++ b/drivers/clk/versatile/clk-icst.c
> @@ -107,7 +107,7 @@ static int icst_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>         vco = icst_hz_to_vco(icst->params, rate);
>         icst->rate = icst_hz(icst->params, vco);
> -       vco_set(icst->vcoreg, icst->lockreg, vco);
> +       vco_set(icst->lockreg, icst->vcoreg, vco);
>         return 0;
>  }
>  
> -- 
> 1.7.9.5
