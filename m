From: harishpresent@gmail.com (Harishkumar V)
Date: Tue, 29 Jun 2010 11:51:34 +0530
Subject: soft lockup - CPU#0 stuck for 61s! problem
In-Reply-To: <20100628102931.GA30050@n2100.arm.linux.org.uk>
References: <AANLkTimqNv37LkJDyKJp9PnJapXH4naINhx-T2ysQi4D@mail.gmail.com>
	<20100628090036.GA28510@n2100.arm.linux.org.uk>
	<AANLkTin_iY-7nUwtf1q7Fz4qdnkA0BUktEC6WwCiQdOX@mail.gmail.com>
	<20100628102931.GA30050@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin-cXOIkMN9JXdPETP_aEjeCjF9qV2hIytc5xjU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I am attaching the captured log of cpu lockup with the full trace of
information.

Thanks and Regards,
HarishKumar.V

On Mon, Jun 28, 2010 at 3:59 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Mon, Jun 28, 2010 at 03:50:24PM +0530, Harishkumar V wrote:
> > Will capture the further messages and mail u. Why an IRQ got struck, is
> > their a way to handle this....
>
> Normally, the kernel will disable the interrupt so the system can
> continue to (mostly) function.
>
> However, people like to return IRQ_HANDLED from interrupt handlers,
> even when they've found nothing to do.  This prevents the kernel from
> rescuing you from the stuck-IRQ problem.  Interrupt handlers are
> supposed to return IRQ_HANDLED if they did something to handle the IRQ,
> or IRQ_NONE if they found nothing to do.
>
> I can't say much more than that - I've no idea what hardware you're
> running the kernel on, and therefore I can't guess what IRQ92 might be.
>



-- 
Thanks and Regards,
Harish Kumar. V
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100629/4927c315/attachment-0001.html>
-------------- next part --------------
<3>BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
Modules linked in:Modules linked in: cir_lin cir_lin



Pid: 723, comm:               Xfbdev
Pid: 723, comm:               Xfbdev
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
PC is at handle_IRQ_event+0x28/0x74
PC is at handle_IRQ_event+0x28/0x74
LR is at handle_level_irq+0x94/0xec
LR is at handle_level_irq+0x94/0xec
pc : [<c008fd30>]    lr : [<c009133c>]    psr: 40000113
sp : c7a7dd50  ip : c7a7dd70  fp : c7a7dd6c
pc : [<c008fd30>]    lr : [<c009133c>]    psr: 40000113
sp : c7a7dd50  ip : c7a7dd70  fp : c7a7dd6c
r10: 0000001d  r9 : c0659080  r8 : 00000000
r10: 0000001d  r9 : c0659080  r8 : 00000000
r7 : 0000003e  r6 : 00000000  r5 : 0000003e  r4 : c7b82de0
r7 : 0000003e  r6 : 00000000  r5 : 0000003e  r4 : c7b82de0
r3 : 00000000  r2 : 00000050  r1 : c7b82de0  r0 : 0000003e
r3 : 00000000  r2 : 00000050  r1 : c7b82de0  r0 : 0000003e
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
[<c003c370>] [<c003c370>] (show_regs+0x0/0x50) (show_regs+0x0/0x50) from [<c008f838>] from [<c008f838>] (softlockup_tick+0x108/0x148)
(softlockup_tick+0x108/0x148)
 r5:00000a72 r5:00000a72 r4:00000a35 r4:00000a35

[<c008f730>] [<c008f730>] (softlockup_tick+0x0/0x148) (softlockup_tick+0x0/0x148) from [<c0071c78>] from [<c0071c78>] (run_local_timers+0x1c/0x20)
(run_local_timers+0x1c/0x20)
 r8:c0658198 r8:c0658198 r7:00000b27 r7:00000b27 r6:077878a1 r6:077878a1 r5:c7818040 r5:c7818040 r4:00000000 r4:00000000

[<c0071c5c>] [<c0071c5c>] (run_local_timers+0x0/0x20) (run_local_timers+0x0/0x20) from [<c0071cf8>] from [<c0071cf8>] (update_process_times+0x30/0x60)
(update_process_times+0x30/0x60)
[<c0071cc8>] [<c0071cc8>] (update_process_times+0x0/0x60) (update_process_times+0x0/0x60) from [<c0084e78>] from [<c0084e78>] (tick_sched_timer+0x90/0xc4)
(tick_sched_timer+0x90/0xc4)
 r5:c7a7dd08 r5:c7a7dd08 r4:c069a488 r4:c069a488

[<c0084de8>] [<c0084de8>] (tick_sched_timer+0x0/0xc4) (tick_sched_timer+0x0/0xc4) from [<c007f0cc>] from [<c007f0cc>] (__run_hrtimer+0x58/0xa0)
(__run_hrtimer+0x58/0xa0)
 r7:7fffffff r7:7fffffff r6:ffffffff r6:ffffffff r5:c0658198 r5:c0658198 r4:c069a488 r4:c069a488

[<c007f074>] [<c007f074>] (__run_hrtimer+0x0/0xa0) (__run_hrtimer+0x0/0xa0) from [<c007fd88>] from [<c007fd88>] (hrtimer_interrupt+0x174/0x1ec)
(hrtimer_interrupt+0x174/0x1ec)
 r5:00000b27 r5:00000b27 r4:c069a488 r4:c069a488

