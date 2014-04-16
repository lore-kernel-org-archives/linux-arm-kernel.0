From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Apr 2014 09:45:43 -0500
Subject: [PATCH 04/12] clocksource: Sched clock source for Versatile
 Express
In-Reply-To: <1397658125.3407.84.camel@hornet>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-5-git-send-email-pawel.moll@arm.com>
 <CAL_JsqLiFE_D+PSFg62sVm3wO0uvZT+pwAVyn7Lwn2ma3+3DoA@mail.gmail.com>
 <1397658125.3407.84.camel@hornet>
Message-ID: <CAL_JsqLp5o9OnW5kk33BwdnOP97bjgfpMrR=PKEVH4nP4Tnrfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 9:22 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> Hi Rob,
>
> Thanks for reminding me about this stuff. I'll get around and re-spin
> the series this week.
>

[snip]

>> > +       setup_sched_clock(vexpress_sys_24mhz_read, 32, 24000000);
>>
>> This frequency should come from a DT clock binding. You will have to
>> fallback to 24MHz for backwards compatibility though.
>
> I don't see why would it go to the binding. You may have noticed the
> register is called "SYS_24MHZ", not "SYS_RANDOMCLOCK". The driver
> *knows* what the frequency is.

A 24MHz clock is fed to this h/w block to be used by the counter in
the block. The DT should describe that.

>
>> > +}
>>
>> Wouldn't this code work for Versatile and Realview ARM reference
>> boards? Even the register offset is the same.
>>
>> > +CLOCKSOURCE_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
>> > +               vexpress_sched_clock_init);
>
> I guess it would, yes. The sysregs are annoyingly similar and different
> at the same time.
>
> One could of course try to come up with a "generic mmio clock source"
> binding, taking the frequency as a property, but don't count on me doing
> this... ;-)

I'm not asking for that. Just take care of all ARM Ltd boards which
have the exact same 24MHz counter at offset 0x5C.

Rob
