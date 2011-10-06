From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 6 Oct 2011 16:49:07 +0100
Subject: [PATCH 2/2] hw_random: add driver for atmel true hardware
	random number generator
In-Reply-To: <1317915694-27564-2-git-send-email-jacmet@sunsite.dk>
References: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
	<1317915694-27564-2-git-send-email-jacmet@sunsite.dk>
Message-ID: <20111006154904.GE12975@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 05:41:34PM +0200, Peter Korsgaard wrote:

> +	trng->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(trng->clk))
> +		return PTR_ERR(trng->clk);
> +
> +	ret = clk_enable(trng->clk);
> +	if (ret)
> +		goto err_enable;

Is it worth enabling the hardware enabled only when the device is open?
