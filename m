From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 03:59:36 +0900
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <562A8209.7090305@kernel.org>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
 <CAGOxZ51_JPy51htzD_M_=qaPVUexkVhoA2ANLS2-rpK3QDT=8A@mail.gmail.com>
 <1606098.olLAyTIhB3@dell2.five-lan.de> <56272C1C.8040007@samsung.com>
 <562765F3.9010306@osg.samsung.com>
 <CAGOxZ52-ia8uhgGg5CiU9TSYkfAsRD52zvLqq++Y-mr4uaFOpg@mail.gmail.com>
 <5627A75E.60509@osg.samsung.com> <562A8209.7090305@kernel.org>
Message-ID: <562A8398.8010600@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/15 03:52, Kukjin Kim wrote:
> On 10/21/15 23:55, Javier Martinez Canillas wrote:
>> Hello Alim,
>>
>> On 10/21/2015 04:50 PM, Alim Akhtar wrote:
>>
>> [snip]
>>
>>>>
>>>> [0]:
>>>> From c9b250ee03bae338339b70693e906145c719f783 Mon Sep 17 00:00:00 2001
>>>> From: Javier Martinez Canillas <javier@osg.samsung.com>
>>>> Date: Wed, 21 Oct 2015 11:59:44 +0200
>>>> Subject: [RFT PATCH] mmc: pwrseq: Use highest priority for eMMC restart
>>>>  handler
>>>>
>>>> The pwrseq_emmc driver does a eMMC card reset before a system reboot to
>>>> allow broken or limited ROM boot-loaders, that don't have an eMMC reset
>>>> logic, to be able to read the second stage from the eMMC.
>>>>
>>>> But this has to be called before a system reboot handler and while most
>>>> of them use the priority 128, there are other restart handlers (such as
>>>> the syscon-reboot one) that use a higher priority. So, use the highest
>>>> priority to make sure that the eMMC hw is reset before a system reboot.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>> ---
>>> Looks good.
>>> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>>>
>>
>> Thanks, should I post it as a proper patch or are adding it to your
>> series? I think the latter is more reasonable so with an ack from Ulf,
>> all patches can go through the linux-samsung tree.
>>  
> Javier,
> 
> Can you please post your fix right now? so that I could take this series
> for v4.4 of late pull-request...
> 
I found the patch in linux-arm-kernel ml just now....let me see. Please
kindly ignore previous my comments...

Thanks,
Kukjin
