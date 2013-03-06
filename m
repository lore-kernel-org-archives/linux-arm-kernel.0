From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Mar 2013 17:13:33 +0000
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130306171333.GR17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 10:37:27PM +0800, Shawn Guo wrote:
> With generic DMA device tree binding and helper function
> dma_request_slave_channel() in place, dmaengine_pcm should support
> that in requesting DMA channel for users that support generic DMA
> device tree binding.

This purpetuates the brain-dead behaviour of the existing ASoC DMA
engine layer, which makes it unsuitable for platforms with special DMA
memory requirements.

The problem is that the DMA mask to be used for allocating DMA-able
memory is the DMA engine struct device, not the struct device associated
with the ASoC device.

I got this right in my ASoC generic DMA engine layer.  Converting this
layer is far from trivial though, and as my test platform has now become
my entire network firewall, I'm not doing any testing on that anymore.
