From: slash.tmp@free.fr (Mason)
Date: Fri, 20 Mar 2015 17:30:10 +0100
Subject: ERRATA work-arounds in the kernel
Message-ID: <550C4B12.1030608@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I was recently looking (in arch/arm/Kconfig) at the list of work-arounds
for ARM CPU Errata. I saw 18, with 8 documented as applying to Cortex A9.

I also looked at ARM's "Errata Summary Table" for the Cortex A9. There are
roughly 90 errata documented there. (This document is 2 years old.)

I assume that some (most?) of these do not apply to Linux, but it seems
likely that some do?

I'm wondering why there are not more work-arounds available in Kconfig?

Could it be that some work-arounds have been applied unconditionally, thus
not showing as an entry in Kconfig? (I doubt that, since work-arounds are
very CPU-specific.)

I'm wondering if it is possible to trigger some of these with a "normal"
work-load on a "normal" kernel? Has anyone (perhaps ARM employees) looked
at that? (I suppose they have.)

For example, errata #782772
"Speculative execution of a Load-Exclusive or Store-Exclusive instruction
after a write to Strongly Ordered memory might deadlock the processor."
(The recommended work-around is a strategically-placed DMB.)

Since ldrex is used in low-level code, it seems possible to hit that one?
Or perhaps Linux does not support "Strongly Ordered" memory regions?

Regards.
