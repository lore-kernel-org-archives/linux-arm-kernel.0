From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 Dec 2015 07:43:11 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
Message-ID: <6ae83861a7c8436d983ef99cd1b48a76@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

If I enable CONFIG_CPU_SW_DOMAIN_PAN, I sometimes (but not always) get the
following (or very similar) on boot.

Cheers,
Peter

Unhandled fault: page domain fault (0x81b) at 0x00086578
pgd = c2810000
[00086578] *pgd=22819831, *pte=224fe34f, *ppte=224fe83f
Internal error: : 81b [#1] ARM
Modules linked in:
CPU: 0 PID: 907 Comm: ntpd Not tainted 4.3.0+ #29
Hardware name: Atmel SAMA5
task: c398dac0 ti: c2804000 task.ti: c2804000
PC is at memcpy+0x50/0x330
LR is at 0x1
pc : [<c01daff0>]??? lr : [<00000001>]??? psr: 80070013
sp : c2805ed4? ip : 00000007? fp : 000d3808
r10: 00000000? r9 : 00000080? r8 : 00000001
r7 : 00000010? r6 : 00000010? r5 : 003f7374? r4 : 00000000
r3 : 00000002? r2 : ffffffe0? r1 : c2805f38? r0 : 00086578
Flags: Nzcv? IRQs on? FIQs on? Mode SVC_32? ISA ARM? Segment none
Control: 10c53c7d? Table: 22810059? DAC: 00000051
Process ntpd (pid: 907, stack limit = 0xc2804208)
Stack: (0xc2805ed4 to 0xc2806000)
5ec0:????????????????????????????????????????????? 00000000 c2804000 00000000
5ee0: c2805f18 00086578 00086578 c01e76c4 c2819218 c2ff3b74 000d4344 00086578
5f00: 00000000 00000051 0000007c c0010224 c2804000 c004c988 00000002 00000000
5f20: 003f7374 00000010 00000010 00000001 00000007 00000001 01f40000 565ff060
5f40: 000183ef 00002710 00000000 00000000 00000000 00000000 00000000 00000000
5f60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5f80: 00000000 00000000 00000000 00000000 00000000 00000000 000d3968 0005e38f
5fa0: 000d4344 c0010060 000d3968 0005e38f 00086578 00000000 ffffffff 00000001
5fc0: 000d3968 0005e38f 000d4344 0000007c 000d3814 00000001 000d4338 000d3808
5fe0: 00081e7c bec558b4 00026d3d b6d09126 00000030 00086578 009e3675 2a090bb6
[<c01daff0>] (memcpy) from [<c01e76c4>] (__copy_to_user_memcpy+0x138/0x17c)
[<c01e76c4>] (__copy_to_user_memcpy) from [<c004c988>] (SyS_adjtimex+0xd4/0xf0)
[<c004c988>] (SyS_adjtimex) from [<c0010060>] (ret_fast_syscall+0x0/0x3c)
Code: f5d1f05c f5d1f07c e8b151f8 e2522020 (e8a051f8)
---[ end trace 04981945a3df2e5e ]---
