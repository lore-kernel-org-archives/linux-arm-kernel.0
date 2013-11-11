From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 11 Nov 2013 15:29:06 +0100
Subject: [PATCH] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <1384161191-24140-1-git-send-email-Baohua.Song@csr.com>
References: <1384161191-24140-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <5280E9B2.9090309@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 10:13 AM, Barry Song wrote:
[...]
> +static struct dma_chan *of_dma_sirfsoc_xlate(struct of_phandle_args *dma_spec,
> +	struct of_dma *ofdma)
> +{
> +	struct sirfsoc_dma *sdma = ofdma->of_dma_data;
> +	struct sirfsoc_dma_filter_args fargs;
> +
> +	if (!sdma)
> +		return NULL;
> +
> +	if (dma_spec->args_count != 1)
> +		return NULL;
> +
> +	fargs.sdma = sdma;
> +	fargs.chan_id = dma_spec->args[0];
> +
> +	return dma_request_channel(sdma->cap, sirfsoc_dma_dt_filter, &fargs);
> +}

There is now the dma_get_slave_channel() function which makes it a bit
cleaner to implement this. I think you can use the k3dma driver as an example.

- Lars
