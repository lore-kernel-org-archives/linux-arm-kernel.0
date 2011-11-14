From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Nov 2011 13:30:27 -0800
Subject: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
In-Reply-To: <1320407441-29697-3-git-send-email-rnayak@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
 <1320407441-29697-3-git-send-email-rnayak@ti.com>
Message-ID: <20111114213026.GP31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [111104 04:16]:
> @@ -1869,6 +1957,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>  	struct omap_hsmmc_host *host = NULL;
>  	struct resource *res;
>  	int ret, irq;
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(omap_mmc_of_match, &pdev->dev);
> +	if (match) {
> +		pdata = of_get_hsmmc_pdata(&pdev->dev);
> +		if (match->data)
> +			pdata->reg_offset = *(u16 *)match->data;
> +	}

So this is now using both DT and pdata?

We want to use DT only, and get rid of pdata. Other than the
deferred probe, is there some other dependency remaining to
having to use the pdata also?

Regards,

Tony
