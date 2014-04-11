From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 11 Apr 2014 11:07:35 +0200
Subject: [PATCH 1/4] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <CAOesGMg2zvPPeyqTvztiNKVJzWP5PsNs2pkXKMaS+CfXHgO0rQ@mail.gmail.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <1397072736-10793-2-git-send-email-matthias.bgg@gmail.com>
 <CAOesGMg2zvPPeyqTvztiNKVJzWP5PsNs2pkXKMaS+CfXHgO0rQ@mail.gmail.com>
Message-ID: <CABuKBeKr77qJwusoTgjR2yOspWbi6Exvt5i8WPc5tjd7fez-YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-09 23:52 GMT+02:00 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Wed, Apr 9, 2014 at 12:45 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> This patch adds a clock source and clock event for the timer found
>> on the Mediatek SoCs.
>>
>> The Mediatek General Porpose Timer block provides five 32 bit timers and
>> one 64 bit timer.
>>
>> Two 32 bit timers are used:
>> TIMER1: clock events supporting periodic and oneshot events
>> TIMER2: clock source configured as a free running counter
>>
>> The General Porpose Timer block can be run with two clocks. A 13 MHz system
>> clock and the RTC clock running at 32 KHz. This implementation uses the system
>> clock.
>
> Hm, are you planning on using these on the Cortex-A7-based and newer
> SoCs? On those, the arm generic timers should be available, and you
> might be better off just using those there.

I'm a bit puzzled about the timer naming.
Are the arm generic timers the one used by ARM_ARCH_TIMER, or are they
different ones?

>
> Of course, you'll still need these for the A9-based platforms, so the
> driver might very well be needed anyway. Some of the earlier patches
> seem to be for A7-based systems so I'm not sure what you're primarily
> working on here. :)

I'm working on a Cortex-A7 based platform. But ARM_ARCH_TIMER seems to
get no clocking.
Initializing the timer fails with:
Architected timer frequency not available

That's why I use the SoC timer.

>
>
> -Olof



-- 
motzblog.wordpress.com
