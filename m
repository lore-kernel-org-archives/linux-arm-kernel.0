From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 18 Apr 2012 20:21:58 +0200
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <1334746685.22354.YahooMailClassic@web29008.mail.ird.yahoo.com>
 (Paul Parsons's message of "Wed, 18 Apr 2012 11:58:05 +0100 (BST)")
References: <1334746685.22354.YahooMailClassic@web29008.mail.ird.yahoo.com>
Message-ID: <87bomohpdl.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Parsons <lost.distance@yahoo.com> writes:

> --- On Wed, 18/4/12, Paul Parsons <lost.distance@yahoo.com> wrote:
> Just to clarify, the generic pxa/gpio suspend/resume support does
> seem to work OK; the hx4700 patches are platform specific, apart
> from this SKIP_SET_WAKE patch to fix the Unbalanced IRQ warnings.

OK, I'll check.

My platform is mioa701. In my case, the suspend/resume is working for RTC
wakeup, but not for GPIO0. This code was working before (that's vague, I know, I
suspect 3.0 was working), and is not working anymore. The gpio_keys_button
structure has still its 'wakeup' field ...

> Consequently it seems likely that your problem is also platform
> specific.
OK. So you confirm that on hx4700, pressing PowerButton while in suspend to ram
brings back to life your device ?

Cheers.

-- 
Robert
