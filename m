From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 24 Aug 2010 18:08:58 +0800
Subject: How to define CLOCK_TICK_RATE in linux kernel 2.6.xx?
In-Reply-To: <AANLkTi=T5QP_MbUgh4EfLjtW_be49vw2eLgXNNUCiTb7@mail.gmail.com>
References: <AANLkTi=T5QP_MbUgh4EfLjtW_be49vw2eLgXNNUCiTb7@mail.gmail.com>
Message-ID: <AANLkTinbttBSuTHqFN5X75kqCkDGXvGXb-c-Yv9xdWXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 24, 2010 at 5:20 PM, David Yang <david.yangshuai@gmail.com> wrote:
> Hello all,
>
> We have recently started to port linux 2.6.33 to a arm machine which be
> cortex-a9 mpcore, and we found that need define CLOCK_TICK_RATE
> (arch/arm/mach_xxx/include/mach/timex.h) to a value.
>

It's obsoleted. Give it a fake value and go.

> Now our arm machine have two timer, first is external general timer
> which clock is 66.666666MHz, second is cortex-a9's private timer which
> clock is 400MHz or 800Hz.

The tick rate used by your OS timer is probably a good fake value.

>
> If our linux system support smp, we should how define CLOCK_TICK_RATE?
> If our linux system don't support smp, we should how define
> CLOCK_TICK_RATE?

It's basically not related to SMP.

>
> BTW, In kernel 2.6.x, CLOCK_TICK_RATE means ?
> Thank for any help

It was historically related to many things, including HZ, yet obsoleted
along with the introduction of clockevent/clocksource framework.

>
> David
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
