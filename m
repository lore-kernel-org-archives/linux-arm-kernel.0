From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 8 Jan 2015 20:57:34 +0530
Subject: [PATCH RFT 1/2] drivers: bus: check cci device tree node status
In-Reply-To: <54AE278F.4020003@arm.com>
References: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voakjWgnEXoXT1LH2ZFBy=U4vfXFXS1Su8VB7Cd3s3wqmSA@mail.gmail.com>
 <5487C897.9050405@arm.com>
 <CAM4voa=TQeOMTHmM2iBquDRwoEFPAgUFeMwJ73H4qdcSmR1Lug@mail.gmail.com>
 <5487D726.6000603@arm.com> <54AE278F.4020003@arm.com>
Message-ID: <CAM4voamaqoje8Ccz3+UxvxaHN6GBd=QC5wRjVcz9Osfc=4aeiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Thu, Jan 8, 2015 at 12:15 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Abhilash,
>
> On Wednesday 10 December 2014 10:46 AM, Sudeep Holla wrote:
>>
>>
>>
>> On Wednesday 10 December 2014 09:55 AM, Abhilash Kesavan wrote:
>>>
>>> Hi Sudeep,
>>>
>>> On Wed, Dec 10, 2014 at 9:44 AM, Sudeep Holla <sudeep.holla@arm.com>
>>> wrote:
>>>>
>>>> Hi Abhilash,
>>>>
>>>> On Wednesday 10 December 2014 09:31 AM, Abhilash Kesavan wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Fri, Nov 28, 2014 at 8:20 PM, Abhilash Kesavan
>>>>> <a.kesavan@samsung.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> The arm-cci driver completes the probe sequence even if the cci node
>>>>>> is
>>>>>> marked as disabled. Add a check in the driver to honour the cci status
>>>>>> in the device tree.
>>>>>>
>>>>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>>>>
>>>>>
>>>>>
>>>>> This patch helps disable CCI on the Arndale Octa board thus resolving
>>>>> some imprecise aborts seen on that board. Kindly review.
>>>>>
>>>>> Regards,
>>>>> Abhilash
>>>>>>
>>>>>>
>>>>>> ---
>>>>>>     drivers/bus/arm-cci.c |    3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>>>>>> index 860da40..0ce5e2d 100644
>>>>>> --- a/drivers/bus/arm-cci.c
>>>>>> +++ b/drivers/bus/arm-cci.c
>>>>>> @@ -1312,6 +1312,9 @@ static int cci_probe(void)
>>>>>>            if (!np)
>>>>>>                    return -ENODEV;
>>>>>>
>>>>>> +       if (!of_device_is_available(np))
>>>>>> +               return -ENODEV;
>>>>>> +
>>>>
>>>>
>>>>
>>>> IIUC, by this change you are disabling the MCPM boot protocol here.
>>>> Is there any alternative boot protocol that works on this platform
>>>> to boot all 8 cores ? Sorry by quick grep couldn't find one, hence
>>>> so I am asking.
>>>
>>>
>>> Thanks for the reply.
>>> On disabling MCPM, we will default to platsmp.c/firmware.c which boots
>>> 4 cores as per Kevin's comment here[1]. This was the original behavior
>>> before MCPM was enabled for all 5420 based SoCs.
>>>
>>
>> Thanks for pointing that out. I assume the firmware can handle the
>> alternate boot protocol and no more workarounds are needed especially
>> when getting CPUIdle working in this mode.
>>
>> Anyways the patch makes sense irrespective how it works on exynos, so
>> you can add,
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>
> What's the status of this patch. It was useful for me on vexpress for some
> testing. Please feel free to add
>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>
> if this is not yet queued.

Thanks for the tested-by. This patch has not been merged yet; I am not
quite sure who is supposed to pick this up.

Regards,
Abhilash
>
> Regards,
> Sudeep
>
