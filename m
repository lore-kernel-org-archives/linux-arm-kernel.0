From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 10:27:15 +0100
Subject: [PATCH 1/2] ASoC: sgtl5000: Let the codec acquire its clock
In-Reply-To: <1370826467-30399-1-git-send-email-festevam@gmail.com>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
Message-ID: <20130610092715.GH31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 10:07:46PM -0300, Fabio Estevam wrote:

> -	if (IS_ERR(data->codec_clk)) {
> -		/* assuming clock enabled by default */
> -		data->codec_clk = NULL;
> -		ret = of_property_read_u32(codec_np, "clock-frequency",
> -					&data->clk_frequency);
> -		if (ret) {
> -			dev_err(&codec_dev->dev,
> -				"clock-frequency missing or invalid\n");
> -			goto fail;
> -		}

Applied but this means that the binding document needs to be updated to
remove the clock-frequency property.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/5a2535da/attachment.sig>
