From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 26 Nov 2013 11:20:48 +0100
Subject: [alsa-devel] [PATCH] ASoC: kirkwood: Fix invalid SPDIF format
In-Reply-To: <20131126104140.16e3eb87@armhf>
References: <20131126104140.16e3eb87@armhf>
Message-ID: <s5h8uwba2gv.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 26 Nov 2013 10:41:40 +0100,
Jean-Francois Moine wrote:
> 
> This patch removes the 32 bits format which is not supported by S/PDIF
> output.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Not against the patch itself, but just found looking through it:

> @@ -493,7 +497,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
>  		.rates = SNDRV_PCM_RATE_8000_192000 |
>  			 SNDRV_PCM_RATE_CONTINUOUS |
>  			 SNDRV_PCM_RATE_KNOT,

Setting both CONTINUOUS and KNOT doesn't make sense.


Takashi
