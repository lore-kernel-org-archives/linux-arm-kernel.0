From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 17 Nov 2014 19:26:46 +0100
Subject: [PATCH V2 2/5] i2c: pxa: prepare/unprepare clocks
In-Reply-To: <1416236863-20898-2-git-send-email-dbaryshkov@gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-2-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141117182646.GD12644@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 06:07:40PM +0300, Dmitry Eremin-Solenikov wrote:
> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().

You describe what is done but we can see that from the patch. Please
describe here why the change is needed.

> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..2e75375 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1297,7 +1297,7 @@ static int i2c_pxa_suspend_noirq(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
>  
> -	clk_disable(i2c->clk);
> +	clk_disable_unprepare(i2c->clk);
>  
>  	return 0;
>  }
> @@ -1307,7 +1307,7 @@ static int i2c_pxa_resume_noirq(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
>  
> -	clk_enable(i2c->clk);
> +	clk_prepare_enable(i2c->clk);
>  	i2c_pxa_reset(i2c);
>  
>  	return 0;
> -- 
> 2.1.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/7086b8e0/attachment.sig>
