From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 18 Apr 2012 02:04:18 +0100 (BST)
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <87lilum4jr.fsf@free.fr>
Message-ID: <1334711058.19852.YahooMailClassic@web29008.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Robert,

--- On Tue, 17/4/12, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> >> The PXA GPIO irq_chip structure
> >> (pxa_muxed_gpio_chip) sets neither:
> >> 1. The irq_set_wake() handler.
> >> 2. The IRQCHIP_SKIP_SET_WAKE flag.
> 
> Hi Paul and others,
> 
> I tried the v3.4-rc2 today, and it _seems_ gpio button
> wakeups don't work
> anymore (ie. wakeup set up by gpio-keys driver). More
> specifically, the GPIO0
> (power button) doesn't wakeup my board from "echo mem >
> /proc/power/state".

Which board are you using?

> 
> I haven't investigated much, but tracing PWER register on
> suspend,
> while GPIO0 (power button) was set as a wakeup source gives
> 0x80100000, which
> lacks the bit0 setting (ie. GPIO0 as a wakeup source).

PWER bit 0 (WE0) has a reset value of 1 on the PXA250/PXA270.
If your WE0 is 0 then presumably either your bootloader or kernel
has cleared it.

> 
> I don't know it this is a recent or known issue, or if I'm
> have missed a change in
> pxa/gpio-keys driver.

I can only comment on the hx4700 platform, which has 4 pending
patches for suspend/resume, plus 1 more still to be submitted.
These fix hx4700 suspend/resume, which has never worked.
None of the patches touch the gpio-keys driver, however.

> 
> Would anyone have an idea what's happening or should I look
> for the issue myself ?

If you are using the hx4700 then I can point you towards the
pending patches.

Regards,
Paul
