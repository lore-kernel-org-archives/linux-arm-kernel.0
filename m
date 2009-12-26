From: koteswararao18@gmail.com (nelakurthi koteswararao)
Date: Sat, 26 Dec 2009 19:25:56 +0530
Subject: Fix for alignment Exception in IMX3 ARCH for clk_enable() fn
Message-ID: <bbfde6e10912260555n34a64d8bi440f7a0161e84912@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I am getting the following exception while executing clk_enable() function
present in
arch/arm/plat-mxc/clock.c file.

The exception message is given below.
=============================
Uncompressing
Linux....................................................................................................................................
done, bo.
<5>Linux version 2.6.31-rc7-alp_nl-kzm-arm11-gb70a2e1-dirty (gcc version
4.3.3  #78 PREEMPT Sat Dec 26 17:44:29 9
CPU: ARMv6-compatible processor [4107b364] revision 4 (ARMv6TEJ),
cr=00c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: KMC KZM-ARM11-01
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c040a300, node_mem_map c042a000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: console=ttymxc0 ip=on mem=128M
PID hash table entries: 512 (order: 9, 2048 bytes)
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 125524KB available (3752K code, 259K data, 108K init, 0K highmem)
<6>SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
<6>NR_IRQS:176
<6>MXC GPIO hardware
<6>MXC IRQ initialized
mx31_clocks_init entry function ***************
<6>Clock input source is 26000000
usage count 0 ,enable c002d954,clk shitf 20
usage count 0 ,enable c002d954,clk shitf 4
usage count 0 ,enable c002d954,clk shitf 8
usage count 0 ,enable c002d954,clk shitf 10
usage count 0 ,enable c002df48,clk shitf 0
usage count 3 ,enable c002d954,clk shitf 0
<6>Calibrating delay loop... <c>530.84 BogoMIPS (lpj=2654208)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>NET: Registered protocol family 16
<6>L2X0 cache controller enabled
clk_enable starts here -------->
usage count 0 ,enable c002d954,clk shitf 14
<1>Unhandled fault: alignment exception (0x001) at 0x0000000b
Internal error: : 1 [#1] PREEMPT
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.31-rc7-alp_nl-kzm-arm11-gb70a2e1-dirty #78)
PC is at die+0x84/0x174
LR is at __show_regs+0x1cc/0x220
pc : [<c00277d8>]    lr : [<c0024e38>]    psr: 20000193
sp : c77f4518  ip : c77f4418  fp : c040ab00
r10: 00000000  r9 : 60000193  r8 : 00000001
r7 : c77f45e0  r6 : ffffffff  r5 : c77f4000  r4 : 0000000b
r3 : c77f4268  r2 : c77f4000  r1 : 000001eb  r0 : c0387d86
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 80004000  DAC: 00000017
<1>Unhandled fault: alignment exception (0x001) at 0x000000fb
Internal error: : 1 [#13] PREEMPT
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.31-rc7-alp_nl-kzm-arm11-gb70a2e1-dirty #78)
PC is at die+0x84/0x174
LR is at __show_regs+0x1cc/0x220
pc : [<c00277d8>]    lr : [<c0024e38>]    psr: 20000193
sp : c77f4408  ip : c77f4308  fp : c040ab00
r10: 00000000  r9 : 60000193  r8 : 00000001
r7 : c77f44d0  r6 : ffffffff  r5 : c77f4000  r4 : 0000000c
r3 : c77f4268  r2 : c77f4000  r1 : 000001eb  r0 : c0387d86
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 80004000  DAC: 00000017
<1>Unhandled fault: alignment exception (0x001) at 0x000000fb
Internal error: : 1 [#14] PREEMPT
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.31-rc7-alp_nl-kzm-arm11-gb70a2e1-dirty #78)
PC is at die+0x84/0x174
LR is at __show_regs+0x1cc/0x220
pc : [<c00277d8>]    lr : [<c0024e38>]    psr: 20000193
sp : c77f42f8  ip : c77f41f8  fp : c040ab00
r10: 00000000  r9 : 60000193  r8 : 00000001
r7 : c77f43c0  r6 : ffffffff  r5 : c77f4000  r4 : 0000000d
r3 : c77f4268  r2 : c77f4000  r1 : 000001eb  r0 : c0387d86
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 80004000  DAC: 00000017
<1>Unhandled fault: alignment exception (0x001) at 0x000000fb
Internal error: : 1 [#15] PREEMPT: 0    Not tainted
(2.6.31-rc7-alp_nl-kzm-arm11-gb70a2e1-dirty #78)


Any tip to fix the alignment exception.

Thanks for allowing me to send mail.

Regards
koteswararao.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091226/847a39da/attachment-0001.htm>
