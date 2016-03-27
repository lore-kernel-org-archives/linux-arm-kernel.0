From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 27 Mar 2016 17:21:50 +0200
Subject: [PATCH V2 2/3] vfio, platform: make reset driver a requirement
In-Reply-To: <56E96D4C.3080008@codeaurora.org>
References: <1457715275-11925-1-git-send-email-okaya@codeaurora.org>
 <1457715275-11925-3-git-send-email-okaya@codeaurora.org>
 <56E5A271.6000408@codeaurora.org> <56E8E2CD.3020604@linaro.org>
 <56E96D4C.3080008@codeaurora.org>
Message-ID: <56F7FA8E.9000707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,
On 03/16/2016 03:27 PM, Sinan Kaya wrote:
> Hi Baptiste,
> 
>>> I couldn't see a reset function for AMBA devices.
>>>
>>> Is there anyway to write reset function for it? I have no experience with 
>>> AMBA devices.
>> To my knowledge only the PL330 DMA controller (drivers/dma/pl330.c) was
>> passthrough'ed at some point, rather for development purpose than
>> production purpose. This was done by Virtual Open Systems (ask Baptiste
>> for more details). But I don't think this is really used.
> 
> Are you OK with requiring reset driver for AMBA devices too? The PL330 
> driver won't work until a reset driver is submitted for it.
> 
>>>
>>> Would you include a reset needed flag and just not require it for AMBA? 
>>> (I honestly don't like this idea)
>>>
>> I think the requirement also makes sense for AMBA.
>>
>> Maybe an option would be to add a module parameter that would allow to
>> use the vfio platform/amba driver without reset module (with explicit
>> opt-in from the user). Maybe this can be done later on.
> 
> I can see this flag useful for testing purposes but it should not be used in 
> production.
> 
> How about I add a module parameter which is not set by default? When set,
> I don't perform the reset requirement check.
Yes that's what I meant

Best Regards

Eric
> 
>>
>> FYI I will not have access to my mailbox until the end of the week.
> 
> OK, no rush.
> 
>>
>> Best Regards
>>
>> Eric
>>
> 
> 
