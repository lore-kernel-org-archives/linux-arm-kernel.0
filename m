From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 13 Apr 2012 15:42:02 +0100
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
Message-ID: <1334328122.27644.15.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-13 at 15:05 +0100, Lee Jones wrote:
> +	of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
> +	if (!pdata->gpio_wp)
> +		pdata->gpio_wp = -1;
> +
> +	of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
> +	if (!pdata->gpio_cd)
> +		pdata->gpio_cd = -1;

I think you should use of_gpio_named_count(np, "XX-gpios") here rather
then of_property_read() - there's more to GPIOs than just a number...

Cheers!

Pawe?
