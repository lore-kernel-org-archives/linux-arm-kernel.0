From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Sat, 9 Aug 2014 00:07:50 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <7h4mxm3l5k.fsf@paris.lan>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <53DB6B4F.9080605@arm.com> <1406890899.2794.40.camel@linaro1.home>
 <CAOesGMi0RUbz4BSnmR92dEk3fWgN=hnENSdi55VeCXdcHLRLJQ@mail.gmail.com>
 <53DB763A.10306@arm.com> <1406892491.2794.58.camel@linaro1.home>
 <53DBAAEA.2010908@arm.com> <1406908399.22757.12.camel@linaro1.home>
 <20140803032047.GB14214@quad.lixom.net> <7h4mxm3l5k.fsf@paris.lan>
Message-ID: <CAHLCerOKrO9H8Tvc=KSOyaH_zg1CGjFDWGjVrgAqZG5BcrFXwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 8, 2014 at 11:42 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Olof Johansson <olof@lixom.net> writes:
>
>>
>> At the end of the day, b.L switcher has predictable user behavior, while
>> running with assymetric SMP does not.
>
> What is unpredictable?  Perhaps sub-optimal, but I don't see what's any
> more unpreditable about it than normal SMP.
>
>> Until the scheduler work has been done,
>> it is significantly better to enable the switcher instead of SMP on these
>> platforms.
>>
>> Once the scheduler work has come further, we can switch over. But not until
>> then.
>
> I think the upstream defconfigs should facilitate the broader testing of
> the scheduler work by having the swticher disabled.

I thought the upstream defconfigs were meant to make machines work out
of the box. Any development effort can surely tweak the configs to
their needs.

> By enabling the switcher (and the corresponding cpufreq switcher driver)
> by default, we're now actually making one more obstacle for broader
> testing of the generic scheduling on all cores.

Actually, there might some advantages to turning on the switcher.
 1. The performance/power numbers of the b.L switcher is the minimum
we need to achieve on a scheduler-driven b.L system. It establishes a
baseline. Shame on us working on EAS if the switcher does better.
 2. The switcher exercises the cpufreq drivers quite a bit. So any
niggles will be ironed out on platforms where it hasn't been well
tested.

Regards,
Amit
