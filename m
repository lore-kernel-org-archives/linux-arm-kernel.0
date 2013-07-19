From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Jul 2013 19:06:40 +0100
Subject: [PATCH] ASoC: atmel: add wm8904 based audio machine driver
In-Reply-To: <1374226977-10188-1-git-send-email-voice.shen@atmel.com>
References: <1374226977-10188-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20130719180640.GS9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 05:42:57PM +0800, Bo Shen wrote:
> Add wm8904 based audio machine driver for Atmel EK board

Applied, thanks though...

> +	mclk = clk_get(NULL, "pck0");
> +	if (IS_ERR(mclk)) {
> +		dev_err(&pdev->dev, "failed to get pck0\n");
> +		ret = PTR_ERR(mclk);
> +		goto err_set_audio;
> +	}
> +
> +	clk_src = clk_get(NULL, "clk32k");
> +	if (IS_ERR(clk_src)) {
> +		dev_err(&pdev->dev, "failed to get clk32k\n");
> +		ret = PTR_ERR(clk_src);
> +		goto err_set_audio;
> +	}

These should really be devm_clk_get()s and use a device.  This can be
revisited after the common clock framework conversion though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130719/11eb3e56/attachment.sig>
