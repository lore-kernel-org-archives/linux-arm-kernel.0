From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 14 Nov 2013 09:05:38 +0100
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <52847FBE.9070501@linaro.org>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>
 <52843855.5060509@linaro.org> <52847FBE.9070501@linaro.org>
Message-ID: <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaojie,

AFAICT, It's a none issue. In full nohz, a timer fires periodically
(around 4sec period on ARM IIRC) on one cpu (cpu0).

CC'ing Frederic

Regards,
Vincent



On 14 November 2013 08:46, Alex Shi <alex.shi@linaro.org> wrote:
> On 11/14/2013 10:41 AM, Alex Shi wrote:
>> CC to kernel mailing list.
>>
>> What's you expected result for twd?
>
> BTW, the upstream kernel has same results for twd.
>>
>>
>> On 11/14/2013 08:36 AM, Shaojie Sun wrote:
>>> Hi all
>>>      When I enble NO_HZ_FULL and NO_HZ_FULL_ALL option in K3V2 board.
>>> I find that the twd interrupt will be trigged in a large time pre
>>> second.
>>>      In our landing team branch, we used lsk branch.
>>>
>>>      Do you find this bugs on your board? And how to resolve it?
>>>
>>>
>>>>> cat /proc/interrupts
>>>
>>>              CPU0     CPU1
>>>  29:        293        395       GIC  twd
>>>
>>
>>
>
>
> --
> Thanks
>     Alex
