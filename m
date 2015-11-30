From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Nov 2015 16:17:05 +0000
Subject: [PATCH] ASoC: sun4i: Implement MIC1 capture
In-Reply-To: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151130161705.GY1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 04:37:47PM +0100, Maxime Ripard wrote:

A couple of minor issues below but I'll apply this - please send
followup patches.

> +static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
> +{
> +	/*
> +	 * FIXME: according to the BSP, we might need to drive a PA
> +	 *        GPIO high here on some boards
> +	 */

That's not something this driver needs to worry about, that's something
the machine driver will do - the whole purpose is to glue all the
different components on the board together.

> +	if (clk_set_rate(scodec->clk_module, clk_freq))
> +		return -EINVAL;

It'd be better to pass back the error code from clk_set_rate().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/c06aef94/attachment.sig>