[<c007fc14>] [<c007fc14>] (hrtimer_interrupt+0x0/0x1ec) (hrtimer_interrupt+0x0/0x1ec) from [<c00452c4>] from [<c00452c4>] (omap2_gp_timer_interrupt+0x28/0x34)
(omap2_gp_timer_interrupt+0x28/0x34)
[<c004529c>] [<c004529c>] (omap2_gp_timer_interrupt+0x0/0x34) (omap2_gp_timer_interrupt+0x0/0x34) from [<c008fd44>] from [<c008fd44>] (handle_IRQ_event+0x3c/0x74)
(handle_IRQ_event+0x3c/0x74)
[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:0000003e r7:0000003e r6:00000000 r6:00000000 r5:0000005f r5:0000005f r4:c0659ff8 r4:c0659ff8

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dda0 r5:c7a7dda0 r4:0000005f r4:0000005f

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dd08 to 0xc7a7dd50)
Exception stack(0xc7a7dd08 to 0xc7a7dd50)
dd00: dd00:                                     0000003e 0000003e c7b82de0 c7b82de0 00000050 00000050 00000000 00000000 c7b82de0 c7b82de0 0000003e 0000003e 

dd20: dd20: 00000000 00000000 0000003e 0000003e 00000000 00000000 c0659080 c0659080 0000001d 0000001d c7a7dd6c c7a7dd6c c7a7dd70 c7a7dd70 c7a7dd50 c7a7dd50 

dd40: dd40: c009133c c009133c c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:000000b9 r7:000000b9 r6:00000000 r6:00000000 r5:0000003e r5:0000003e r4:c065983c r4:c065983c

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7de70 r5:c7a7de70 r4:0000003e r4:0000003e

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
dda0: dda0: 000000b9 000000b9 c7a8a910 c7a8a910 000000cb 000000cb 00000088 00000088 c7a8a910 c7a8a910 000000b9 000000b9 00000000 00000000 000000b9 000000b9 

ddc0: ddc0: 00000000 00000000 c0659080 c0659080 0000001d 0000001d c7a7de04 c7a7de04 c7a7de08 c7a7de08 c7a7dde8 c7a7dde8 c009133c c009133c c008fd30 c008fd30 

dde0: dde0: 40000113 40000113 ffffffff ffffffff                                                                                                             

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000001 r7:00000001 r6:c06553bc r6:c06553bc r5:000000b9 r5:000000b9 r4:c065b510 r4:c065b510

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c004c3d0>] from [<c004c3d0>] (gpio_irq_handler+0x12c/0x16c)
(gpio_irq_handler+0x12c/0x16c)
 r5:000000b9 r5:000000b9 r4:c065b514 r4:c065b514

[<c004c2a4>] [<c004c2a4>] (gpio_irq_handler+0x0/0x16c) (gpio_irq_handler+0x0/0x16c) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
de60: de60:                                                                         0000005c 0000005c c79304b0 c79304b0 0000006e 0000006e 00000000 00000000 

de80: de80: c79304b0 c79304b0 0000005c 0000005c 00000000 00000000 0000005c 0000005c 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7ded4 c7a7ded4 

dea0: dea0: c7a7ded8 c7a7ded8 c7a7deb8 c7a7deb8 c009133c c009133c c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000108 r7:00000108 r6:c7a7c000 r6:c7a7c000 r5:0000005c r5:0000005c r4:c0659f44 r4:c0659f44

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dfb0 r5:c7a7dfb0 r4:0000005c r4:0000005c

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7df08 to 0xc7a7df50)
Exception stack(0xc7a7df08 to 0xc7a7df50)
df00: df00:                                     40000000 40000000 c064e368 c064e368 00000000 00000000 c0698da0 c0698da0 0000003e 0000003e 00000000 00000000 

df20: df20: c7a7c000 c7a7c000 00000108 00000108 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7df7c c7a7df7c c7a7df80 c7a7df80 c7a7df50 c7a7df50 

df40: df40: c006dc00 c006dc00 c006db0c c006db0c 20000113 20000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c006dac4>] [<c006dac4>] (__do_softirq+0x0/0xf4) (__do_softirq+0x0/0xf4) from [<c006dc00>] from [<c006dc00>] (irq_exit+0x48/0x8c)
(irq_exit+0x48/0x8c)
[<c006dbb8>] [<c006dbb8>] (irq_exit+0x0/0x8c) (irq_exit+0x0/0x8c) from [<c003a06c>] from [<c003a06c>] (__exception_text_start+0x6c/0x88)
(__exception_text_start+0x6c/0x88)
 r5:00000000 r5:00000000 r4:0000003e r4:0000003e

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003abf8>] from [<c003abf8>] (__irq_usr+0x38/0x80)
(__irq_usr+0x38/0x80)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
dfa0: dfa0:                                                                         00000001 00000001 bee54608 bee54608 00000001 00000001 00000000 00000000 

dfc0: dfc0: 00000000 00000000 0000000c 0000000c 00000160 00000160 00000108 00000108 00000000 00000000 00000000 00000000 00000002 00000002 bee54644 bee54644 

