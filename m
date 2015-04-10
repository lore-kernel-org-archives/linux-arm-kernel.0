From: slash.tmp@free.fr (Mason)
Date: Fri, 10 Apr 2015 23:22:56 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <20150410204221.GI12732@n2100.arm.linux.org.uk>
References: <5527B331.5000205@free.fr>
 <20150410114415.GC12732@n2100.arm.linux.org.uk> <5527C501.2040808@free.fr>
 <20150410150607.GG12732@n2100.arm.linux.org.uk> <5527EC90.9050900@free.fr>
 <20150410160817.GH12732@n2100.arm.linux.org.uk> <55282C1F.3000600@free.fr>
 <20150410204221.GI12732@n2100.arm.linux.org.uk>
Message-ID: <55283F30.7030109@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2015 22:42, Russell King - ARM Linux wrote:
> On Fri, Apr 10, 2015 at 10:01:35PM +0200, Mason wrote:
>> There is, however, an important difference between loop-based
>> delays and timer-based delays; CPU frequencies typically fall
>> in the 50-5000 MHz range, while timer frequencies typically
>> span tens of kHz up to hundreds of MHz. For example, 90 kHz
>> is sometimes provided in multimedia systems (MPEG TS).
> 
> Why would you want to use such a slowly clocked counter for something
> which is supposed to be able to produce delays in the micro-second and
> potentially the nanosecond range?
> 
> get_cycles(), which is what the timer based delay is based upon, is
> supposed to be a _high resolution counter_, preferably running at
> the same kind of speeds as the CPU, though with a fixed clock rate.
> It most definitely is not supposed to be in the kHz range.

If there's only a single fixed clock in the system, I'd
use it for sched_clock, clocksource, and timer delay.
Are there other options?

It was you who wrote some time ago: "Timers are preferred
because of the problems with the software delay loop."
(My system implements DVFS.)

It seems to me that a 90 kHz timer is still better than
the jiffy counter, or am I mistaken again?

Regards.
