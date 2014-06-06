From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Jun 2014 10:57:06 +0100
Subject: [PATCH 2/5] ASoC: wm8904: switch to CCF
In-Reply-To: <1401963572-10953-3-git-send-email-voice.shen@atmel.com>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
 <1401963572-10953-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20140606095706.GB2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 06:19:29PM +0800, Bo Shen wrote:

> +		if (wm8904->mclk)
> +			clk_prepare_enable(wm8904->mclk);

There's no point in having checks for MCLK here since...

> +	wm8904->mclk = devm_clk_get(&i2c->dev, "mclk");
> +	if (IS_ERR(wm8904->mclk)) {
> +		ret = PTR_ERR(wm8904->mclk);
> +		dev_err(&i2c->dev, "Failed to get MCLK\n");
> +		return ret;
> +	}

...we require a clock here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/13d186bc/attachment.sig>
