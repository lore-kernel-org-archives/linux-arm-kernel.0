From: joelf@ti.com (Joel Fernandes)
Date: Tue, 30 Jul 2013 00:05:25 -0500
Subject: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <51F74688.3090702@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com>
 <51F4589E.5070108@ti.com> <51F6140B.3070600@ti.com> <51F738BF.7070808@ti.com>
 <51F74688.3090702@ti.com>
Message-ID: <51F74995.2050202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 11:52 PM, Sekhar Nori wrote:> On Tuesday 30 July 2013
09:23 AM, Joel Fernandes wrote:
>> On 07/29/2013 02:04 AM, Sekhar Nori wrote:
>>> On Sunday 28 July 2013 05:02 AM, Joel Fernandes wrote:
>>>> Hi Tony or Sekhar,
>>>>
>>>> If this patch looks ok, could you pick it up for -rc cycle?
>>>>
>>>> It fixes DMA breakages after the merge window for devices for which DMA
>>>> resources are being populated in device tree instead pdev.
>>>
>>> But which DT-enabled platform in kernel is using EDMA? A grep for edma
>>> over arch/arm/boot/dts/* brings up nothing.
>>> Does this really have to go into the -rc cycle or can it wait till
>>> v3.12?
>>
>>
>> But unused channel list is also populated for private EDMA callers like
>> davinci-pcm no? IIRC, HWMOD data is also removed for McASP so EDMA for
>> those may break.
>
> Yes, but which DT-enabled platform has davinci-pcm working today?
> AFAICS, this bug affects DT-enabled platforms only.

Yes, you're right. I didn't realize nothing else is working yet. I guess
its fine then for next kernel release.

Thanks,

-Joel
