From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Sep 2014 10:14:11 -0700
Subject: [PATCH v2] clocksource: arch_timer: Allow the device tree to
 specify the physical timer
In-Reply-To: <20140911170716.GA6158@arm.com>
References: <1410452204-7277-1-git-send-email-dianders@chromium.org>
 <20140911164710.GW6158@arm.com>
 <CAD=FV=WECbZ4L=-C+F9K6kfiPUi7ar3a4a7Upq2TqDYYPGoOrA@mail.gmail.com>
 <20140911170716.GA6158@arm.com>
Message-ID: <CAD=FV=WsSgFFNj_2P0Ufi-WDYxywf8OrDh10y44XRLuNYOnyGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Thu, Sep 11, 2014 at 10:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Sep 11, 2014 at 05:59:53PM +0100, Doug Anderson wrote:
>> On Thu, Sep 11, 2014 at 9:47 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > I'd say `Only supported for ARM' to better match what we've done. Probably
>> > also worth mentioning that this relies on the hypervisor/firmware having set
>> > CNTHCTL.PL1PCEN and CNTHCTL.EL1PCTEN (but assumedly made a mess of CNTVOFF
>> > ;) if you want to boot on the non-secure side (e.g. as a guest).
>>
>> Note that the reset value of CNTHCTL.PL1PCEN and CNTHCTL.PL1PCTEN are
>> both 1 in my version of the ARM ARM.  On the other hand CNTVOFF is
>> documented to have an UNKNOWN reset value.  If only ARM had guaranteed
>> that CNTVOFF started out as 0 (which seems like it would have been
>> sensible) we wouldn't be in this mess.  :-/
>
> I'm afraid we went the opposite way -- in ARMv8 there are a tiny handful
> of EL3 registers that are well-defined out of reset, then the rest of the
> system is UNKNOWN. The hardware guys prefer that and it can also be useful
> for very low-level debugging (system crashes, do a reset, read out the
> state).

Well, I guess if that's the way it is then software will have to deal
with it.  It sure seems like having things default to some state (even
if it's zero) at reset is really nice.  Otherwise you get things where
one 1 of every 10 times you boot the system it behaves differently and
that's hard to track down.  ...of course, then it maybe forces you to
think about really initting all bits in software and that's not
terrible.


-Doug
