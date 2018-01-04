From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 4 Jan 2018 09:25:24 +0000
Subject: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
In-Reply-To: <20180103194151.GA21040@codeaurora.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
 <4db358ab-3171-bb08-ca26-ec9bf282e8d4@linaro.org>
 <20180103194151.GA21040@codeaurora.org>
Message-ID: <e595cb26-e48b-335a-28bc-353a2a7d641a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/01/18 19:41, Stephen Boyd wrote:
>>>> +	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
>>> Why do we need to do this? Can you add some sort of comment in the code
>>> about why?
>> Even though dsp supports 64 bit addresses, but the sid sits at
>> offset of 32, which brings this restriction of supporting only 32
>> bit iova.
>>
> Doesn't the dsp have an iommu in place to make the address
> translation from 64 to 32 bits transparent? I thought this was
> what dma-ranges and iommu binding was for, but I'm not well
> versed on all the details here.
Thanks for reminding, dma-ranges would work too, I will give that a go 
in next version.

--srini
