From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 18 Apr 2012 11:58:05 +0100 (BST)
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <1334711058.19852.YahooMailClassic@web29008.mail.ird.yahoo.com>
Message-ID: <1334746685.22354.YahooMailClassic@web29008.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Wed, 18/4/12, Paul Parsons <lost.distance@yahoo.com> wrote:
> > I tried the v3.4-rc2 today, and it _seems_ gpio button
> > wakeups don't work
> > anymore (ie. wakeup set up by gpio-keys driver). More
> > specifically, the GPIO0
> > (power button) doesn't wakeup my board from "echo mem >
> > /proc/power/state".

...

> > I don't know it this is a recent or known issue, or if I'm
> > have missed a change in
> > pxa/gpio-keys driver.
> 
> I can only comment on the hx4700 platform, which has 4
> pending
> patches for suspend/resume, plus 1 more still to be
> submitted.
> These fix hx4700 suspend/resume, which has never worked.
> None of the patches touch the gpio-keys driver, however.

Just to clarify, the generic pxa/gpio suspend/resume support does
seem to work OK; the hx4700 patches are platform specific, apart
from this SKIP_SET_WAKE patch to fix the Unbalanced IRQ warnings.

Consequently it seems likely that your problem is also platform
specific.

Regards,
Paul
