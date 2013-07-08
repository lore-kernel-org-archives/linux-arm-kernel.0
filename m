From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jul 2013 16:07:21 +0100
Subject: [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130708150721.GK27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 03:29:49PM +0200, Richard Genoud wrote:

> + *		  Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Based on sam9g20_wm8731.c by:
> + * Sedji Gaouaou <sedji.gaouaou@atmel.com>

The obvious question here is of course if we can use the same driver for
both of them.

> +	codec_dai->driver->playback.rates &= SNDRV_PCM_RATE_8000 |
> +		SNDRV_PCM_RATE_32000 |
> +		SNDRV_PCM_RATE_48000 |
> +		SNDRV_PCM_RATE_96000;
> +	codec_dai->driver->capture.rates &= SNDRV_PCM_RATE_8000 |
> +		SNDRV_PCM_RATE_32000 |
> +		SNDRV_PCM_RATE_48000 |
> +		SNDRV_PCM_RATE_96000;

You definitely shouldn't be fiddling with a driver's constant static
data.  You want to be using snd_pcm_hw_constraint() APIs to set
additional constraints intead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/77d68cbb/attachment.sig>
