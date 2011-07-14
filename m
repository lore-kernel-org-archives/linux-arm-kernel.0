From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 14 Jul 2011 14:31:06 +0200
Subject: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <1310483085-31442-2-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
Message-ID: <20110714123106.GB1904@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static struct snd_pcm_hardware snd_mxs_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_PAUSE |
> +				  SNDRV_PCM_INFO_RESUME |
> +				  SNDRV_PCM_INFO_INTERLEAVED,
> +	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> +				  SNDRV_PCM_FMTBIT_S20_3LE |
> +				  SNDRV_PCM_FMTBIT_S24_LE |
> +				  SNDRV_PCM_FMTBIT_S32_LE,
> +	.channels_min		= 2,
> +	.channels_max		= 2,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 8192,
> +	.periods_min		= 1,
> +	.periods_max		= 255,

When using madplay (for MP3) instead of aplay, I get

[ 3310.010000] mxs-dma mxs-dma-apbx: maximum number of sg exceeded: 128 > 53
[ 3310.020000] dma dma1chan4: cannot prepare slave dma

So, the mxs-dma limit should be taken into account here.

> +	.buffer_bytes_max	= 64 * 1024,
> +	.fifo_size		= 32,
> +
> +};

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110714/55aafa71/attachment.sig>
