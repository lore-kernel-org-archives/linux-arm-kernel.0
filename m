From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 3 Jul 2016 23:08:21 +0200
Subject: [PATCH] phy: fix error handling
In-Reply-To: <1467525332-12963-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1467525332-12963-1-git-send-email-christophe.jaillet@wanadoo.fr>
Message-ID: <00d5243a-0359-1dc7-e9aa-1ad8a9074821@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I will resubmit in the coming days.

    return PTR_ERR(phy->clk);
should also be updated.

Best regards,
CJ

Le 03/07/2016 ? 07:55, Christophe JAILLET a ?crit :
> This is likely that checking 'phy->hsic_clk' instead of 'phy->clk' is
> expected here.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/phy/phy-sun9i-usb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/phy-sun9i-usb.c b/drivers/phy/phy-sun9i-usb.c
> index ac4f31a..ff99eba 100644
> --- a/drivers/phy/phy-sun9i-usb.c
> +++ b/drivers/phy/phy-sun9i-usb.c
> @@ -141,7 +141,7 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
>   		}
>   
>   		phy->hsic_clk = devm_clk_get(dev, "hsic_12M");
> -		if (IS_ERR(phy->clk)) {
> +		if (IS_ERR(phy->hsic_clk)) {
>   			dev_err(dev, "failed to get hsic_12M clock\n");
>   			return PTR_ERR(phy->clk);
>   		}
