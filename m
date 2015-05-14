From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 May 2015 17:24:56 +0530
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <5554858A.9010207@free.fr>
References: <55520F0F.5010906@free.fr>
 <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
 <555218C7.5050602@free.fr>
 <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr>
Message-ID: <20150514115456.GB23999@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-05-15, 13:22, Mason wrote:
> I didn't /literally/ take a stop-watch to verify it was EXACTLY
> 9 seconds, but I was staring at the prompt, and it /felt/ like
> 9 seconds. And the 54 second case felt like a minute.

:)

> I'm using a 27 MHz crystal as clocksource. This is independent
> of the CPU frequency. However, I'm using the ARM TWD as the
> system's clockevent source, and the TWD's clock is tied to
> the CPU clock (PERIPHCLK = CPUCLK / 2 on this SoC).

The only (very straight forward) problem is that we aren't propagating
the freq update to clockevents core and you need to debug a bit there.

Also I wanted to see the source of your print message:
[   19.650454] NEW RATE=9250000
[   19.653644] NEW RATE=9250000

What's this rate ? Old/new ? Because you are atleast printing the old
rate here, and the function by default gets the new rate.

> I'm wondering if there's another standard clockevent source
> I could try (it would be great if it supported high-resolution
> timers).

I hope you have some platform general-purpose-timers.

-- 
viresh
