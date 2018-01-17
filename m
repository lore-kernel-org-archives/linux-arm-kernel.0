From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 16:19:16 +0900
Subject: [PATCH v2 05/13] iommu/rockchip: Fix error handling in init
In-Reply-To: <5A5EF7D3.90405@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-6-jeffy.chen@rock-chips.com>
 <CAAFQd5AFHheE+5Dx=0=BeL2W1EYd=Kmcb8fKcCBFRgP8ViuxgQ@mail.gmail.com>
 <5A5EF7D3.90405@rock-chips.com>
Message-ID: <CAAFQd5D2YE+5g5r4-1cnqeThSVJBCg78mozCTuFfpwnifaGcwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 4:14 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> On 01/17/2018 01:26 PM, Tomasz Figa wrote:
>>
>> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com>
>> wrote:
>>>
>>> It's hard to undo bus_set_iommu() in the error path, so move it to the
>>> end of rk_iommu_probe().
>>
>>
>> Does this work fine now? I remember we used to need this called in an
>> early initcall for all the ARM/ARM64 DMA stuff to work.
>>
> yes, i think it works now, i saw there are some other iommu drivers also do
> this(arm-smmu-v3, mtk_iommu) :)

Okay, if so:

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

P.S. Looks like your email client is set to HTML messages. Your
messages might end up dropped from the mailing list.
