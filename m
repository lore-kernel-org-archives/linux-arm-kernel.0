From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Mar 2013 16:22:06 +0100
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <514B21F3.90803@metafoo.de>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
Message-ID: <20130321152206.GA14768@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 04:06:27PM +0100, Lars-Peter Clausen wrote:

> Hm, I only saw this series today would have been good to be on Cc. I've been
> working on something very similar. My series goes a bit further though, it
> implements an (almost generic) dmaengine based PCM driver using the of
> bindings. So you need almost no platform code. The only things that are
> platform specific at the moment is the pcm_hardware struct, but I'd like to
> replace that in the future with something that queries the pcm hardware
> parameter like max_period from the DMA engine driver. And another bit that is
> still driver specific is a callback that fills the dma_slave_config struct.

FWIW it might be worth looking at the one rmk wrote but has never wanted
to submit for whatever reason.

> In my series the channels are requested at probe time, so it is possible to
> handle -EPROBE_DEFER properly and also we can allocate the audio buffers with
> the dma device instead of the sound device, so stupid hacks like

>     card->dev->dma_mask = &dma_mask;
>     card->dev->coherent_dma_mask = DMA_BIT_MASK(32);

> anymore. I'll try to post the series tomorrow.

This is the main thing his code has got that the library hasn't, it's
certainly the only issue he keeps mentioning.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130321/13b047e0/attachment.sig>
