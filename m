From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Jan 2013 09:18:37 +0100
Subject: [PATCH 5/5] ARM: exynos: enable/disable cpuidle when cpu1 is
 down/up
In-Reply-To: <00be01cdf52f$1bc907c0$535b1740$@samsung.com>
References: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
 <1357318799-24378-5-git-send-email-daniel.lezcano@linaro.org>
 <CADGdYn7y_SSmLoEpeRjL8PDSZS-YJwC1QpRcUocSSnDyM8BRhQ@mail.gmail.com>
 <50EF3369.2060902@free.fr>
 <CADGdYn4eRbkZt_Rshqg-a_CoAmF5LBobzT3=3h09syaH0z6uJA@mail.gmail.com>
 <50F551F3.2060400@linaro.org> <00be01cdf52f$1bc907c0$535b1740$@samsung.com>
Message-ID: <50F9055D.8090708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2013 04:51 AM, Kukjin Kim wrote:
> Daniel Lezcano wrote:
>> On 01/10/2013 11:33 PM, amit daniel kachhap wrote:
>>> On Thu, Jan 10, 2013 at 1:32 PM, Daniel Lezcano <daniel.lezcano@free.fr>
>> wrote:
>>>> On 01/10/2013 09:07 PM, amit daniel kachhap wrote:
>>>>> Hi Daniel,
>>>> Hi Amit Daniel,
>>>>
>>>>> This hotplug noifiers looks fine. I suppose it should add extra state
>>>>> C1 in cpu0. If it is done like below than for normal cases(when all
>>>>> cpu's are online) there wont be any statistics for C0 state
>>>> I guess you meant state 0 which is WFI, right ?
>>>> C0 state is the intel semantic for cpu fully turned on.
>>> Yes I meant C0 as wfi
>>>>> also which
>>>>> is required. Other patches look good.
>>>> Ok, that makes sense to have statistics even if they are only doing WFI.
>>>>
>>>> Then the patch 4/5 is not ok, no ?
>>> yes I suppose patch 4 and patch 5 are related and depends how you
>>> frame patch 5. I think it is better to create C0/C1 sysfs and other
>>> things in the beginning because it is a filesystem call and may
>>> increase the cpu hotplug time which is not worth. May be if cpuidle
>>> framework exposes some API to enable/disable states then it is better.
>>>
>>> For patch 1,2 and 3,
>>> Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Hi Kukjin,
>>
>> is it possible to take these patches [1-3/5] ?
>>
> Looks OK to me, I will apply with Amit's ack.

Cool Thanks !

>> The patches [3-4/5] could be ignored.
>>
> Probably, you mean [4-5/5] :-)

Oh, yes. Right ! :)

-- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
