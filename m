From: mporter@linaro.org (Matt Porter)
Date: Thu, 20 Feb 2014 15:56:15 -0500
Subject: [PATCH v2 2/3] clk: bcm281xx: don't disable unused peripheral
 clocks
In-Reply-To: <1392402560-12929-3-git-send-email-elder@linaro.org>
References: <1392402560-12929-1-git-send-email-elder@linaro.org>
 <1392402560-12929-3-git-send-email-elder@linaro.org>
Message-ID: <20140220205615.GF5038@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 12:29:19PM -0600, Alex Elder wrote:
> Add the CLK_IGNORE_UNUSED flag when setting up a peripheral clock.
> This prevents unused clocks from getting disabled, and by doing
> this we can use the common clock code even before we've resolved
> all the spots that need to get a reference to their clock.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Matt Porter <mporter@linaro.org>

Mike: if you'll provide your ack on this patch, we would like to take
the entire series through arm-soc for 3.15 as we originally agreed
for 3.14. Patches 1 and 3 are the original two you acked for 3.14
but had to be dropped late in the merge window.

Thanks,
Matt

> ---
>  drivers/clk/bcm/clk-kona-setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
> index f1e88fe..c7607fe 100644
> --- a/drivers/clk/bcm/clk-kona-setup.c
> +++ b/drivers/clk/bcm/clk-kona-setup.c
> @@ -579,7 +579,7 @@ static int peri_clk_setup(struct ccu_data *ccu, struct peri_clk_data *data,
>  			struct clk_init_data *init_data)
>  {
>  	init_data->ops = &kona_peri_clk_ops;
> -	init_data->flags = 0;
> +	init_data->flags = CLK_IGNORE_UNUSED;
>  
>  	return clk_sel_setup(data->clocks, &data->sel, init_data);
>  }
> -- 
> 1.7.9.5
> 