dfe0: dfe0: 00000018 00000018 bee545d0 bee545d0 00166440 00166440 00166680 00166680 60000010 60000010 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

<3>BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
Modules linked in:Modules linked in: cir_lin cir_lin



Pid: 723, comm:               Xfbdev
Pid: 723, comm:               Xfbdev
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
PC is at handle_IRQ_event+0x28/0x74
PC is at handle_IRQ_event+0x28/0x74
LR is at handle_edge_irq+0x108/0x14c
LR is at handle_edge_irq+0x108/0x14c
pc : [<c008fd30>]    lr : [<c0091190>]    psr: 40000113
sp : c7a7dd10  ip : c7a7dd30  fp : c7a7dd2c
pc : [<c008fd30>]    lr : [<c0091190>]    psr: 40000113
sp : c7a7dd10  ip : c7a7dd30  fp : c7a7dd2c
r10: 00000021  r9 : c0659170  r8 : 00000001
r10: 00000021  r9 : c0659170  r8 : 00000001
r7 : 00000124  r6 : 00000000  r5 : 00000124  r4 : c7a3cef8
r7 : 00000124  r6 : 00000000  r5 : 00000124  r4 : c7a3cef8
r3 : 00000001  r2 : d9056000  r1 : c7a3cef8  r0 : 00000124
r3 : 00000001  r2 : d9056000  r1 : c7a3cef8  r0 : 00000124
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
[<c003c370>] [<c003c370>] (show_regs+0x0/0x50) (show_regs+0x0/0x50) from [<c008f838>] from [<c008f838>] (softlockup_tick+0x108/0x148)
(softlockup_tick+0x108/0x148)
 r5:00000aaf r5:00000aaf r4:00000a72 r4:00000a72

[<c008f730>] [<c008f730>] (softlockup_tick+0x0/0x148) (softlockup_tick+0x0/0x148) from [<c0071c78>] from [<c0071c78>] (run_local_timers+0x1c/0x20)
(run_local_timers+0x1c/0x20)
 r8:c0658198 r8:c0658198 r7:00000b68 r7:00000b68 r6:2545666c r6:2545666c r5:c7818040 r5:c7818040 r4:00000000 r4:00000000

[<c0071c5c>] [<c0071c5c>] (run_local_timers+0x0/0x20) (run_local_timers+0x0/0x20) from [<c0071cf8>] from [<c0071cf8>] (update_process_times+0x30/0x60)
(update_process_times+0x30/0x60)
[<c0071cc8>] [<c0071cc8>] (update_process_times+0x0/0x60) (update_process_times+0x0/0x60) from [<c0084e78>] from [<c0084e78>] (tick_sched_timer+0x90/0xc4)
(tick_sched_timer+0x90/0xc4)
 r5:c7a7dcc8 r5:c7a7dcc8 r4:c069a488 r4:c069a488

[<c0084de8>] [<c0084de8>] (tick_sched_timer+0x0/0xc4) (tick_sched_timer+0x0/0xc4) from [<c007f0cc>] from [<c007f0cc>] (__run_hrtimer+0x58/0xa0)
(__run_hrtimer+0x58/0xa0)
 r7:7fffffff r7:7fffffff r6:ffffffff r6:ffffffff r5:c0658198 r5:c0658198 r4:c069a488 r4:c069a488

[<c007f074>] [<c007f074>] (__run_hrtimer+0x0/0xa0) (__run_hrtimer+0x0/0xa0) from [<c007fd88>] from [<c007fd88>] (hrtimer_interrupt+0x174/0x1ec)
(hrtimer_interrupt+0x174/0x1ec)
 r5:00000b68 r5:00000b68 r4:c069a488 r4:c069a488

[<c007fc14>] [<c007fc14>] (hrtimer_interrupt+0x0/0x1ec) (hrtimer_interrupt+0x0/0x1ec) from [<c00452c4>] from [<c00452c4>] (omap2_gp_timer_interrupt+0x28/0x34)
(omap2_gp_timer_interrupt+0x28/0x34)
[<c004529c>] [<c004529c>] (omap2_gp_timer_interrupt+0x0/0x34) (omap2_gp_timer_interrupt+0x0/0x34) from [<c008fd44>] from [<c008fd44>] (handle_IRQ_event+0x3c/0x74)
(handle_IRQ_event+0x3c/0x74)
[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000124 r7:00000124 r6:00000000 r6:00000000 r5:0000005f r5:0000005f r4:c0659ff8 r4:c0659ff8

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dda0 r5:c7a7dda0 r4:0000005f r4:0000005f

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dcc8 to 0xc7a7dd10)
Exception stack(0xc7a7dcc8 to 0xc7a7dd10)
dcc0: dcc0:                                     00000124 00000124 c7a3cef8 c7a3cef8 d9056000 d9056000 00000001 00000001 c7a3cef8 c7a3cef8 00000124 00000124 

dce0: dce0: 00000000 00000000 00000124 00000124 00000001 00000001 c0659170 c0659170 00000021 00000021 c7a7dd2c c7a7dd2c c7a7dd30 c7a7dd30 c7a7dd10 c7a7dd10 

