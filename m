From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 17 Apr 2012 23:28:24 +0200
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <1334254056.20098.YahooMailClassic@web29010.mail.ird.yahoo.com>
 (Paul Parsons's message of "Thu, 12 Apr 2012 19:07:36 +0100 (BST)")
References: <1334254056.20098.YahooMailClassic@web29010.mail.ird.yahoo.com>
Message-ID: <87lilum4jr.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Parsons <lost.distance@yahoo.com> writes:

> --- On Thu, 12/4/12, Paul Parsons <lost.distance@yahoo.com> wrote:
>> The PXA GPIO irq_chip structure
>> (pxa_muxed_gpio_chip) sets neither:
>> 1. The irq_set_wake() handler.
>> 2. The IRQCHIP_SKIP_SET_WAKE flag.

Hi Paul and others,

I tried the v3.4-rc2 today, and it _seems_ gpio button wakeups don't work
anymore (ie. wakeup set up by gpio-keys driver). More specifically, the GPIO0
(power button) doesn't wakeup my board from "echo mem > /proc/power/state".

I haven't investigated much, but tracing PWER register on suspend,
while GPIO0 (power button) was set as a wakeup source gives 0x80100000, which
lacks the bit0 setting (ie. GPIO0 as a wakeup source).

I don't know it this is a recent or known issue, or if I'm have missed a change in
pxa/gpio-keys driver.

Would anyone have an idea what's happening or should I look for the issue myself ?

Cheers.

-- 
Robert
