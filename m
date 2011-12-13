From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 13 Dec 2011 11:02:27 -0700
Subject: [PATCH] gpio: pl061: drop extra check for NULL platform_data
In-Reply-To: <1323471368-7955-1-git-send-email-robherring2@gmail.com>
References: <1323471368-7955-1-git-send-email-robherring2@gmail.com>
Message-ID: <20111213180227.GA4871@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 04:56:08PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In adding DT binding support, the check for NULL platform_data got added
> back in inadvertently, so remove it.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Applied, thanks.

g.

> ---
> Linus or Grant, 
> 
> Can you apply this fix for 3.2-rc.
> 
> Thanks,
> Rob
> 
>  drivers/gpio/gpio-pl061.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index 093c90b..4102f63 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c
> @@ -238,10 +238,6 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
>  	int ret, irq, i;
>  	static DECLARE_BITMAP(init_irq, NR_IRQS);
>  
> -	pdata = dev->dev.platform_data;
> -	if (pdata == NULL)
> -		return -ENODEV;
> -
>  	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>  	if (chip == NULL)
>  		return -ENOMEM;
> -- 
> 1.7.5.4
> 
