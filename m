From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 24 Jul 2013 14:23:39 +0200
Subject: [PATCH v4 1/1] ARM: EXYNOS: Update CONFIG_ARCH_NR_GPIO for Exynos
In-Reply-To: <0eb101ce8865$60f1d920$22d58b60$@org>
References: <1374655405-22998-1-git-send-email-sachin.kamat@linaro.org>
 <51EFB023.6090804@samsung.com>
 <CAK9yfHyMcyWJh6Jv0ZK1t=+hMhD44qE3WccaLnwFM=tK8ab6GQ@mail.gmail.com>
 <0eb101ce8865$60f1d920$22d58b60$@org>
Message-ID: <51EFC74B.8000403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2013 02:00 PM, Kukjin Kim wrote:
> Kukjin Kim wrote:
>> Sachin Kamat wrote:
[...]
>>>>> @@ -1590,8 +1590,7 @@ config ARM_PSCI
>>>>>  config ARCH_NR_GPIO
>>>>>       int
>>>>>       default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
>>>>> -     default 512 if SOC_OMAP5
>>>>> -     default 512 if ARCH_KEYSTONE
>>>>> +     default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5
>>>>
>>>> Sorry, 512 seems a bit too generous to me. Also I would rather
>>>> leave each SOC/ARCH on a separate line.
>>>
>>> Even I had left it that way earlier. However Kukjin suggested the
>>> above (single line).
>>> I feel it is more of individual preference.
>>>
>> I know it is quite big but I think if we want to use the large number, I'd
>> preferred to use enough the large number so that we don't need to update
>> it soon. If so, multiple line is useless...
>>
>> Note, according to git log, for omap5, 256 is the accurately right number.

If it's done similarly for other SoCs then I'm fine with change as above.
256 entries is only about 3 kB anyway, it shouldn't be a big deal for
systems using those SoCs.

>>>> Almost half of those 512 entries would have been unused in most
>>>> cases. How about, e.g. 352 ? If anyone finds this value too low
>>>> they could always submit a patch like this one. IMHO with 352 or
>>>> 392 there would be sufficient margin.
>>>
>> Hmm...
>>
>>> I agree. Again, I do not have any reservations here. I just went with
>>> maintainer's choice which was a superset of your and Tomasz's
>>> suggestions :)
>
> If you have another opinion on this, please let me know before sending fixes
> for 3.11 probably tomorrow morning in my time.

I'm OK with that change. Sorry for the trouble.

--
Thanks,
Sylwester
