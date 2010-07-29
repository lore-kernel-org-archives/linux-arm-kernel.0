From: stepanm@codeaurora.org (stepanm at codeaurora.org)
Date: Wed, 28 Jul 2010 17:58:50 -0700 (PDT)
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <201007281950.20847.arnd@arndb.de>
References: <1280270466-13503-1-git-send-email-stepanm@codeaurora.org>
	<201007281039.44883.arnd@arndb.de>
	<ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<201007281950.20847.arnd@arndb.de>
Message-ID: <bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wednesday 28 July 2010, stepanm at codeaurora.org wrote:
>> > On Wednesday 28 July 2010 00:41:06 Stepan Moskovchenko wrote:
>> >> Add support for the System MMUs found on the 8x60 and 8x72
>> >> families of Qualcomm chips. These SMMUs allow virtualization
>> >> of the address space used by most of the multimedia cores
>> >> on these chips.
>> >
>> > How is this different from an IOMMU?
>> >
>> > From a very brief look, it seems that you should be using the
>> > existing dma-mapping APIs here instead of making up your own.
>> >
>> > 	Arnd
>>
>>
>> These are just SMMU APIs, and the DMA-mapping API is one layer above
>> this.
>>
>> We have our own SMMU API for the MSM SoCs because we have muliple
>> IOMMUs,
>> each one having multiple contexts, or even having multiple instances of
>> the same context. Our usage model is also quite a bit different from how
>> the DMA APIs are set up. I believe only two IOMMU drivers actually make
>> use of the DMA API (Intel and AMD) and the other ones (OMAP and other
>> SoCs) have their own APIs for their specific use cases.
>
> The DMA API is extremely flexible, it works just fine with all the
> IOMMUs that I've seen so far. Please take a look at
> include/asm-generic/dma-mapping-common.h and its users to see how
> to use multiple IOMMUs depending on the device.
>
> If the OMAP developers got this wrong, that's not your problem :-)
>
> 	Arnd

Hi Arnd,