dd00: dd00: c0091190 c0091190 c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c0091190>] from [<c0091190>] (handle_edge_irq+0x108/0x14c)
(handle_edge_irq+0x108/0x14c)
 r7:00000001 r7:00000001 r6:c7a3cef8 r6:c7a3cef8 r5:00000124 r5:00000124 r4:c065ce24 r4:c065ce24

[<c0091088>] [<c0091088>] (handle_edge_irq+0x0/0x14c) (handle_edge_irq+0x0/0x14c) from [<c004c3d0>] from [<c004c3d0>] (gpio_irq_handler+0x12c/0x16c)
(gpio_irq_handler+0x12c/0x16c)
 r7:00000001 r7:00000001 r6:c065554c r6:c065554c r5:00000124 r5:00000124 r4:c065ce28 r4:c065ce28

[<c004c2a4>] [<c004c2a4>] (gpio_irq_handler+0x0/0x16c) (gpio_irq_handler+0x0/0x16c) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
dda0: dda0: 000000b9 000000b9 c7a8a910 c7a8a910 000000cb 000000cb 00000088 00000088 c7a8a910 c7a8a910 000000b9 000000b9 00000000 00000000 000000b9 000000b9 

ddc0: ddc0: 00000000 00000000 c0659080 c0659080 0000001d 0000001d c7a7de04 c7a7de04 c7a7de08 c7a7de08 c7a7dde8 c7a7dde8 c009133c c009133c c008fd30 c008fd30 

dde0: dde0: 40000113 40000113 ffffffff ffffffff                                                                                                             

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000001 r7:00000001 r6:c06553bc r6:c06553bc r5:000000b9 r5:000000b9 r4:c065b510 r4:c065b510

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c004c3d0>] from [<c004c3d0>] (gpio_irq_handler+0x12c/0x16c)
(gpio_irq_handler+0x12c/0x16c)
 r5:000000b9 r5:000000b9 r4:c065b514 r4:c065b514

[<c004c2a4>] [<c004c2a4>] (gpio_irq_handler+0x0/0x16c) (gpio_irq_handler+0x0/0x16c) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
de60: de60:                                                                         0000005c 0000005c c79304b0 c79304b0 0000006e 0000006e 00000000 00000000 

de80: de80: c79304b0 c79304b0 0000005c 0000005c 00000000 00000000 0000005c 0000005c 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7ded4 c7a7ded4 

dea0: dea0: c7a7ded8 c7a7ded8 c7a7deb8 c7a7deb8 c009133c c009133c c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000108 r7:00000108 r6:c7a7c000 r6:c7a7c000 r5:0000005c r5:0000005c r4:c0659f44 r4:c0659f44

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dfb0 r5:c7a7dfb0 r4:0000005c r4:0000005c

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7df08 to 0xc7a7df50)
Exception stack(0xc7a7df08 to 0xc7a7df50)
df00: df00:                                     40000000 40000000 c064e368 c064e368 00000000 00000000 c0698da0 c0698da0 0000003e 0000003e 00000000 00000000 

df20: df20: c7a7c000 c7a7c000 00000108 00000108 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7df7c c7a7df7c c7a7df80 c7a7df80 c7a7df50 c7a7df50 

df40: df40: c006dc00 c006dc00 c006db0c c006db0c 20000113 20000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c006dac4>] [<c006dac4>] (__do_softirq+0x0/0xf4) (__do_softirq+0x0/0xf4) from [<c006dc00>] from [<c006dc00>] (irq_exit+0x48/0x8c)
(irq_exit+0x48/0x8c)
[<c006dbb8>] [<c006dbb8>] (irq_exit+0x0/0x8c) (irq_exit+0x0/0x8c) from [<c003a06c>] from [<c003a06c>] (__exception_text_start+0x6c/0x88)
(__exception_text_start+0x6c/0x88)
 r5:00000000 r5:00000000 r4:0000003e r4:0000003e

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003abf8>] from [<c003abf8>] (__irq_usr+0x38/0x80)
(__irq_usr+0x38/0x80)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
dfa0: dfa0:                                                                         00000001 00000001 bee54608 bee54608 00000001 00000001 00000000 00000000 

dfc0: dfc0: 00000000 00000000 0000000c 0000000c 00000160 00000160 00000108 00000108 00000000 00000000 00000000 00000000 00000002 00000002 bee54644 bee54644 

dfe0: dfe0: 00000018 00000018 bee545d0 bee545d0 00166440 00166440 00166680 00166680 60000010 60000010 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

<3>BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
Modules linked in:Modules linked in: cir_lin cir_lin



Pid: 723, comm:               Xfbdev
Pid: 723, comm:               Xfbdev
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
PC is at handle_IRQ_event+0x28/0x74
PC is at handle_IRQ_event+0x28/0x74
LR is at handle_level_irq+0x94/0xec
LR is at handle_level_irq+0x94/0xec
pc : [<c008fd30>]    lr : [<c009133c>]    psr: 40000113
sp : c7a7dc78  ip : c7a7dc98  fp : c7a7dc94
pc : [<c008fd30>]    lr : [<c009133c>]    psr: 40000113
sp : c7a7dc78  ip : c7a7dc98  fp : c7a7dc94
r10: 00000021  r9 : c0659170  r8 : 00000001
r10: 00000021  r9 : c0659170  r8 : 00000001
r7 : 0000003e  r6 : 00000000  r5 : 0000003e  r4 : c7b82de0
r7 : 0000003e  r6 : 00000000  r5 : 0000003e  r4 : c7b82de0
r3 : 00000000  r2 : 00000050  r1 : c7b82de0  r0 : 0000003e
r3 : 00000000  r2 : 00000050  r1 : c7b82de0  r0 : 0000003e
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
[<c003c370>] [<c003c370>] (show_regs+0x0/0x50) (show_regs+0x0/0x50) from [<c008f838>] from [<c008f838>] (softlockup_tick+0x108/0x148)
(softlockup_tick+0x108/0x148)
 r5:00000aec r5:00000aec r4:00000aaf r4:00000aaf

