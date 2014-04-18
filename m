From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Apr 2014 17:38:49 +0100
Subject: [PATCH 4/5] ASoC: simple-card: Support setting mclk via a fixed
 factor
In-Reply-To: <1397749994-24983-5-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-5-git-send-email-andrew@lunn.ch>
Message-ID: <20140418163849.GJ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 05:53:13PM +0200, Andrew Lunn wrote:

> +- simple-audio-card,mclk-factor		: Multiplication factor between stream rate and codec
> +					  mclk.

The normal name for this is fs rather than factor.

> +	if (priv->mclk_factor) {
> +		mclk = params_rate(params) * priv->mclk_factor;
> +		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
> +					     SND_SOC_CLOCK_IN);
> +	}

We also need to consider what happens in cases where a clock is
specified via the clocks property.  I would expect this to be used to
set the rate for that clock as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/968e5651/attachment.sig>
