From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Aug 2015 19:56:31 -0600
Subject: [PATCH v4 4/5] spi: bcm2835: new driver implementing auxiliar
 spi1/spi2 on the bcm2835 soc
In-Reply-To: <1440405608-3995-5-git-send-email-kernel@martin.sperl.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
 <1440405608-3995-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <55DD1CCF.4080808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2015 02:40 AM, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>

Patch description?

>  arch/arm/configs/bcm2835_defconfig |    1 +
>  drivers/spi/Kconfig                |   12 +
>  drivers/spi/Makefile               |    1 +
>  drivers/spi/spi-bcm2835aux.c       |  506 ++++++++++++++++++++++++++++++++++++

A change to the defconfig would be applied by the RPi maintainers, and a
change to drivers/spi by the SPI maintainers. Those need to be in
different patches.

> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c

> +static int bcm2835aux_spi_probe(struct platform_device *pdev)

> +	clk_prepare_enable(bs->clk);

Error checking?

> +	/* enable HW block */
> +	bcm2835aux_enable(&pdev->dev, ENABLE_PROPERTY);

The return value needs to be error-checked, so that deferred probe can
work, and so other kinds of errors can be detected. Wasn't this correct
in a previous patch version?

Note that I didn't review any code besides probe(), remove() and the
driver boiler-plate that refers to those functions.
