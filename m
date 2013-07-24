From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 24 Jul 2013 08:58:27 +0200
Subject: [PATCH 7/9] ASoC: tegra: move to generic DMA DT binding
In-Reply-To: <1374639002-16753-8-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-8-git-send-email-rizhao@nvidia.com>
Message-ID: <51EF7B13.4050207@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2013 06:10 AM, Richard Zhao wrote:
> - add tegra_dma_filter_data to specify dma info
>    DMA DT binding needs the device that raise dma request and dma name
>    to request a dma channel. tegra30_i2s is a special case. It should be ahub
>    device and it also has dma name that cannot handled by ASoC dmaengine code.
>    So we pass the info using filter data in snd_dmaengine_dai_dma_data.

How about extending the generic dmaengine PCM driver so that it is possible to 
specify the the DMA channel names? I think that will make the code a bit 
simpler and also allow you to remove tegra_pcm.c completely eventually.

- Lars
