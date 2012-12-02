From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Dec 2012 13:30:38 +0900
Subject: [PATCH 2/2] ASoC: atmel-pcm: dma support based on pcm dmaengine
In-Reply-To: <1354074373-7671-2-git-send-email-voice.shen@atmel.com>
References: <1354074373-7671-1-git-send-email-voice.shen@atmel.com>
 <1354074373-7671-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20121202043036.GW17981@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 11:46:13AM +0800, Bo Shen wrote:
> Specify overrun bit in interrupt mask
> Add dmaengine specific routines

Applied, thanks.

> +	struct snd_pcm_substream *substream)
> +{
> +	struct atmel_pcm_dma_params *prtd;
> +
> +	prtd = snd_dmaengine_pcm_get_data(substream);
> +
> +	if (ssc_sr & prtd->mask->ssc_error) {
> +		if (snd_pcm_running(substream))

It is a bit weird that this is not part of the SSC code...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121202/bed384bc/attachment.sig>
