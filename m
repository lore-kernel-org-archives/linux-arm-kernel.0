From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 3 Apr 2012 20:43:07 -0500
Subject: [PATCH v2 2/3] ep93xx: IDE driver platform support code
In-Reply-To: <4F7B0D6C.1010801@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0D6C.1010801@metasoft.pl>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698409F59@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 03, 2012 7:47 AM, Rafal Prylowski wrote:

<snip>

> +int ep93xx_ide_acquire_gpio(struct platform_device *pdev)
> +{
> +	int err;
> +	int i;
> +
> +	for (i = 2; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_E(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_e;
> +	}
> +	for (i = 4; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_G(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_g;
> +	}
> +	for (i = 0; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_H(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_h;
> +	}

EP93XX_GPIO_LINE_EGPIO2 and EP93XX_GPIO_LINE_EGPIO15 are also used by the
IDE interface as the DMARQ and DASPn signals. They should be requested to make sure
nobody uses them when the IDE driver is loaded.

Regards,
Hartley
