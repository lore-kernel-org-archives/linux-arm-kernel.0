From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 15 Sep 2011 17:35:45 +0900
Subject: [PATCH] arm: sched_clock: Enable HAVE_SCHED_CLOCK support without
	init_sched_clock
In-Reply-To: <20110915082024.GF6267@n2100.arm.linux.org.uk>
References: <20110915073511.GA31732@july>
	<20110915082024.GF6267@n2100.arm.linux.org.uk>
Message-ID: <CAH9JG2WeR4QtYNFoOwipFz3H6YMxvRARJvyrkj0hO3ECnYwenw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 5:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 15, 2011 at 04:35:12PM +0900, Kyungmin Park wrote:
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> On Samsung Exynos4 series, EVT0 chip uses the s5p_timer with HAVE_SCHED_CLOCK and remains use the MCT timer without init_sched_clock.
>
> So in other words, sched_clock on exynos4 is broken because the update
> function won't be called, and it'll wrap well below the 64-bit ns range
> required of it.

Right, even though MCT doesn't use the HAVE_SCHED_CLOCK, sched_clock
is override with others.
It mean it should be implement the sched_clock for all boards if there
are some boards use the HAVE_SCHED_CLOCK.

As I remember, there's attempt to solve the sched_clock registration
issue. I'll check it.

Thank you,
Kyungmin Park
>
> NAK.
>