[<c008f730>] [<c008f730>] (softlockup_tick+0x0/0x148) (softlockup_tick+0x0/0x148) from [<c0071c78>] from [<c0071c78>] (run_local_timers+0x1c/0x20)
(run_local_timers+0x1c/0x20)
 r8:c0658198 r8:c0658198 r7:00000baa r7:00000baa r6:0701430d r6:0701430d r5:c7818040 r5:c7818040 r4:00000000 r4:00000000

[<c0071c5c>] [<c0071c5c>] (run_local_timers+0x0/0x20) (run_local_timers+0x0/0x20) from [<c0071cf8>] from [<c0071cf8>] (update_process_times+0x30/0x60)
(update_process_times+0x30/0x60)
[<c0071cc8>] [<c0071cc8>] (update_process_times+0x0/0x60) (update_process_times+0x0/0x60) from [<c0084e78>] from [<c0084e78>] (tick_sched_timer+0x90/0xc4)
(tick_sched_timer+0x90/0xc4)
 r5:c7a7dc30 r5:c7a7dc30 r4:c069a488 r4:c069a488

[<c0084de8>] [<c0084de8>] (tick_sched_timer+0x0/0xc4) (tick_sched_timer+0x0/0xc4) from [<c007f0cc>] from [<c007f0cc>] (__run_hrtimer+0x58/0xa0)
(__run_hrtimer+0x58/0xa0)
 r7:7fffffff r7:7fffffff r6:ffffffff r6:ffffffff r5:c0658198 r5:c0658198 r4:c069a488 r4:c069a488

[<c007f074>] [<c007f074>] (__run_hrtimer+0x0/0xa0) (__run_hrtimer+0x0/0xa0) from [<c007fd88>] from [<c007fd88>] (hrtimer_interrupt+0x174/0x1ec)
(hrtimer_interrupt+0x174/0x1ec)
 r5:00000baa r5:00000baa r4:c069a488 r4:c069a488

[<c007fc14>] [<c007fc14>] (hrtimer_interrupt+0x0/0x1ec) (hrtimer_interrupt+0x0/0x1ec) from [<c00452c4>] from [<c00452c4>] (omap2_gp_timer_interrupt+0x28/0x34)
(omap2_gp_timer_interrupt+0x28/0x34)
[<c004529c>] [<c004529c>] (omap2_gp_timer_interrupt+0x0/0x34) (omap2_gp_timer_interrupt+0x0/0x34) from [<c008fd44>] from [<c008fd44>] (handle_IRQ_event+0x3c/0x74)
(handle_IRQ_event+0x3c/0x74)
[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:0000003e r7:0000003e r6:00000000 r6:00000000 r5:0000005f r5:0000005f r4:c0659ff8 r4:c0659ff8

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dcc8 r5:c7a7dcc8 r4:0000005f r4:0000005f

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dc30 to 0xc7a7dc78)
Exception stack(0xc7a7dc30 to 0xc7a7dc78)
dc20: dc20:                                                                         0000003e 0000003e c7b82de0 c7b82de0 00000050 00000050 00000000 00000000 

dc40: dc40: c7b82de0 c7b82de0 0000003e 0000003e 00000000 00000000 0000003e 0000003e 00000001 00000001 c0659170 c0659170 00000021 00000021 c7a7dc94 c7a7dc94 

dc60: dc60: c7a7dc98 c7a7dc98 c7a7dc78 c7a7dc78 c009133c c009133c c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000124 r7:00000124 r6:00000000 r6:00000000 r5:0000003e r5:0000003e r4:c065983c r4:c065983c

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dda0 r5:c7a7dda0 r4:0000003e r4:0000003e

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dcc8 to 0xc7a7dd10)
Exception stack(0xc7a7dcc8 to 0xc7a7dd10)
dcc0: dcc0:                                     00000124 00000124 c7a3cef8 c7a3cef8 d9056000 d9056000 00000001 00000001 c7a3cef8 c7a3cef8 00000124 00000124 

dce0: dce0: 00000000 00000000 00000124 00000124 00000001 00000001 c0659170 c0659170 00000021 00000021 c7a7dd2c c7a7dd2c c7a7dd30 c7a7dd30 c7a7dd10 c7a7dd10 

dd00: dd00: c0091190 c0091190 c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c0091190>] from [<c0091190>] (handle_edge_irq+0x108/0x14c)
(handle_edge_irq+0x108/0x14c)
 r7:00000001 r7:00000001 r6:c7a3cef8 r6:c7a3cef8 r5:00000124 r5:00000124 r4:c065ce24 r4:c065ce24

