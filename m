From: johnstul@us.ibm.com (john stultz)
Date: Fri, 5 Mar 2010 13:29:42 -0800
Subject: Different definition in div_sc and clocksource_cyc2ns
In-Reply-To: <10d816431003051314i3e87a2d2yab344826d14a310a@mail.gmail.com>
References: <10d816431003051314i3e87a2d2yab344826d14a310a@mail.gmail.com>
Message-ID: <1f1b08da1003051329ta5b905dq69eef81aedd4f463@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 5, 2010 at 1:14 PM, Lin Mac <mkl0301@gmail.com> wrote:
> While working with the clocksource, I found that the relation of cycle
> and nanosecond of div_sc and clocksource_cyc2ns is different.
>
> linux-2.6.33
> div_sc in include/linux/clockchips.h suggests that clock_ticks =
> (nanoseconds * factor) >> shift.

> However, clocksource_cyc2ns in include/linux/clocksource.h suggest
> nanoseconds=(cycles*mult)>>shift.

You're comparing similar helper conversion functions from two
different subsystems.

Both use similar shifted math, but the div_sc() is for clockchips.h,
which is used by the clockevents code to trigger interrupts at a
specified time, while clocksource_cyc2ns() is for the clocksource
code, which converts  clockosurce cycles into nanoseconds for
timekeeping.


thanks
-john
