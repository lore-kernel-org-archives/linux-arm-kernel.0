From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 13 Apr 2013 15:40:04 +0200
Subject: [alsa-devel] [PATCH v2 00/11] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <20130413133202.GA4573@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <5161CB73.4000302@metafoo.de> <20130407200843.GA8350@pengutronix.de>
 <5161D876.6020007@metafoo.de> <20130413133202.GA4573@pengutronix.de>
Message-ID: <51696034.6060709@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2013 03:32 PM, Markus Pargmann wrote:
> On Sun, Apr 07, 2013 at 10:35:02PM +0200, Lars-Peter Clausen wrote:
>> On 04/07/2013 10:08 PM, Markus Pargmann wrote:
>>> Hi,
>>>
>>> On Sun, Apr 07, 2013 at 09:39:31PM +0200, Lars-Peter Clausen wrote:
>>>> On 04/07/2013 09:25 PM, Markus Pargmann wrote:
>>>>> Hi,
>>>>>
>>>>> This series adds DT support for phycore-ac97 using the fsl-ssi driver. In
>>>>> version 2 I discarded most of the imx-ssi work and integrated the ac97-slave
>>>>> support in fsl-ssi, including support for imx-pcm-fiq as alternative to dma.
>>>>> There are some other changes to get phycore-ac97 working. The first two patches
>>>>> have notes about the detailed changes since version 1. The rest of the patches
>>>>> is new and necessary for the ac97-slave support.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Markus
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> The DMA PCM related changes won't apply anymore due to the recent dmaengine
>>>> PCM cleanups. I've also been working on a more generic dmaengine PCM driver
>>>> which has DT support and can be used by imx. The work in progress patches
>>>> can be found here:
>>>> https://github.com/lclausen-adi/linux-2.6/commits/asoc-dmaengine-cleanups
>>>>
>>>> - Lars
>>>
>>> Okay, I will rebase it for v3 onto your committed cleanups and will have
>>> a look on your latest patches.
>>>
>>
>> It might be a good idea to rebase it ontop of the generic dmaengine driver
>> patches right away, since it will simplify things quite a bit.
> 
> I rebased the series onto your branch now. But there is a small problem
> with the DMA handling.
> 
> Currently you pass the device pointer into snd_dmaengine_pcm_register
> and use it to request the dma channels. At least for imx-pcm-audio
> driver, it would be useful to pass a second device just for the dma
> requests. Otherwise imx-pcm-audio needs devicetree bindings, but I think
> the dma properties belong to fsl-ssi.
> 

I though about that as well, just initialize of_node of the newly allocated
imx-pcm-audio platform device to that of the parent device. That should work
nicely.

- Lars