[<c0091088>] [<c0091088>] (handle_edge_irq+0x0/0x14c) (handle_edge_irq+0x0/0x14c) from [<c004c3d0>] from [<c004c3d0>] (gpio_irq_handler+0x12c/0x16c)
(gpio_irq_handler+0x12c/0x16c)
 r7:00000001 r7:00000001 r6:c065554c r6:c065554c r5:00000124 r5:00000124 r4:c065ce28 r4:c065ce28

[<c004c2a4>] [<c004c2a4>] (gpio_irq_handler+0x0/0x16c) (gpio_irq_handler+0x0/0x16c) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
dda0: dda0: 000000b9 000000b9 c7a8a910 c7a8a910 000000cb 000000cb 00000088 00000088 c7a8a910 c7a8a910 000000b9 000000b9 00000000 00000000 000000b9 000000b9 

ddc0: ddc0: 00000000 00000000 c0659080 c0659080 0000001d 0000001d c7a7de04 c7a7de04 c7a7de08 c7a7de08 c7a7dde8 c7a7dde8 c009133c c009133c c008fd30 c008fd30 

dde0: dde0: 40000113 40000113 ffffffff ffffffff                                                                                                             

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000001 r7:00000001 r6:c06553bc r6:c06553bc r5:000000b9 r5:000000b9 r4:c065b510 r4:c065b510

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c004c3d0>] from [<c004c3d0>] (gpio_irq_handler+0x12c/0x16c)
(gpio_irq_handler+0x12c/0x16c)
 r5:000000b9 r5:000000b9 r4:c065b514 r4:c065b514

[<c004c2a4>] [<c004c2a4>] (gpio_irq_handler+0x0/0x16c) (gpio_irq_handler+0x0/0x16c) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
de60: de60:                                                                         0000005c 0000005c c79304b0 c79304b0 0000006e 0000006e 00000000 00000000 

de80: de80: c79304b0 c79304b0 0000005c 0000005c 00000000 00000000 0000005c 0000005c 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7ded4 c7a7ded4 

dea0: dea0: c7a7ded8 c7a7ded8 c7a7deb8 c7a7deb8 c009133c c009133c c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000108 r7:00000108 r6:c7a7c000 r6:c7a7c000 r5:0000005c r5:0000005c r4:c0659f44 r4:c0659f44

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dfb0 r5:c7a7dfb0 r4:0000005c r4:0000005c

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7df08 to 0xc7a7df50)
Exception stack(0xc7a7df08 to 0xc7a7df50)
df00: df00:                                     40000000 40000000 c064e368 c064e368 00000000 00000000 c0698da0 c0698da0 0000003e 0000003e 00000000 00000000 

df20: df20: c7a7c000 c7a7c000 00000108 00000108 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7df7c c7a7df7c c7a7df80 c7a7df80 c7a7df50 c7a7df50 

df40: df40: c006dc00 c006dc00 c006db0c c006db0c 20000113 20000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c006dac4>] [<c006dac4>] (__do_softirq+0x0/0xf4) (__do_softirq+0x0/0xf4) from [<c006dc00>] from [<c006dc00>] (irq_exit+0x48/0x8c)
(irq_exit+0x48/0x8c)
[<c006dbb8>] [<c006dbb8>] (irq_exit+0x0/0x8c) (irq_exit+0x0/0x8c) from [<c003a06c>] from [<c003a06c>] (__exception_text_start+0x6c/0x88)
(__exception_text_start+0x6c/0x88)
 r5:00000000 r5:00000000 r4:0000003e r4:0000003e

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003abf8>] from [<c003abf8>] (__irq_usr+0x38/0x80)
(__irq_usr+0x38/0x80)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
dfa0: dfa0:                                                                         00000001 00000001 bee54608 bee54608 00000001 00000001 00000000 00000000 

dfc0: dfc0: 00000000 00000000 0000000c 0000000c 00000160 00000160 00000108 00000108 00000000 00000000 00000000 00000000 00000002 00000002 bee54644 bee54644 

dfe0: dfe0: 00000018 00000018 bee545d0 bee545d0 00166440 00166440 00166680 00166680 60000010 60000010 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

<3>BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
Modules linked in:Modules linked in: cir_lin cir_lin



