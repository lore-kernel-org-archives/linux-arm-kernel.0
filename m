From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 18:36:22 +0000
Subject: [PATCH v4 1/2] spi: Add new driver for STMicroelectronics' SPI
 Controller
In-Reply-To: <1418156491-26613-2-git-send-email-lee.jones@linaro.org>
References: <1418156491-26613-1-git-send-email-lee.jones@linaro.org>
 <1418156491-26613-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20141222183622.GI17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 08:21:30PM +0000, Lee Jones wrote:
> This patch adds support for the SPI portion of ST's SSC device.

I've applied both of these, though I had to rename the DT binding
document and...

> +static int spi_st_clk_enable(struct spi_st *spi_st)
> +{
> +	/*
> +	 * Current platforms use one of the core clocks for SPI and I2C.
> +	 * If we attempt to disable the clock, the system will hang.
> +	 *
> +	 * TODO: Remove this when platform supports power domains.
> +	 */
> +	return 0;
> +
> +	return clk_prepare_enable(spi_st->clk);
> +}

...this is not good at all and a step back from the previous version -
if there are problems with the SoC integration they need to be fixed
there or possibly in the clock driver for the SoC rather than bodging
individual drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/e24a282c/attachment.sig>
