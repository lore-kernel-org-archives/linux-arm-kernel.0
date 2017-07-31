From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 31 Jul 2017 12:58:10 +0200
Subject: [PATCH] pinctrl: sirf: atlas7: Initialize GPIO offset
In-Reply-To: <20170720170107.14612-1-thierry.reding@gmail.com>
References: <20170720170107.14612-1-thierry.reding@gmail.com>
Message-ID: <20170731105810.GI26667@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 07:01:07PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The GPIO offset is never initialized, which means that it will end up
> being zero as per the devm_kzalloc() of the parent structure.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> I have no idea how the driver could've ever worked for anything other
> than instances with a single bank, but maybe it did and I missed some
> detail.
> 
>  drivers/pinctrl/sirf/pinctrl-atlas7.c | 1 +
>  1 file changed, 1 insertion(+)

Any comments on this one?

Thierry

> 
> diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
> index 36b5c8d5471e..a2ca4a9472c7 100644
> --- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
> +++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
> @@ -6078,6 +6078,7 @@ static int atlas7_gpio_probe(struct platform_device *pdev)
>  		bank = &a7gc->banks[idx];
>  		/* Set ctrl registers' base of this bank */
>  		bank->base = ATLAS7_GPIO_BASE(a7gc, idx);
> +		bank->gpio_offset = idx * NGPIO_OF_BANK;
>  
>  		/* Get interrupt number from DTS */
>  		ret = of_irq_get(np, idx);
> -- 
> 2.13.3
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/e3b94dbb/attachment.sig>
