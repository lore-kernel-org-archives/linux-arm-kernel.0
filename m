From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 6 Oct 2010 20:12:44 -0700
Subject: [PATCH 2/2] ASoC: EDB93xx machine sound driver
In-Reply-To: <4CAD1952.9030702@bluewatersys.com>
References: <4CAD16A5.1090501@bluewatersys.com>
	<4CAD1952.9030702@bluewatersys.com>
Message-ID: <20101007031243.GA32312@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 07, 2010 at 01:50:26PM +1300, Ryan Mallon wrote:

> +	ret = gpio_request(EP93XX_GPIO_LINE_EGPIO6, "CS4271 SFRM1 Disable");
> +	if (ret)
> +		return ret;
> +	ret = gpio_direction_output(EP93XX_GPIO_LINE_EGPIO6, 0);
> +	if (ret)
> +		goto free_EGPIO6;
> +
> +	ret = gpio_request(EP93XX_GPIO_LINE_EGPIO1, "CS4271 Reset");
> +	if (ret)
> +		goto free_EGPIO6;
> +	ret = gpio_direction_output(EP93XX_GPIO_LINE_EGPIO1, 1);
> +	if (ret)
> +		goto free_EGPIO1;

It'd seem to make sense for these to be handled by the CODEC driver,
using platform data to supply the GPIOs so that their management can be
integrated with the CODEC flow?

Otherwise this looks good.
