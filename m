From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Nov 2013 11:38:00 +0000
Subject: [PATCH] ASoC: samsung: Initialize the dma_data for secondary dai
In-Reply-To: <1385632932-16579-1-git-send-email-padma.v@samsung.com>
References: <1385632932-16579-1-git-send-email-padma.v@samsung.com>
Message-ID: <20131128113800.GB27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 03:32:12PM +0530, Padmavathi Venna wrote:

> This is made based on Mark Brown for-next branch of sound.git
> This patch is based on Mark Brown below patches for
> generic dma engine support for samsung audio IPs.
> ASoC: samsung: Use ASoC dmaengine code where possible
> ASoC: samsung: Provide helper for DMA init

Why don't we need this fix for mainline?  The dmaengine change is just
moving the initialisation through a layer of indirection but there was
initialisation anyway.  I'm concerned that there's a bug that ought to
be fixed for v3.13 as well here.

>  	return snd_dmaengine_pcm_register(dev, &samsung_dmaengine_pcm_config,
> -					  SND_DMAENGINE_PCM_FLAG_COMPAT);
> +					  SND_DMAENGINE_PCM_FLAG_COMPAT |
> +				SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME);

This is already done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/bb5af53d/attachment.sig>
