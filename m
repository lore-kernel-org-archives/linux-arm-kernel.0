From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 29 Mar 2016 10:55:07 -0400
Subject: Bad mode in undefined instruction handler detected
Message-ID: <CAF_dkJBa3Y1EZGduZyjWqV3p5s7zf+Y4ppdeKW8anhd5nkjOPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello folks...
I am looking for a clue as to how I might debug the following kernel oops:

Bad mode in undefined instruction handler detected
Internal error: Oops - bad mode: 0 [#1] ARM
Modules linked in: usb_f_eem g_ether u_ether libcomposite atmel_usba_udc
CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.0-linux4sam_5.1 #4
Hardware name: Atmel SAMA5
task: c11440b8 ti: c1140000 task.ti: c1140000
PC is at _einittext+0x3f9456e8/0xfffdb400
LR is at 0xc0c565c8
pc : [<ffff0024>]    lr : [<c0c565c8>]    psr: 600e0192
sp : c1141f30  ip : 00000019  fp : c11420d0
r10: c1147548  r9 : 00000132  r8 : b0a5c253
r7 : 00000132  r6 : b0a5bacb  r5 : 00000000  r4 : c1162d10
r3 : 00000132  r2 : b0a5c253  r1 : fffffff9  r0 : c1141f78
Flags: nZCv  IRQs off  FIQs on  Mode IRQ_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 24804059  DAC: 00000015
Process swapper (pid: 0, stack limit = 0xc1140208)
Stack: (0xc1141f30 to 0xc1142000)
1f20:                                     c1141f78 fffffff9 b0a5c253 00000132
1f40: c1162d10 00000000 b0a5bacb 00000132 b0a5c253 00000132 c1147548 c11420d0
1f60: 00000019 c1141f30 c0c565c8 ffff0024 600e0192 ffffffff b0a5c253 00000132
1f80: 00000001 c1140000 c11420c8 c1162d10 c11631c4 00000001 c1162d08 c1147548
1fa0: c11420d0 c003c9f0 00000000 c116d57b 00000000 c1142000 00000000 c0686c34
1fc0: ffffffff ffffffff c0686680 00000000 00000000 c06ad280 c116db14 c1142078
1fe0: c06ad27c c114518c 20004059 410fc051 00000000 20008078 00000000 00000000
Code: ea000481 ea000400 ea000487 e7fddef1 (e7fddef1)
---[ end trace bf564fba2bcf8264 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

This reproduces quite regularly on my (custom SAMA5) development board
when transferring data from a camera (wired to the ISI port) to an
external host via USB.  So the problem could be related to the camera
driver, the USB driver, or something completely different (such as a
memory error that happens to occur with the same symptoms every time I
run my code for 5 to 10 minutes, despite the fact that I am unable to
induce a memory error by running stress, stress-ng, or memtester).

Any clues as to how I might parse this oops and ultimately track down
the root cause of this would be greatly appreciated.

Thanks.

--wpd
