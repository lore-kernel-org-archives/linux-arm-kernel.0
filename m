From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jan 2018 14:03:19 +0000
Subject: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
In-Reply-To: <418b531d-9d51-80c5-85aa-8ab8ef27bebb@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
 <20180104120244.GE10774@sirena.org.uk>
 <418b531d-9d51-80c5-85aa-8ab8ef27bebb@linaro.org>
Message-ID: <20180104140319.GH10774@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 01:44:30PM +0000, Srinivas Kandagatla wrote:

> Initially I had this in pcm driver, but looking at example usage of
> snd_dma_alloc_pages, most of them use card->dev and some of them use pcm
> device for allocating dma memory.

If they're using card->dev for DMA they're messing up, they need to use
the device associated with the DMA controller.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/4d88de45/attachment.sig>
