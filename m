From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 28 Oct 2015 12:42:35 +0100
Subject: [PATCH v4 4/6] reset: sunxi: Add Allwinner H3 bus resets
In-Reply-To: <1445964626-6484-5-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-5-git-send-email-jenskuske@gmail.com>
Message-ID: <1446032555.12590.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

Am Dienstag, den 27.10.2015, 17:50 +0100 schrieb Jens Kuske:
[...]
> --- a/drivers/reset/reset-sunxi.c
> +++ b/drivers/reset/reset-sunxi.c
> @@ -75,7 +75,9 @@ static struct reset_control_ops sunxi_reset_ops = {
>  	.deassert	= sunxi_reset_deassert,
>  };
>  
> -static int sunxi_reset_init(struct device_node *np)
> +static int sunxi_reset_init(struct device_node *np,
> +			    int (*of_xlate)(struct reset_controller_dev *rcdev,
> +				    const struct of_phandle_args *reset_spec))

I'd add a tab to the indentation and drop the of_xlate parameter names.
If you agree to this change, I'll fix it up when I apply it.

best regards
Philipp
