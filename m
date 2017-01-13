From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Jan 2017 13:36:21 +0100
Subject: [PATCH] iommu/dma: Add support for DMA_ATTR_FORCE_CONTIGUOUS
In-Reply-To: <0e5c066f-ddf6-30ce-392e-79bd0f401a18@arm.com>
References: <1484305674-15018-1-git-send-email-geert+renesas@glider.be>
 <d336ef3b-4fe6-5ebb-9fed-071fa79028df@arm.com>
 <CAMuHMdWBfTm_QRuB7x-ZDh0bgGmHokqm7=F2b0rjQTYzizC9hA@mail.gmail.com>
 <0e5c066f-ddf6-30ce-392e-79bd0f401a18@arm.com>
Message-ID: <CAMuHMdVnteoor56EYG1Ka7t0o8+OKNehGnk6YUciTXdEQ5KKcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Fri, Jan 13, 2017 at 1:17 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/01/17 11:59, Geert Uytterhoeven wrote:
>> On Fri, Jan 13, 2017 at 12:32 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>> On 13/01/17 11:07, Geert Uytterhoeven wrote:
>>>> Add support for DMA_ATTR_FORCE_CONTIGUOUS to the generic IOMMU DMA code.
>>>> This allows to allocate physically contiguous DMA buffers on arm64
>>>> systems with an IOMMU.
>>>
>>> Can anyone explain what this attribute is actually used for? I've never
>>> quite figured it out.
>>
>> My understanding is that DMA_ATTR_FORCE_CONTIGUOUS is needed when using
>> an IOMMU but wanting the buffers to be both contiguous in IOVA space and
>> physically contiguous to allow passing to devices without IOMMU.
>>
>> Main users are graphic and remote processors.
>
> Sure, I assumed it must be to do with buffer sharing, but the systems
> I'm aware of which have IOMMUs in their media subsystems tend to have
> them in front of every IP block involved, so I was curious as to what
> bit of non-IOMMU hardware wanted to play too. The lone in-tree use in
> the Exynos DRM driver was never very revealing, and the new one I see in
> the Qualcomm PIL driver frankly looks redundant to me.

I'll let the GPU-literate people comment on that...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
