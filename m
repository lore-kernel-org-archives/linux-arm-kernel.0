From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 31 Mar 2012 13:33:33 +0200
Subject: [alsa-devel] [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile
 error	since dma api is changed
In-Reply-To: <1333197468-3263-1-git-send-email-b29396@freescale.com>
References: <1333197468-3263-1-git-send-email-b29396@freescale.com>
Message-ID: <4F76EB8D.2060200@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2012 02:37 PM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The following compiling error is caused by the API device_prep_dma_cyclic
> is changed. Using dmaengine_prep_dma_cyclic to fix it.
> 
> sound/soc/soc-dmaengine-pcm.c: In function 'dmaengine_pcm_prepare_and_submit':
> sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to function 'chan->device->device_prep_dma_cyclic'
> make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 

Hi,

There is already a fix for this in Mark's for-3.4 branch.
