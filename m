From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Jul 2011 08:27:21 +0900
Subject: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <1310483085-31442-2-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
Message-ID: <20110712232719.GB17710@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 11:04:36PM +0800, Dong Aisheng wrote:

> +	if (dai->driver->capture.channels_min) {
> +		ret = mxs_pcm_preallocate_dma_buffer(pcm,
> +			SNDRV_PCM_STREAM_CAPTURE);
> +		if (ret)
> +			goto out;
> +	}

For robustness replace the channels_min check with a check for the
relevant substream being present (see pxa2xx-pcm.c for a recent
example).
