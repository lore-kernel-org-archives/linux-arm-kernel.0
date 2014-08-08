From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 8 Aug 2014 11:44:37 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <alpine.LFD.2.11.1408081418390.6061@knanqh.ubzr>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <53DB6B4F.9080605@arm.com> <1406890899.2794.40.camel@linaro1.home>
 <CAOesGMi0RUbz4BSnmR92dEk3fWgN=hnENSdi55VeCXdcHLRLJQ@mail.gmail.com>
 <53DB763A.10306@arm.com> <1406892491.2794.58.camel@linaro1.home>
 <53DBAAEA.2010908@arm.com> <1406908399.22757.12.camel@linaro1.home>
 <20140803032047.GB14214@quad.lixom.net> <7h4mxm3l5k.fsf@paris.lan>
 <alpine.LFD.2.11.1408081418390.6061@knanqh.ubzr>
Message-ID: <CAGa+x84eqL5=+bamXWrxcATubAEpWsAKO9C7qZF6EY2KwW9vJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 8, 2014 at 11:26 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 8 Aug 2014, Kevin Hilman wrote:

[...]

>> I think the upstream defconfigs should facilitate the broader testing of
>> the scheduler work by having the swticher disabled.
>>
>> By enabling the switcher (and the corresponding cpufreq switcher driver)
>> by default, we're now actually making one more obstacle for broader
>> testing of the generic scheduling on all cores.
>
> The generic scheduler currently has nothing really worth testing by the
> wider  audience.  Be assured that when it does then the switcher will
> indeed default to off.

I guess my vacation successfully purged my memory.  I was thinking the
switcher was only a complie-time option, but just realized that it can
be disabled at runtime (via /sys/kernel/bL_switcher/active.)

With the runtime enable/disable feature of the switcher, I don't have
any more (reasonable) objections to it being enabled by default.

Kevin
