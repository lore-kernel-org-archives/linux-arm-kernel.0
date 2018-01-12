From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Jan 2018 10:23:46 -0800
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <CAK8P3a2SO4=YKBE3L_AKsyfNe77YR7a8F=dvbS=ic03=6NK8MA@mail.gmail.com>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <20180112020711.6gp2pnsxxjzelidq@localhost> <20180112032223.GK3626@vireshk-i7>
 <CAOesGMggU73asY1SEUDD_BsWcrGYR___o8e5omjziOPEwJgqBQ@mail.gmail.com>
 <CAK8P3a2SO4=YKBE3L_AKsyfNe77YR7a8F=dvbS=ic03=6NK8MA@mail.gmail.com>
Message-ID: <CAOesGMgcf9FovbzhPkKnrG4ETRFP3dsSJnTYNfp1wECMFeFOGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 12:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jan 12, 2018 at 4:23 AM, Olof Johansson <olof@lixom.net> wrote:
>> On Thu, Jan 11, 2018 at 7:22 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On 11-01-18, 18:07, Olof Johansson wrote:
>>>> On Thu, Jan 11, 2018 at 11:28:51AM +0530, Viresh Kumar wrote:
>>>> > The interrupt-parent of rtc was missing, add it.
>>>> >
>>>> > Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
>>>> > Cc: stable at vger.kernel.org # v3.8+
>>>> > Reported-by: Arnd Bergmann <arnd@arndb.de>
>>>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>
>>>> Applied to next/dt. Is stable really needed on this? It's been broken since
>>>> pretty much forever, and nobody has complained... :)
>>>
>>> Not sure. Just thought it may be useful for someone somewhere :)
>>
>> Ok. Left the tags there, but didn't merge into fixes since we're late
>> in -rc and this didn't seem critical at this time.
>
> My plan was to have these in the fixes branch in the hope of making
> it to a clean build for 4.15 after all, they fix warnings that got introduced
> by the updated dtc checks in 4.15-rc1.
>
> We are getting fairly close, but it seems we still miss a few, so we
> might as well give up at this point. The remaining fixes should be easy
> to backport into v4.15.y if we decide to do it, of further back even.
> For v4.14 and before, the in-kernel copy of dtc won't warn, but mainline
> dtc will.
>
> Greg, let me know your thoughts on this for the upcoming 4.15.y
> release. We had hundreds of dtc warnings in 4.15-rc1, many of them
> about important bugs, now we're down to a couple of warnings
> for platforms we don't care about much, and I expect the last of
> these fixes to land in 4.16-rc1 or maybe -rc2. Shall we backport
> them all to get a clean 4.15.y release?

I think it makes more sense to disable the warnings than to backport a
bunch of warning fixes this late. The code is working, has worked for
a long time it's just that Rob enabled the warnings by default. We can
keep them enabled for 4.16.

Rob?

> Note: there was at least one dtc warning fix that caused a serious
> regression in code that relied on a device probe to fail because of
> an invalid node (a fix is still in the works for 4.15), though generally
> the fixes are really harmless and can only make things better.

Exactly why picking up warning fixes this late is probably not a great idea.

-Olof
