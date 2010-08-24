From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Aug 2010 15:21:23 +0200
Subject: How to define CLOCK_TICK_RATE in linux kernel 2.6.xx?
In-Reply-To: <AANLkTinbttBSuTHqFN5X75kqCkDGXvGXb-c-Yv9xdWXw@mail.gmail.com>
References: <AANLkTi=T5QP_MbUgh4EfLjtW_be49vw2eLgXNNUCiTb7@mail.gmail.com>
	<AANLkTinbttBSuTHqFN5X75kqCkDGXvGXb-c-Yv9xdWXw@mail.gmail.com>
Message-ID: <201008241521.23459.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 August 2010, Eric Miao wrote:
> On Tue, Aug 24, 2010 at 5:20 PM, David Yang <david.yangshuai@gmail.com> wrote:
> > Hello all,
> >
> > We have recently started to port linux 2.6.33 to a arm machine which be
> > cortex-a9 mpcore, and we found that need define CLOCK_TICK_RATE
> > (arch/arm/mach_xxx/include/mach/timex.h) to a value.
> >
> 
> It's obsoleted. Give it a fake value and go.

I would call it *almost* obsolete. Platforms that don't have their
own clocksource implementation still use it for calculating the
exact value of their time slices, and the console beep in the TTY layer
defines its pitch through this frequency.

The latter is of course a bug, it should use 1193182 Hz, independent
of CLOCK_TICK_RATE, since the frequency is now unfortunately part
of the ABI.

	Arnd
