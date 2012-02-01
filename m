From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2012 21:17:12 +0100
Subject: cpu_relax in busy loops question
In-Reply-To: <4F292345.8070800@linaro.org>
References: <4F292345.8070800@linaro.org>
Message-ID: <CACRpkdZfdx9tDgp8HfVSdEFXdvpsPDiWdpg2iyFYesgpBjsqyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2012 at 12:34 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Linus,
>
> While looking at the drivers/mfd/db8500-prcmu.c file I noticed:
>
>
> ?595 ? ? ? ? /* Grab the HW semaphore. */
> ?596 ? ? ? ? while ((readl(PRCM_SEM) & PRCM_SEM_PRCM_SEM) != 0)
> ?597 ? ? ? ? ? ? ? ? cpu_relax();
>
>
> I was wondering why is cpu_relax needed here as readl does a memory barrier
> ? I thought the cpu_relax function was related to the x86 to consume less
> power with an optimization of the "rep nop" loops or/and do a memory
> barrier.
>
> Should a busy-loop be always with cpu_relax ?

Last time we discussed it ar LAKML I think we came to the conclusion
that while cpu_relax() has very little semantic meaning on ARM, it
is still nice to have from a readability and maintenance point of view,
since it is pretty clear what we're trying to do.

But I will stand corrected...

Yours,
Linus Walleij
