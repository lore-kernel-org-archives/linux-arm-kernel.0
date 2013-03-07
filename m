From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 7 Mar 2013 10:33:19 +0800
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <20130306171333.GR17833@n2100.arm.linux.org.uk>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
Message-ID: <20130307023316.GA22554@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 05:13:33PM +0000, Russell King - ARM Linux wrote:

> This purpetuates the brain-dead behaviour of the existing ASoC DMA
> engine layer, which makes it unsuitable for platforms with special DMA
> memory requirements.

> The problem is that the DMA mask to be used for allocating DMA-able
> memory is the DMA engine struct device, not the struct device associated
> with the ASoC device.

> I got this right in my ASoC generic DMA engine layer.  Converting this
> layer is far from trivial though, and as my test platform has now become
> my entire network firewall, I'm not doing any testing on that anymore.

Could you go into more detail here please?  Looking at the code I'm not
seeing any allocations done by the library code at all, the allocations
are all done by the individual platform DMA drivers so I don't see
anything stopping them doing what they need.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/0bb5bfe6/attachment.sig>
