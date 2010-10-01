From: robherring2@gmail.com (Rob Herring)
Date: Fri, 01 Oct 2010 13:47:15 -0500
Subject: [PATCH 3/3] ARM: twd_smp: add clock api support
In-Reply-To: <20101001183431.GB22533@n2100.arm.linux.org.uk>
References: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
	<1285886952-30888-3-git-send-email-robherring2@gmail.com>
	<AANLkTi=L69BXQZfT3VAeLgyBBHA2O8ELeLdqL1Onk3t=@mail.gmail.com>
	<4CA5417B.5020200@gmail.com>
	<AANLkTik=JXaDKbx97avUKerDQeK-O9gRuyfAZPHDQ2Yp@mail.gmail.com>
	<4CA551FF.3080100@gmail.com>
	<AANLkTim3wYDNySWxba3-xWkj495GTiGxWN9L08Rnaa9C@mail.gmail.com>
	<4CA614AA.8090305@gmail.com>
	<AANLkTi=zwxKhhO7ERBvWfeHF7yO4beex5CYioPtiyWpA@mail.gmail.com>
	<20101001183431.GB22533@n2100.arm.linux.org.uk>
Message-ID: <4CA62CB3.1060909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2010 01:34 PM, Russell King - ARM Linux wrote:
> On Fri, Oct 01, 2010 at 11:22:31AM -0700, Colin Cross wrote:
>> The timer APIs require that a timer take at least as long as requested
>> to fire.  If you change the TWD prescaler before the CPU frequency
>> increases, or after the CPU frequency decreases, the timer interrupt
>> will not fire until a small time after the requested time.
>
> That maybe - and for TWD which is used for local timer purposes only,
> that's fine.  What wouldn't be fine is if your clocksource counter
> changes frequency...
>
> In any case, I'm not sure that passing in a struct clk pointer is
> really the right way to go - the point of the clk API is to remove
> such passing of static structures.
>
> How about instead using clk_get_sys() to obtain a clock for the TWD?

Okay. Opinions on the name: periphclk, arm_twd, twd?
>
> Do we need separate connection IDs for each TWD, or are all TWDs in
> a system always clocked together?

A9 is 1 clock for all. Probably is likely that they will always be 
symmetric.

Rob
