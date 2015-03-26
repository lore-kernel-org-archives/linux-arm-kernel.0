From: slash.tmp@free.fr (Mason)
Date: Thu, 26 Mar 2015 14:57:29 +0100
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD
Message-ID: <55141049.3040706@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

In http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=392348
Stephen Boyd wrote:

> I don't see any problem with the TWD dropping the dependency on SMP.
> The code should work the same on a UP configuration [...]

However, this commit seems to imply some kind of limitation:

commit 904464b91eca8c665acea033489225af02eeb75a
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Fri Feb 22 14:01:42 2013 +0100

     ARM: 7655/1: smp_twd: make twd_local_timer_of_register() no-op for nosmp
     
     When booting a SMP build kernel with nosmp on kernel cmdline, the
     following fat warning will be hit.

     ------------[ cut here ]------------
     WARNING: at arch/arm/kernel/smp_twd.c:345
     twd_local_timer_of_register+0x7c/0x90()
     twd_local_timer_of_register failed (-6)
     Modules linked in:
     Backtrace: [snip]


I would like to be able to use the TWD on a UP system (Cortex A9 MPcore
with a single core).

Is it possible to revert commit 904464b9, and drop "depends on SMP"
from the "config HAVE_ARM_TWD" definition?

Are there UP systems that simply don't have a TWD?

Regards.
