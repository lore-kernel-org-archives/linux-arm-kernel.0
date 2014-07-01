From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Jul 2014 18:48:44 +0100
Subject: [PATCH 1/2] ASoC: sirf: Add audio usp interface driver
In-Reply-To: <1404181134-21663-2-git-send-email-rongjun.ying@csr.com>
References: <1404181134-21663-1-git-send-email-rongjun.ying@csr.com>
 <1404181134-21663-2-git-send-email-rongjun.ying@csr.com>
Message-ID: <20140701174844.GA410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 10:18:53AM +0800, Rongjun Ying wrote:

A few *really* trivial things below, otherwise this looks good:

> +	if (usp->daifmt_format == SND_SOC_DAIFMT_I2S)
> +		regmap_update_bits(usp->regmap, USP_RX_FRAME_CTRL,
> +			USP_I2S_SYNC_CHG, USP_I2S_SYNC_CHG);
> +	else if (usp->daifmt_format == SND_SOC_DAIFMT_DSP_A) {
> +		regmap_update_bits(usp->regmap, USP_RX_FRAME_CTRL,
> +			USP_I2S_SYNC_CHG, 0);
> +		frame_len = data_len * params_channels(params);
> +		data_len = frame_len;
> +	}

Make this a switch statement for legibility, and if you do need to use {
} make sure they're used consistently for all branches of an if ().

> +	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;

I'm not sure the extra variable adds much here.

> +static struct snd_soc_dai_driver sirf_usp_pcm_dai = {
> +	.probe = sirf_usp_pcm_dai_probe,
> +	.name		= "sirf-usp-pcm",
> +	.id			= 0,

Weird indentation here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/ccf15b7c/attachment.sig>
