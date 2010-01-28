From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Jan 2010 18:34:24 +0900
Subject: IRQF_VALID
Message-ID: <aec7e5c31001280134r50b46b0ay809a125989651197@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I'm trying to understand the idea behind IRQF_VALID. Ideally I'd like
to submit a patch to remove IRQF_VALID to make it easier to share
interrupt code between architectures. Perhaps IRQF_VALID is a left
over from good old times, or maybe it has some hidden use that only
more experienced hackers are aware or. Can anyone please shed some
light?

The ARM default state for interrupts seems to be IRQ_NOREQUEST, so
mach code is required to call the ARM-specific set_irq_flags() even
though most of the interrupt handling code is fairly generic using
CONFIG_GENERIC_HARDIRQS=y. Why this special IRQF_VALID case for ARM?
