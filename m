From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Mon, 08 Jun 2015 16:16:25 +0530
Subject: [RESEND 1/2] usb: ehci-exynos: Make provision for vdd regulators
In-Reply-To: <CANAwSgTi114wO63-sx=UmbxPerqKvstq=coVyqhRkzX44CDe_w@mail.gmail.com>
References: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
 <5574F97A.5030104@samsung.com>
 <CANAwSgTjx8uxyOTW8uuiqrcNzF+UwLMmML2OcDgG5Ku_56=vJQ@mail.gmail.com>
 <CAJKOXPfDmt5VMqr-P+OpWy1+jz675CFRPmtS_N0HjN4tWxfwtA@mail.gmail.com>
 <44B5E2FDCD3244AAA418BB8EC28FEA25@sisodomain.com>
 <CANAwSgTi114wO63-sx=UmbxPerqKvstq=coVyqhRkzX44CDe_w@mail.gmail.com>
Message-ID: <BF5C6ACC7D2C4E51BF0CAAA7B164B6CA@sisodomain.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Monday, June 08, 2015 3:50 PM, "Anand Moon" <linux.amoon@gmail.com>

> On 8 June 2015 at 10:58, Vivek Gautam <gautam.vivek@samsung.com> wrote:
>> Hi,
>>
>>
>>
>> On Monday, June 08, 2015 10:44 AM, "Krzysztof Kozlowski"
>> <k.kozlowski@samsung.com> wrote:
>>
>> my apologies for being late in replying to this thread.
>>
>>> 2015-06-08 13:21 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>>>
>>>> Hi Krzysztof ,
>>>>
>>>> On 8 June 2015 at 07:40, Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> wrote:
>>>>>
>>>>> On 07.06.2015 22:20, Anand Moon wrote:
>>>>>>
>>>>>> Facilitate getting required 3.3V and 1.0V VDD supply for
>>>>>> EHCI controller on Exynos.
>>>>>>
>>>>>> With the patches for regulators' nodes merged in 3.15:
>>>>>> c8c253f ARM: dts: Add regulator entries to smdk5420
>>>>>> 275dcd2 ARM: dts: add max77686 pmic node for smdk5250,
>>>>>> the exynos systems turn on only minimal number of regulators.
>>>>>>
>>>>>> Until now, the VDD regulator supplies were either turned on
>>>>>> by the bootloader, or the regulators were enabled by default
>>>>>> in the kernel, so that the controller drivers did not need to
>>>>>> care about turning on these regulators on their own.
>>>>>> This was rather bad about these controller drivers.
>>>>>> So ensuring now that the controller driver requests the necessary
>>>>>> VDD regulators (if available, unless there are direct VDD rails),
>>>>>> and enable them so as to make them working.
>>>>>>
>>>>>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>> Cc: Jingoo Han <jg1.han@samsung.com>
>>>>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>>>>> ---
>>>>>> Initial version of this patch was part of following series, though
>>>>>> they are not dependent on each other, resubmitting after rebasing.
>>>>>>
>>>>>>
>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266418.html
>>>>>
>>>>>
>>>>> So you just took Vivek's patch along with all the credits... That is 
>>>>> not
>>>>> how we usually do this.
>>>>>
>>>>> I would expect that rebasing a patch won't change the author unless 
>>>>> this
>>>>> is fine with Vivek.
>>>>>
>>>>
>>>> Sorry If I have done some mistake on my part.
>>>> I just looked at below mail chain. Before I send it.
>>>>
>>>> http://www.spinics.net/lists/linux-samsung-soc/msg44136.html
>>>
>>>
>>> I don't get it. The patch you are referring to has a proper "From"
>>> field. So please use it as an example.
>>>
>>>>
>>>> I don't want to take any credit out of it. I just re-base on the new
>>>> kernel.
>>
>> Perhaps, you would have maintained the authorship !
>>
>>>> I could not test this patch as it meant for exynos5440 boards.
>>>
>>>
>>> Are you sure? I think the driver is used on almost all of Exynos SoCs
>>> (Exynos4, Exynos5250, Exynos542x).
>>
>>
>> That's correct, as pointed by Krzysztof Kozlowski, the driver is same for
>> Exynos4 and Exynos5 series
>> of SoCs.
>>
>>> Untested code should not go to the kernel. Additionally you should
>>> mark it as not-tested. Marking such patch as non-tested could help you
>>> finding some independent tests (tests performed by someone else).
>>>
>>> To summarize my point of view:
>>> 1. Unless Vivek's says otherwise, please give him the credits with
>>> proper "from" field.
>>> 2. Issues mentioned in previous mail should be addressed (missing
>>> IS_ERR(), how disabling the regulator during suspend affects waking
>>> up).
>>> 3. The patchset must be tested, even after rebasing.
>>
>>
>> Unfortunately, I got busy  with a different project and lost track of the
>> patches posted upstream.
>> If it's not too late I can post a rebased version of the patch with 
>> previous
>> review comments addressed.
>>
>>>
>>> Best regards,
>>> Krzysztof
>>
>>
>
> Hi All,
>
> I have learned my lesson not to interfere in others work.
> It will never happen from my side again.
>
> Please accept my apology.

Please don't apologise. It's just a part of learning; learning how linux 
mainlining works.
Hope you understand. :-)


thanks
Vivek 
