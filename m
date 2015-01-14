From: rsahu@apm.com (Rameshwar Sahu)
Date: Wed, 14 Jan 2015 14:56:33 +0530
Subject: [PATCH v2 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <1701652.4qUlzcU1j2@wuerfel>
References: <1420628981-22774-1-git-send-email-rsahu@apm.com>
 <1420628981-22774-2-git-send-email-rsahu@apm.com>
 <CAFd313xp5rZZZSSKk-DDTC4ccY9ZucGgmWrc9oG-TiK2FMBS1g@mail.gmail.com>
 <1701652.4qUlzcU1j2@wuerfel>
Message-ID: <CAFd313zMoW86ZcXURrk2K+E6129L+BruOp4E0A=w0PQEcMr-Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,





Thanks,
with regards,
Ram


On Tue, Jan 13, 2015 at 12:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 12 January 2015 14:40:09 Rameshwar Sahu wrote:
>> > +
>> > +       dma_set_mask_and_coherent(&pdev->dev,
>> > +                                 (sizeof(dma_addr_t) == sizeof(u64)) ?
>> > +                                 DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
>> > +
>>
>
> I commented on this on v1 already: always set the device specific mask here,
> it's independent of the CPU architecture, but do check the return value.
>
Got it, I will set first 64 bit dma mask here  due to device support
64 bit address dma operations, and fall down to 32 - bit in case
failure with 64 bit.


> Also add the correct dma-ranges property in the parent, or else this will
> fail in the future once we add proper checks to dma_set_mask.

I see arch/arm64 kernel doesn't use dma range value parsed from
dma-range property currently, I will check it more.
It doesn't use dma_pfn_offset value calculated by the dma-ranges in
dma mapping API.
dma-ranges value should test properly before adding.
Is there any use to add this dma-ranges properly if arch code doesn't support ??

>
>         Arnd
