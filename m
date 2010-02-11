From: pthomas8589@gmail.com (Paul Thomas)
Date: Thu, 11 Feb 2010 09:56:26 -0700
Subject: at91 preempt oops
Message-ID: <c785bba31002110856m4c1068cr47a476742c2c4562@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm getting the below oops with an Atmel at91sam9g20. I'm almost
certain this is because PREEMPT is enabled. It only seems to happen
sometimes at startup. I haven't seen it happen after the system is
booted.

Are people using PREEMPT with arm and the at91 series?

Should I send this to any other list?

thanks,
Paul


Starting Network Interface Plugging Daemon:huh, entered c01ddb2c with
preempt_count 00000103, exited with 00000102?
kernel BUG at kernel/timer.c:1035!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc5 #10)
PC is at __bug+0x1c/0x28
LR is at __bug+0x18/0x28
pc : [<c002aff0>]    lr : [<c002afec>]    psr: 40000013
sp : c02e3ee8  ip : c02e3e48  fp : c0303eec
r10: c03042ec  r9 : c03040ec  r8 : c03044ec
r7 : c01ddb2c  r6 : c02e2000  r5 : 00000103  r4 : c03036e0
r3 : 00000000  r2 : c02e2000  r1 : 00000104  r0 : 00000029
Process swapper (pid: 0, stack limit = 0xc02e2270)
Stack: (0xc02e3ee8 to 0xc02e4000)
3ee0:                   00000103 c0044d78 00000020 c02e3ef8 c3916158 c3916158
3f00: 1b6b355a 00000103 00000004 c02e2000 00000101 00000001 c03035a8 0000000a
3f20: 00000000 c003fd80 00000000 c01a5748 00000001 00000013 00000000 00000013
3f40: 00000002 00000001 c02e2000 2002209c 00000000 c003fe58 00000013 c0027080
3f60: c0032f10 ffffffff fefff000 c0027b48 00000000 0005317f 0005217f 60000013
3f80: c02e2000 c02e5c70 c02e5b14 c02fe9f0 200220d0 41069265 2002209c 00000000
3fa0: 600000d3 c02e3fb8 c0028a0c c0028a18 60000013 ffffffff c0028f54 c0028f04
3fc0: 00000000 c0305fb8 c02fe9b0 c0024010 c02e5b08 c0008998 c0008494 00000000
3fe0: 00000000 c0024010 00053175 c02fea18 c0024414 20008034 00000000 00000000
[<c002aff0>] (__bug+0x1c/0x28) from [<c0044d78>] (run_timer_softirq+0x1b8/0x240)
[<c0044d78>] (run_timer_softirq+0x1b8/0x240) from [<c003fd80>]
(__do_softirq+0x90/0x124)
[<c003fd80>] (__do_softirq+0x90/0x124) from [<c003fe58>] (irq_exit+0x44/0x5c)
[<c003fe58>] (irq_exit+0x44/0x5c) from [<c0027080>] (asm_do_IRQ+0x80/0xa0)
[<c0027080>] (asm_do_IRQ+0x80/0xa0) from [<c0027b48>] (__irq_svc+0x48/0x8c)
Exception stack(0xc02e3f70 to 0xc02e3fb8)
3f60:                                     00000000 0005317f 0005217f 60000013
3f80: c02e2000 c02e5c70 c02e5b14 c02fe9f0 200220d0 41069265 2002209c 00000000
3fa0: 600000d3 c02e3fb8 c0028a0c c0028a18 60000013 ffffffff
[<c0027b48>] (__irq_svc+0x48/0x8c) from [<c0028a18>] (default_idle+0x2c/0x34)
[<c0028a18>] (default_idle+0x2c/0x34) from [<c0028f04>] (cpu_idle+0x68/0xcc)
[<c0028f04>] (cpu_idle+0x68/0xcc) from [<c0008998>] (start_kernel+0x280/0x2f0)
[<c0008998>] (start_kernel+0x280/0x2f0) from [<20008034>] (0x20008034)
Code: e1a01000 e59f000c eb0821ef e3a03000 (e5833000)
---[ end trace 45f5ae32ff087c05 ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<c002c724>] (unwind_backtrace+0x0/0xdc) from [<c02336b8>] (panic+0x3c/0x130)
[<c02336b8>] (panic+0x3c/0x130) from [<c002b56c>] (die+0x174/0x1a0)
[<c002b56c>] (die+0x174/0x1a0) from [<c002d6b0>] (__do_kernel_fault+0x68/0x80)
[<c002d6b0>] (__do_kernel_fault+0x68/0x80) from [<c002d88c>]
(do_page_fault+0x1c4/0x1dc)
[<c002d88c>] (do_page_fault+0x1c4/0x1dc) from [<c00272dc>]
(do_DataAbort+0x34/0x94)
[<c00272dc>] (do_DataAbort+0x34/0x94) from [<c0027aec>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc02e3ea0 to 0xc02e3ee8)
3ea0: 00000029 00000104 c02e2000 00000000 c03036e0 00000103 c02e2000 c01ddb2c
3ec0: c03044ec c03040ec c03042ec c0303eec c02e3e48 c02e3ee8 c002afec c002aff0
3ee0: 40000013 ffffffff
[<c0027aec>] (__dabt_svc+0x4c/0x60) from [<c002aff0>] (__bug+0x1c/0x28)
[<c002aff0>] (__bug+0x1c/0x28) from [<c0044d78>] (run_timer_softirq+0x1b8/0x240)
[<c0044d78>] (run_timer_softirq+0x1b8/0x240) from [<c003fd80>]
(__do_softirq+0x90/0x124)
[<c003fd80>] (__do_softirq+0x90/0x124) from [<c003fe58>] (irq_exit+0x44/0x5c)
[<c003fe58>] (irq_exit+0x44/0x5c) from [<c0027080>] (asm_do_IRQ+0x80/0xa0)
[<c0027080>] (asm_do_IRQ+0x80/0xa0) from [<c0027b48>] (__irq_svc+0x48/0x8c)
Exception stack(0xc02e3f70 to 0xc02e3fb8)
3f60:                                     00000000 0005317f 0005217f 60000013
3f80: c02e2000 c02e5c70 c02e5b14 c02fe9f0 200220d0 41069265 2002209c 00000000
3fa0: 600000d3 c02e3fb8 c0028a0c c0028a18 60000013 ffffffff
[<c0027b48>] (__irq_svc+0x48/0x8c) from [<c0028a18>] (default_idle+0x2c/0x34)
[<c0028a18>] (default_idle+0x2c/0x34) from [<c0028f04>] (cpu_idle+0x68/0xcc)
[<c0028f04>] (cpu_idle+0x68/0xcc) from [<c0008998>] (start_kernel+0x280/0x2f0)
[<c0008998>] (start_kernel+0x280/0x2f0) from [<20008034>] (0x20008034)
