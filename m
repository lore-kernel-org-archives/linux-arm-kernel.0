From: attila@kinali.ch (Attila Kinali)
Date: Wed, 4 Jul 2012 09:38:23 +0200
Subject: MX28 poweroff issue
In-Reply-To: <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
References: <201207040030.36713.marex@denx.de>
 <CAOMZO5AEG5g9EYP558UWtX2m-HicAng=h008raN8wA0Yqy-xdA@mail.gmail.com>
 <201207040412.46748.marex@denx.de>
 <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
Message-ID: <20120704093823.8e74d48bc8d9918a9c80fbcf@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jul 2012 00:14:12 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Tue, Jul 3, 2012 at 11:12 PM, Marek Vasut <marex@denx.de> wrote:
> 
> > Dunno, can you try on mx28 please?
> 
> I get the same crash as you reported.
> 
> On a mx27 (also ARM926EJS) I do not see this problem.

I have the same issue on the mx23 (using 3.5-rc5):

Requesting system halt
[  139.330000] System halted.
[  164.080000] BUG: soft lockup - CPU#0 stuck for 22s! [init:61]
[  164.080000] Modules linked in:
[  164.080000] irq event stamp: 24804
[  164.080000] hardirqs last  enabled at (24803): [<c000ee58>] __irq_svc+0x58/0x60
[  164.080000] hardirqs last disabled at (24804): [<c000ee34>] __irq_svc+0x34/0x60
[  164.080000] softirqs last  enabled at (24802): [<c00244e4>] irq_exit+0x8c/0x94
[  164.080000] softirqs last disabled at (24795): [<c00244e4>] irq_exit+0x8c/0x94
[  164.080000] 
[  164.080000] Pid: 61, comm:                 init
[  164.080000] CPU: 0    Not tainted  (3.5.0-rc5-svn13642 #15)
[  164.080000] PC is at machine_halt+0x0/0x4
[  164.080000] LR is at sys_reboot+0x180/0x1dc
[  164.080000] pc : [<c00101ec>]    lr : [<c0032ed4>]    psr: 60000013
[  164.080000] sp : c39a9e90  ip : c39f0880  fp : 00000000
[  164.080000] r10: 00000000  r9 : c39a8000  r8 : c043eddc
[  164.080000] r7 : 00000008  r6 : 4321fedc  r5 : cdef0123  r4 : c39a8000
[  164.080000] r3 : 00000000  r2 : 00000000  r1 : c39f0b68  r0 : 00000005
[  164.080000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  164.080000] Control: 0005317f  Table: 43984000  DAC: 00000015
[  164.080000] [<c0014990>] (unwind_backtrace+0x0/0xf4) from [<c00686a0>] (watchdog_timer_fn+0x130/0x16c)
[  164.080000] [<c00686a0>] (watchdog_timer_fn+0x130/0x16c) from [<c00400f8>] (__run_hrtimer+0x7c/0x1e4)
[  164.080000] [<c00400f8>] (__run_hrtimer+0x7c/0x1e4) from [<c00404d4>] (hrtimer_interrupt+0x108/0x2e4)
[  164.080000] [<c00404d4>] (hrtimer_interrupt+0x108/0x2e4) from [<c0018f4c>] (mxs_timer_interrupt+0x1c/0x28)
[  164.080000] [<c0018f4c>] (mxs_timer_interrupt+0x1c/0x28) from [<c0068dd8>] (handle_irq_event_percpu+0x5c/0x274)
[  164.080000] [<c0068dd8>] (handle_irq_event_percpu+0x5c/0x274) from [<c006902c>] (handle_irq_event+0x3c/0x5c)
[  164.080000] [<c006902c>] (handle_irq_event+0x3c/0x5c) from [<c006b5dc>] (handle_level_irq+0x8c/0x118)
[  164.080000] [<c006b5dc>] (handle_level_irq+0x8c/0x118) from [<c00689a4>] (generic_handle_irq+0x34/0x40)
[  164.080000] [<c00689a4>] (generic_handle_irq+0x34/0x40) from [<c00100dc>] (handle_IRQ+0x30/0x84)
[  164.080000] [<c00100dc>] (handle_IRQ+0x30/0x84) from [<c000ee38>] (__irq_svc+0x38/0x60)
[  164.080000] [<c000ee38>] (__irq_svc+0x38/0x60) from [<c00101ec>] (machine_halt+0x0/0x4)
[  164.080000] [<c00101ec>] (machine_halt+0x0/0x4) from [<c0032ed4>] (sys_reboot+0x180/0x1dc)
[  164.080000] [<c0032ed4>] (sys_reboot+0x180/0x1dc) from [<c000f1e0>] (ret_fast_syscall+0x0/0x38)

			Attila Kinali

-- 
It is upon moral qualities that a society is ultimately founded. All 
the prosperity and technological sophistication in the world is of no 
use without that foundation.
                 -- Miss Matheson, The Diamond Age, Neil Stephenson
