From: linux@bohmer.net (Remy Bohmer)
Date: Mon, 1 Aug 2011 22:00:00 +0200
Subject: [PATCH] Add sched_clock to AT91 TCB clocksource driver
In-Reply-To: <20110801194809.GE19079@n2100.arm.linux.org.uk>
References: <1312124593-6088-1-git-send-email-linux@bohmer.net>
	<20110731150707.GA2975@n2100.arm.linux.org.uk>
	<CANqCtQJwUsLXfA408GzAr0rQtc2DRjtKqP8-m2UBUGEy-YP5dg@mail.gmail.com>
	<20110801092806.GD15578@n2100.arm.linux.org.uk>
	<CANqCtQK=H_B04A7knZSiuE5RLogTgMKxwtMK1HSqSgKA_U2J7A@mail.gmail.com>
	<20110801194809.GE19079@n2100.arm.linux.org.uk>
Message-ID: <CANqCtQLuvFSsL3N3HdxdhnmO=2g4qsUTPX5rym1FUH1Lo8-ofA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> But late_time_init does it before the sched_clock is declared stable.
>> Until that point sched_clock will always return zero, as such we can
>> IMHO safely assume that the scheduler is designed such that it can
>> handle fixed zero timestamps for a while.
>
> You're confused.
>
> If you provide your own sched_clock(), that's what is used by everyone
> who calls sched_clock() both before and after sched_clock_init() has
> been called.
>
> sched_clock_cpu() and cpu_clock() both will return zero up until
> sched_clock_init() has been called, but sched_clock() itself may not.
>
> And these parts of the scheduler I'm talking about use sched_clock()
> itself, not sched_clock_cpu() nor cpu_clock().

Yep. You are right. I was confused... Sorry.

Kind regards,

Remy
