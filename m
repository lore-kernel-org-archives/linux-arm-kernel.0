From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 11 Jun 2015 19:46:27 +0800
Subject: [PATCH 1/2 V3] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <20150610213345.GF29640@codeaurora.org>
References: <1431675587-8637-1-git-send-email-21cnbao@gmail.com>
 <20150515183029.GL31753@codeaurora.org>
 <CAGsJ_4zwNQvvSwb49nwKzfke1V1nUCW-tDqbP4FxEr0SfmX9zA@mail.gmail.com>
 <20150521213324.GA1885@codeaurora.org>
 <CAGsJ_4xUk1kDnLDrRnipN+Kpm6oOe8C-4DfhdshVUmv+PKjgig@mail.gmail.com>
 <20150610213345.GF29640@codeaurora.org>
Message-ID: <CAGsJ_4x-OK0oNxd6em=sH308Oz8zR1mvMwh2mg=jzK6nhi-0_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-11 5:33 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 06/11, Barry Song wrote:
>> 2015-05-22 5:33 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
>> > On 05/16, Barry Song wrote:
>> >> 2015-05-16 2:30 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
>> >> > On 05/15, Barry Song wrote:
>> >
>> > It isn't really about making boot time faster, it's about using
>> > the proper linux device model for clock providers. That way when
>> > we want to support things like suspend/resume, deferred probe,
>> > devm_*(), sysfs, etc. we can use the device model instead of
>> > resorting to things like syscore_ops for suspend/resume or
>> > forgoing features entirely.
>> >
>>
>> my feeling is if the clock controller is an internal controller which
>> serve all controllers in the SoC, "deferred probe" might be yes for
>> almost all HW since all HW need clock. so it seems it makes "deferred
>> probe" has no meaning. clock controller seems to be 1st HW which needs
>> to be ready.
>
> That sounds like a probe ordering problem, and I agree most
> likely the clock driver will need to probe first in this case. It
> doesn't do anything about other problems like suspend/resume or
> other features that the device model provides solutions for
> though. Maybe we don't use these features, but it doesn't mean we
> should forgo the device model just because we don't need it.

this is generally done by a earlier init like subsys_init, core_init
etc. i agree it is always good to use the bus/driver/device model if
possible.
actually, moving to platform bus still has some deferred probe issue.
it is probably everyone before clk driver need deferred probe.
do you think we are possible to ask for clk even before platform
devices are extended in machine callbacks?


>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
-barry
