From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 26 Sep 2009 21:49:30 +0200
Subject: [PATCH v2 0/4] iop: convert to generic time
Message-ID: <19134.28746.990703.158030@pilspetsen.it.uu.se>
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

Making tickless mode effective on the n2100 requires fixing
some n2100-specific quirks, which are handled by a follow-up
set of n2100-specific patches. With those tweaks in place my
n2100 averages about 3.1 timer interrupts per second in idle.

Main changes v1 -> v2:
* rebased on the 2.6.31 kernel
* replaced guesses for clocksource and clockevent .shift values
  with runtime computations based on code in the mips kernel
* clockevent code cleanups and robustification
* tickless mode verified on the n2100
* added sched_clock() implementation

/Mikael
