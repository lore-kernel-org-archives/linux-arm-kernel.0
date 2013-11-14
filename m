From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Thu, 14 Nov 2013 12:53:15 +0100
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>
 <52843855.5060509@linaro.org> <52847FBE.9070501@linaro.org>
 <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
 <52848547.9080604@linaro.org>
 <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
Message-ID: <20131114115313.GC16501@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BTW, support for ARM's full dynticks is uncomplete without
"[PATCH] ARM: Support arch_irq_work_raise() via self IPIs"

...which I'm not sure is applied upstream, or even any ARM tree yet.

On Thu, Nov 14, 2013 at 05:54:10PM +0800, Shaojie Sun wrote:
> No, I think it is a bug.
> 
> Because I tested the option with NO_HZ_FULL and without
> NO_HZ_FULL_ALL. It had only little interruptes on CPU0 twd.
> With same code, I added NO_HZ_FULL_ALL option. It had too many
> interruptes on CPU0 twd.
> 
> So the sumbitter just didn't test twd interrupts, when he expanded
> NO_HZ_FULL option to all cpu.
> 
> On Thu, Nov 14, 2013 at 4:09 PM, viresh kumar <viresh.kumar@linaro.org> wrote:
> > On Thursday 14 November 2013 01:35 PM, Vincent Guittot wrote:
> >> AFAICT, It's a none issue. In full nohz, a timer fires periodically
> >> (around 4sec period on ARM IIRC) on one cpu (cpu0).
> >
> > Timer should always be running on CPU0, its out of nohz-full domain. Its
> > cpu 1, where it will fire after long delays..
> >
> >
> > https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/AdaptiveTickless