Pid: 723, comm:               Xfbdev
Pid: 723, comm:               Xfbdev
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
CPU: 0    Not tainted  (2.6.28-rc9-omap1-svn6-dirty #19)
PC is at handle_IRQ_event+0x28/0x74
PC is at handle_IRQ_event+0x28/0x74
LR is at handle_level_irq+0x94/0xec
LR is at handle_level_irq+0x94/0xec
pc : [<c008fd30>]    lr : [<c009133c>]    psr: 40000113
sp : c7a7dc78  ip : c7a7dc98  fp : c7a7dc94
pc : [<c008fd30>]    lr : [<c009133c>]    psr: 40000113
sp : c7a7dc78  ip : c7a7dc98  fp : c7a7dc94
r10: 00000021  r9 : c0659170  r8 : 00000001
r10: 00000021  r9 : c0659170  r8 : 00000001
r7 : 0000003e  r6 : 00000000  r5 : 0000003e  r4 : c7b82de0
r7 : 0000003e  r6 : 00000000  r5 : 0000003e  r4 : c7b82de0
r3 : 00000000  r2 : 00000050  r1 : c7b82de0  r0 : 0000003e
r3 : 00000000  r2 : 00000050  r1 : c7b82de0  r0 : 0000003e
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
Control: 10c5387d  Table: 87a9c018  DAC: 00000015
[<c003c370>] [<c003c370>] (show_regs+0x0/0x50) (show_regs+0x0/0x50) from [<c008f838>] from [<c008f838>] (softlockup_tick+0x108/0x148)
(softlockup_tick+0x108/0x148)
 r5:00000b29 r5:00000b29 r4:00000aec r4:00000aec

[<c008f730>] [<c008f730>] (softlockup_tick+0x0/0x148) (softlockup_tick+0x0/0x148) from [<c0071c78>] from [<c0071c78>] (run_local_timers+0x1c/0x20)
(run_local_timers+0x1c/0x20)
 r8:c0658198 r8:c0658198 r7:00000beb r7:00000beb r6:24ce30d7 r6:24ce30d7 r5:c7818040 r5:c7818040 r4:00000000 r4:00000000

[<c0071c5c>] [<c0071c5c>] (run_local_timers+0x0/0x20) (run_local_timers+0x0/0x20) from [<c0071cf8>] from [<c0071cf8>] (update_process_times+0x30/0x60)
(update_process_times+0x30/0x60)
[<c0071cc8>] [<c0071cc8>] (update_process_times+0x0/0x60) (update_process_times+0x0/0x60) from [<c0084e78>] from [<c0084e78>] (tick_sched_timer+0x90/0xc4)
(tick_sched_timer+0x90/0xc4)
 r5:c7a7dc30 r5:c7a7dc30 r4:c069a488 r4:c069a488

[<c0084de8>] [<c0084de8>] (tick_sched_timer+0x0/0xc4) (tick_sched_timer+0x0/0xc4) from [<c007f0cc>] from [<c007f0cc>] (__run_hrtimer+0x58/0xa0)
(__run_hrtimer+0x58/0xa0)
 r7:7fffffff r7:7fffffff r6:ffffffff r6:ffffffff r5:c0658198 r5:c0658198 r4:c069a488 r4:c069a488

[<c007f074>] [<c007f074>] (__run_hrtimer+0x0/0xa0) (__run_hrtimer+0x0/0xa0) from [<c007fd88>] from [<c007fd88>] (hrtimer_interrupt+0x174/0x1ec)
(hrtimer_interrupt+0x174/0x1ec)
 r5:00000beb r5:00000beb r4:c069a488 r4:c069a488

[<c007fc14>] [<c007fc14>] (hrtimer_interrupt+0x0/0x1ec) (hrtimer_interrupt+0x0/0x1ec) from [<c00452c4>] from [<c00452c4>] (omap2_gp_timer_interrupt+0x28/0x34)
(omap2_gp_timer_interrupt+0x28/0x34)
[<c004529c>] [<c004529c>] (omap2_gp_timer_interrupt+0x0/0x34) (omap2_gp_timer_interrupt+0x0/0x34) from [<c008fd44>] from [<c008fd44>] (handle_IRQ_event+0x3c/0x74)
(handle_IRQ_event+0x3c/0x74)
[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:0000003e r7:0000003e r6:00000000 r6:00000000 r5:0000005f r5:0000005f r4:c0659ff8 r4:c0659ff8

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dcc8 r5:c7a7dcc8 r4:0000005f r4:0000005f

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dc30 to 0xc7a7dc78)
Exception stack(0xc7a7dc30 to 0xc7a7dc78)
dc20: dc20:                                                                         0000003e 0000003e c7b82de0 c7b82de0 00000050 00000050 00000000 00000000 

dc40: dc40: c7b82de0 c7b82de0 0000003e 0000003e 00000000 00000000 0000003e 0000003e 00000001 00000001 c0659170 c0659170 00000021 00000021 c7a7dc94 c7a7dc94 

dc60: dc60: c7a7dc98 c7a7dc98 c7a7dc78 c7a7dc78 c009133c c009133c c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000124 r7:00000124 r6:00000000 r6:00000000 r5:0000003e r5:0000003e r4:c065983c r4:c065983c

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dda0 r5:c7a7dda0 r4:0000003e r4:0000003e

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dcc8 to 0xc7a7dd10)
Exception stack(0xc7a7dcc8 to 0xc7a7dd10)
dcc0: dcc0:                                     00000124 00000124 c7a3cef8 c7a3cef8 d9056000 d9056000 00000001 00000001 c7a3cef8 c7a3cef8 00000124 00000124 

dce0: dce0: 00000000 00000000 00000124 00000124 00000001 00000001 c0659170 c0659170 00000021 00000021 c7a7dd2c c7a7dd2c c7a7dd30 c7a7dd30 c7a7dd10 c7a7dd10 

dd00: dd00: c0091190 c0091190 c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c0091190>] from [<c0091190>] (handle_edge_irq+0x108/0x14c)
(handle_edge_irq+0x108/0x14c)
 r7:00000001 r7:00000001 r6:c7a3cef8 r6:c7a3cef8 r5:00000124 r5:00000124 r4:c065ce24 r4:c065ce24

