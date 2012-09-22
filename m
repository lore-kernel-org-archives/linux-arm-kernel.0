From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 21 Sep 2012 18:07:11 -0700
Subject: [PATCH 2/3] clk: Add devm_clk_{register,unregister}()
In-Reply-To: <505BD206.9070600@codeaurora.org>
References: <1348034730-16473-1-git-send-email-sboyd@codeaurora.org>
 <1348034730-16473-3-git-send-email-sboyd@codeaurora.org>
 <505BD206.9070600@codeaurora.org>
Message-ID: <20120922010711.12878.76877@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2012-09-20 19:33:42)
> On 09/18/12 23:05, Stephen Boyd wrote:
> > +void devm_clk_unregister(struct device *dev, struct clk *clk)
> > +{
> > +     WARN_ON(devres_destroy(dev, devm_clk_release, devm_clk_match, clk));
> 
> Hm... I guess this needs to be devres_release() instead of destroy. Can
> you squash this in or should I resend for the few character change?
> 

I'm not taking any more changes for 3.7, so in the interest of me being
lazy can you resend with the fixup?

Thanks,
Mike

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 6852809..f02f4fe 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1509,7 +1509,7 @@ static int devm_clk_match(struct device *dev, void *res, void *data)
>   */
>  void devm_clk_unregister(struct device *dev, struct clk *clk)
>  {
> -       WARN_ON(devres_destroy(dev, devm_clk_release, devm_clk_match, clk));
> +       WARN_ON(devres_release(dev, devm_clk_release, devm_clk_match, clk));
>  }
>  EXPORT_SYMBOL(devm_clk_unregister);
>  
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
