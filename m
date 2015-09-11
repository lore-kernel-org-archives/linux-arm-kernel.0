From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 12:53:31 +0100
Subject: [PATCH v4 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
In-Reply-To: <1441502008-14116-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
 <1441502008-14116-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20150911115331.GM12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 06, 2015 at 09:13:28AM +0800, Shawn Lin wrote:

> @@ -460,7 +463,6 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>  	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
>  	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	i2s->playback_dma_data.maxburst = 4;
> -
>  	i2s->capture_dma_data.addr = res->start + I2S_RXDR;
>  	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	i2s->capture_dma_data.maxburst = 4;

This random whitespace change shouldn't be in here.

> @@ -489,6 +491,18 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>  		goto err_pcm_register;
>  	}
>  
> +	dma_quirk = snd_dmaengine_pcm_get_quirks(&pdev->dev);
> +	if (dma_quirk == ROCKCHIP_I2S_BROKEN_BURST_LEN) {
> +		/*

I'd expect this to be a switch statement given the way this is written.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/31c03541/attachment-0001.sig>