[<c0091088>] [<c0091088>] (handle_edge_irq+0x0/0x14c) (handle_edge_irq+0x0/0x14c) from [<c004c3d0>] from [<c004c3d0>] (gpio_irq_handler+0x12c/0x16c)
(gpio_irq_handler+0x12c/0x16c)
 r7:00000001 r7:00000001 r6:c065554c r6:c065554c r5:00000124 r5:00000124 r4:c065ce28 r4:c065ce28

[<c004c2a4>] [<c004c2a4>] (gpio_irq_handler+0x0/0x16c) (gpio_irq_handler+0x0/0x16c) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
Exception stack(0xc7a7dda0 to 0xc7a7dde8)
dda0: dda0: 000000b9 000000b9 c7a8a910 c7a8a910 000000cb 000000cb 00000088 00000088 c7a8a910 c7a8a910 000000b9 000000b9 00000000 00000000 000000b9 000000b9 

ddc0: ddc0: 00000000 00000000 c0659080 c0659080 0000001d 0000001d c7a7de04 c7a7de04 c7a7de08 c7a7de08 c7a7dde8 c7a7dde8 c009133c c009133c c008fd30 c008fd30 

dde0: dde0: 40000113 40000113 ffffffff ffffffff                                                                                                             

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000001 r7:00000001 r6:c06553bc r6:c06553bc r5:000000b9 r5:000000b9 r4:c065b510 r4:c065b510

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c004c3d0>] from [<c004c3d0>] (gpio_irq_handler+0x12c/0x16c)
(gpio_irq_handler+0x12c/0x16c)
 r5:000000b9 r5:000000b9 r4:c065b514 r4:c065b514

[<c004c2a4>] [<c004c2a4>] (gpio_irq_handler+0x0/0x16c) (gpio_irq_handler+0x0/0x16c) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
Exception stack(0xc7a7de70 to 0xc7a7deb8)
de60: de60:                                                                         0000005c 0000005c c79304b0 c79304b0 0000006e 0000006e 00000000 00000000 

de80: de80: c79304b0 c79304b0 0000005c 0000005c 00000000 00000000 0000005c 0000005c 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7ded4 c7a7ded4 

dea0: dea0: c7a7ded8 c7a7ded8 c7a7deb8 c7a7deb8 c009133c c009133c c008fd30 c008fd30 40000113 40000113 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c008fd08>] [<c008fd08>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c009133c>] from [<c009133c>] (handle_level_irq+0x94/0xec)
(handle_level_irq+0x94/0xec)
 r7:00000108 r7:00000108 r6:c7a7c000 r6:c7a7c000 r5:0000005c r5:0000005c r4:c0659f44 r4:c0659f44

[<c00912a8>] [<c00912a8>] (handle_level_irq+0x0/0xec) (handle_level_irq+0x0/0xec) from [<c003a068>] from [<c003a068>] (__exception_text_start+0x68/0x88)
(__exception_text_start+0x68/0x88)
 r5:c7a7dfb0 r5:c7a7dfb0 r4:0000005c r4:0000005c

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003aa30>] from [<c003aa30>] (__irq_svc+0x30/0x80)
(__irq_svc+0x30/0x80)
Exception stack(0xc7a7df08 to 0xc7a7df50)
Exception stack(0xc7a7df08 to 0xc7a7df50)
df00: df00:                                     40000000 40000000 c064e368 c064e368 00000000 00000000 c0698da0 c0698da0 0000003e 0000003e 00000000 00000000 

df20: df20: c7a7c000 c7a7c000 00000108 00000108 00000002 00000002 c7a7c000 c7a7c000 0000000a 0000000a c7a7df7c c7a7df7c c7a7df80 c7a7df80 c7a7df50 c7a7df50 

df40: df40: c006dc00 c006dc00 c006db0c c006db0c 20000113 20000113 ffffffff ffffffff                                                                         

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff

[<c006dac4>] [<c006dac4>] (__do_softirq+0x0/0xf4) (__do_softirq+0x0/0xf4) from [<c006dc00>] from [<c006dc00>] (irq_exit+0x48/0x8c)
(irq_exit+0x48/0x8c)
[<c006dbb8>] [<c006dbb8>] (irq_exit+0x0/0x8c) (irq_exit+0x0/0x8c) from [<c003a06c>] from [<c003a06c>] (__exception_text_start+0x6c/0x88)
(__exception_text_start+0x6c/0x88)
 r5:00000000 r5:00000000 r4:0000003e r4:0000003e

[<c003a000>] [<c003a000>] (__exception_text_start+0x0/0x88) (__exception_text_start+0x0/0x88) from [<c003abf8>] from [<c003abf8>] (__irq_usr+0x38/0x80)
(__irq_usr+0x38/0x80)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
Exception stack(0xc7a7dfb0 to 0xc7a7dff8)
dfa0: dfa0:                                                                         00000001 00000001 bee54608 bee54608 00000001 00000001 00000000 00000000 

dfc0: dfc0: 00000000 00000000 0000000c 0000000c 00000160 00000160 00000108 00000108 00000000 00000000 00000000 00000000 00000002 00000002 bee54644 bee54644 

dfe0: dfe0: 00000018 00000018 bee545d0 bee545d0 00166440 00166440 00166680 00166680 60000010 60000010 ffffffff ffffffff                                     

 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff
