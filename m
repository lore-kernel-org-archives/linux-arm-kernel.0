From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 16 Oct 2009 23:58:50 +0200
Subject: [PATCH v3 0/4] iop: convert to generic time
Message-ID: <19160.60570.935169.788248@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches converts the ARM kernel's XScale IOP
platform to use the kernel's generic clocksource, clockevent,
and time-keeping code. This aligns the IOP code with current
kernel practices, enables tickless kernel support, aka NOHZ,
and allows for a better sched_clock().

Runtime tested on a Thecus n2100 (iop32x). Survives heavy CPU
load (gcc recompile) and idle conditions without hickups or lost
time. Compile-tested for all plat-iop machines.

I consider this series ready for the 2.6.33 merge window and
would appreciate an ACK or NAK (with motivation).

Making tickless mode effective on the n2100 requires fixing
some n2100-specific quirks, which are handled by a follow-up
set of n2100-specific patches. With those tweaks in place my
n2100 averages about 2.5 timer interrupts per second in idle.

Main changes v2 -> v3
* rebased on the 2.6.32-rc5 kernel
* sched_clock() implementation corrected

Main changes v1 -> v2:
* rebased on the 2.6.31 kernel
* replaced guesses for clocksource and clockevent .shift values
  with runtime computations based on code in the mips kernel
* clockevent code cleanups and robustification
* tickless mode verified on the n2100
* added sched_clock() implementation

/Mikael
