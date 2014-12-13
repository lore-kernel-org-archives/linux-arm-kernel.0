From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 13 Dec 2014 13:26:47 +0100
Subject: [PATCH] ARM: dove: fix legacy dove IRQ numbers for 3.18
In-Reply-To: <E1XyOJv-0003kd-2y@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Tue, 09 Dec 2014 17:11:31 +0000")
References: <E1XyOJv-0003kd-2y@rmk-PC.arm.linux.org.uk>
Message-ID: <87sigjag6w.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> v3.18 changed handle_IRQ() to call __handle_domain_irq(), which now
> rejects attempts to deliver IRQ0.  Since IRQ 0 is used as the timer
> interrupt (just like the PIT on x86), this causes boot to fail as the
> bogomips calibration never completes.
>
> Fix this by shuffling all interrupts up by one.
Hi Russell,

I was curious why shift by "one".
Why not shift by for example NR_IRQS_LEGACY ?

And even if you judge 1 is the right number, wouldn't it be better to define a
constant "IRQ_OFS" and have each define be "#define IRQ_xxxx (IRQ_OFS + <n>) ?

Cheers.

--
Robert
