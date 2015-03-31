From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 31 Mar 2015 09:39:30 +0200
Subject: [alsa-devel] [PATCH] ASoC: atmel-pcm-dma: increase
 buffer_bytes_max
In-Reply-To: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <551A4F32.10608@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2015 09:40 PM, Alexandre Belloni wrote:
> atmel-pcm-dma is not limited to a buffer size of 64kB like atmel-pcm-pdc.
> Increase buffer_bytes_max to 512kB to allow for higher bit rates (i.e. 32bps at
> 192kHz) to work correctly. By default, keep the prealloc at 64kB.

Patch per se looks good. But can you test if it works to just throw 
atmel_pcm_dma_hardware away completely and rely on the dmaengine PCM driver 
getting the capabilities directly from the DMA driver. Since the DMA driver 
now reports its capabilities I think it should work, and if it does that's 
the preferred solution.

- Lars
