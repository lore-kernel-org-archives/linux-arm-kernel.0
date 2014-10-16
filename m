From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Oct 2014 09:30:04 +0200
Subject: [PATCH] spi/atmel: add support for runtime PM
In-Reply-To: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20141016073004.GL27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 09:49:20AM +0800, Wenyou Yang wrote:

> +static int atmel_spi_runtime_resume(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct atmel_spi *as = spi_master_get_devdata(master);
> +
> +	pinctrl_pm_select_default_state(dev);
> +	clk_prepare_enable(as->clk);
> +

This looks mostly good but you should check the return value of
clk_prepare_enable() - it can fail.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141016/49d90527/attachment.sig>
