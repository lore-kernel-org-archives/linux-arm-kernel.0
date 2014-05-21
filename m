From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 May 2014 09:15:34 +0200
Subject: [PATCH V5 18/20] ARM: exynos: cpuidle: Pass the AFTR callback
 to the platform_data
In-Reply-To: <5375262C.10805@samsung.com>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
 <1397212815-16068-19-git-send-email-daniel.lezcano@linaro.org>
 <201405091256.54755.arnd@arndb.de> <536CC3C6.6070804@samsung.com>
 <5370E648.10006@linaro.org> <5374CA34.1030405@samsung.com>
 <5375262C.10805@samsung.com>
Message-ID: <537C5296.7050801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2014 10:40 PM, Kukjin Kim wrote:

[ ... ]

>>>> Exynos cpuidle is not a device on the SoC, so I don't think there is
>>>> any
>>>> way to represent it in DT. The only thing I could see this is matching
>>>> root node with a central SoC driver that instantiates specific
>>>> subdevices, such as cpufreq and cpuidle, but I don't see any available
>>>> infrastructure for this.
>>>
>>> There is a RFC for defining generic idle states [1].
>>>
>>> The idea behind using the platform driver framework is to unify the code
>>> across the different drivers and separate the PM / cpuidle code.
>>>
>>> By this way, we can move the different drivers to drivers/cpuidle and
>>> store them in a single place. That make easier the tracking, the review
>>> and the maintenance.
>>>
>>> I am ok to by using platform_device_register_resndata() but I would
>>> prefer to do that a bit later by converting the other drivers too. That
>>> will be easier if we have them grouped in a single directory (this is
>>> what does this patchset at the end).
>>>
>>> As there are some more work based on this patchset and the link error
>>> could be fixed as an independent patch, I would recommend to
>>> re-integrate it in the tree as asked by Bartlomiej.
>>
>> In general, it would be nice to have everything done properly, but I'd
>> consider Daniel's series as a huge improvement already and a nice
>> intermediate step towards further clean-up.
>>
>> So based on the comments quoted above, instead of stalling the
>> development, I'd suggest to accept this series and then move forward.
>>
> I'm fine.
>
> Arnd, how about you?
>
> - Kukjin

Arnd ?


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
