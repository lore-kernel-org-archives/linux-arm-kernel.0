From: harishpresent@gmail.com (Harishkumar V)
Date: Sun, 27 Jun 2010 21:51:57 +0530
Subject: BUG: soft lockup - CPU#0 stuck for 61s!
In-Reply-To: <AANLkTilLOgIi_3tttL1XapPLbB3CTUPK1b_bufIsU6Sz@mail.gmail.com>
References: <AANLkTilsRHU43nqfCvS-7NW6n_E0uP1JTEKKVFPvWkxP@mail.gmail.com>
	<AANLkTilLOgIi_3tttL1XapPLbB3CTUPK1b_bufIsU6Sz@mail.gmail.com>
Message-ID: <AANLkTinGbpSfOpCpmoIIF8PT-7BseuGvIK61GSMGcxJH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using an ARMv7 500 mhz board which is running linux-2.6.28-rc9 kernel.
I am running an application which does video processing on it. At times, the
board gets CPU soft lockup and become freezed.

Is their any fix/workaround for the following problem.

this is the one, i am getting in the console,

BUG: soft lockup - CPU#0 stuck for 61s! [linphone-3:764]
Modules linked in:

Pid: 764, comm:           linphone-3
CPU: 0    Not tainted  (2.6.28-rc9 #14)
PC is at handle_IRQ_event+0x28/0x74
LR is at handle_level_irq+0x94/0xec
pc : [<c008cc30>]    lr : [<c008e18c>]    psr: 48000113
sp : c7eede90  ip : c7eedeb0  fp : c7eedeac
r10: 0000001d  r9 : c0638ba8  r8 : 00000000
r7 : 0000005c  r6 : 00000000  r5 : 0000005c  r4 : c7a1b360
r3 : 00000000  r2 : 0000006e  r1 : c7a1b360  r0 : 0000005c
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87f48018  DAC: 00000015
[<c003b370>] (show_regs+0x0/0x50) from [<c008c738>]
(softlockup_tick+0x108/0x148)
 r5:00000104 r4:000000c7
[<c008c630>] (softlockup_tick+0x0/0x148) from [<c006f25c>]
(run_local_timers+0x1c/0x20)
 r8:c0637d08 r7:00000107 r6:297648b1 r5:c7976cc0 r4:00000000
[<c006f240>] (run_local_timers+0x0/0x20) from [<c006f2dc>]
(update_process_times+0x30/
0x60)
[<c006f2ac>] (update_process_times+0x0/0x60) from [<c0081f9c>]
(tick_sched_timer+0x90/0xc4)
 r5:c7eede48 r4:c06796d0
[<c0081f0c>] (tick_sched_timer+0x0/0xc4) from [<c007c2dc>]
(__run_hrtimer+0x30/0x70)
 r7:7fffffff r6:ffffffff r5:c0637d08 r4:c06796d0
[<c007c2ac>] (__run_hrtimer+0x0/0x70) from [<c007cf08>]
(hrtimer_interrupt+0x174/0x1e8)
 r5:00000107 r4:c06796d0
[<c007cd94>] (hrtimer_interrupt+0x0/0x1e8) from [<c004412c>]
(omap2_gp_timer_interrupt+0x28/0x34)
[<c0044104>] (omap2_gp_timer_interrupt+0x0/0x34) from [<c008cc44>]
(handle_IRQ_event+0x3c/0x74)
[<c008cc08>] (handle_IRQ_event+0x0/0x74) from [<c008e18c>]
(handle_level_irq+0x94/0xec)
 r7:0000005c r6:00000000 r5:0000005f r4:c0639b20
[<c008e0f8>] (handle_level_irq+0x0/0xec) from [<c0039068>]
(__exception_text_start+0x68/0x88)
 r5:c7eedee0 r4:0000005f
[<c0039000>] (__exception_text_start+0x0/0x88) from [<c0039a30>]
(__irq_svc+0x30/0x80)
Exception stack(0xc7eede48 to 0xc7eede90)
de40:                   0000005c c7a1b360 0000006e 00000000 c7a1b360
0000005c
de60: 00000000 0000005c 00000000 c0638ba8 0000001d c7eedeac c7eedeb0
c7eede90
de80: c008e18c c008cc30 48000113 ffffffff
 r5:d8200000 r4:ffffffff

-- 
Thanks and Regards,
Harish Kumar. V
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100627/696bf31b/attachment-0001.html>
