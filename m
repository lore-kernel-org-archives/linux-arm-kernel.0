From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 8 May 2011 22:34:30 +0200
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource based
	sched_clock
In-Reply-To: <alpine.LFD.2.02.1104292355210.3005@ionos>
References: <20110423205036.795894921@linutronix.de>
	<20110429094606.GA5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291217120.3005@ionos>
	<20110429103208.GA2849@atomide.com>
	<alpine.LFD.2.02.1104291900290.3005@ionos>
	<BANLkTi=Xymqw9H+aNPbYUWDs7w5HzmJVkw@mail.gmail.com>
	<alpine.LFD.2.02.1104292355210.3005@ionos>
Message-ID: <BANLkTimgJbxuqcRXxvPs0HjP_AbdD81O_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 11:57 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 29 Apr 2011, Linus Walleij wrote:
>>
>> Jonas ?berg has this pending patch that we call "boot time recorder".
>> What it does is basically start a free running timer before the
>> kernel is booted, e.g. in U-boot or even in the ROM of your
>> machine if you can.
>>
>> If we need more finegrained sched_clock() before the
>> clocksource is up, a good approach would be to utilize
>> something like that for sched_clock up to that point, plus
>> it has the upside that [0.000000] is as close to electrical
>> power-on as possible.
>
> Well, you can read out that value at the point the clocksource gets
> installed so you have the time spent up to that point without adding
> another facility, level of indirection ...

That too (one does not exclude the other), what I was getting at is that
systems may have something alredy running that is monotonic and
trustable, and would likely go into some early_timer() or similar familiar
kernel naming scheme. But no point in doing any of that sort now, let's
have jiffies for now and get that to work.

Thanks,
Linus Walleij
