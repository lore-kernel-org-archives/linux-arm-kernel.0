From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Thu, 22 Oct 2015 09:24:47 +0530
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <56282B2D.6000708@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
 <CAGOxZ51_JPy51htzD_M_=qaPVUexkVhoA2ANLS2-rpK3QDT=8A@mail.gmail.com>
 <1606098.olLAyTIhB3@dell2.five-lan.de> <56272C1C.8040007@samsung.com>
 <562765F3.9010306@osg.samsung.com>
 <CAGOxZ52-ia8uhgGg5CiU9TSYkfAsRD52zvLqq++Y-mr4uaFOpg@mail.gmail.com>
 <5627A75E.60509@osg.samsung.com>
 <CAGOxZ537QuzBP4tcG9qh-+iXK-Y=WwZGiJ1-cwtLqwRf0a+wVA@mail.gmail.com>
 <56282B2D.6000708@samsung.com>
Message-ID: <56285E07.9070500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/22/2015 05:47 AM, Krzysztof Kozlowski wrote:
> On 22.10.2015 00:01, Alim Akhtar wrote:
>> On Wed, Oct 21, 2015 at 8:25 PM, Javier Martinez Canillas
>> <javier@osg.samsung.com> wrote:
>>> Hello Alim,
>>>
>>> On 10/21/2015 04:50 PM, Alim Akhtar wrote:
>>>
>>> [snip]
>>>
>>>>>
>>>>> [0]:
>>>>>  From c9b250ee03bae338339b70693e906145c719f783 Mon Sep 17 00:00:00 2001
>>>>> From: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>> Date: Wed, 21 Oct 2015 11:59:44 +0200
>>>>> Subject: [RFT PATCH] mmc: pwrseq: Use highest priority for eMMC restart
>>>>>   handler
>>>>>
>>>>> The pwrseq_emmc driver does a eMMC card reset before a system reboot to
>>>>> allow broken or limited ROM boot-loaders, that don't have an eMMC reset
>>>>> logic, to be able to read the second stage from the eMMC.
>>>>>
>>>>> But this has to be called before a system reboot handler and while most
>>>>> of them use the priority 128, there are other restart handlers (such as
>>>>> the syscon-reboot one) that use a higher priority. So, use the highest
>>>>> priority to make sure that the eMMC hw is reset before a system reboot.
>>>>>
>>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>> ---
>>>> Looks good.
>>>> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>>>>
>>>
>
> +Cc Ulf,
>
> Javier,
>
> First of all, thanks Javier for digging into the issue. Actually I have
> Odroid U3 but because of user-space limitations (which I need for other
> work) I cannot test all of mainline patches there.
>
>
>>> Thanks, should I post it as a proper patch or are adding it to your
>>> series?
>> Suggest you to post as a patch collecting {Tested, Reviewed}-by (easy
>> for maintainers to pickup ) and probably CCing Ulf for his feedback.
>>
>>> I think the latter is more reasonable so with an ack from Ulf,
>>> all patches can go through the linux-samsung tree.
>>>
>> yes, that is reasonable, as I said, let Krzysztof and Ulf take a call here.
>
> Javier, Alim, Ulf,
>
> I am not grabbing any more patches for v4.4 because I doubt that they
> could be merged to arm-soc for this cycle. My last pull requests for
> v4.4 is still pending...
>
> This means that I plan to pick up these series for v4.5, after closing
> v4.4 merge window (unless Kukjin picks it also). Because of that, we
> have plenty of time, so my idea is:
> 1. Wait for some comments from Ulf on Javier's fix.
> 2. If the fix goes into v4.4, then problem solved.
> 3. If not and it get acked, then it can go with this set.
> 4. If not and it get applied by Ulf for v4.5, then a tag from him would
> be a nice way to solve dependency.
>
> Either way we don't have to hurry, I think.
>
I am fine, no hurry, lets give these a bit more time to hear from other.
Thanks
> Best regards,
> Krzysztof
>
