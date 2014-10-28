From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 14:58:50 +0000
Subject: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO
 interface
In-Reply-To: <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141028145850.GU18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
> Since LoCoMo driver has been converted to provide proper gpiolib
> interface, make poodle ASoC platform driver use gpiolib API.

Please use subject lines matching the style for the subsystem.

> +	ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
> +	if (ret) {
> +		dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
> +				ret);
> +		return ret;
> +	}

I sense a need for devm_gpio_request_array() here.  Otherwise this looks
fine - ideally it'd move to gpiod but moving to gpiolib is a clear win
so no need to block on this.

Acked-by: Mark Brown <broonie@kernel.org>

with at least the subject line fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/acbd1c7e/attachment.sig>
