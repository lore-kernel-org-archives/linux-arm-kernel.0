From: try2share@gmail.com (K K)
Date: Mon, 28 May 2012 18:37:14 +0530
Subject: Booting stops with " Unable to handle kernel paging request at
 virtual address"
Message-ID: <CACZ0kf8fBcjWEVQN20w9+c1ZT9twa7gRW_j5nJsOrr=tx4OCNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We have a lpc-3180 based board and it is up and running fine with 2.6.10
kernel version. We planned to port our board changes into 2.6.32 kernel
version.

As a part of this, we added the architecture dependent  code  (mach
files)  first. Then we changed some of the kernel upgradations.

kernel build successfully. When we booting the board with the new 2.6.32
kernel we are getting following messages and its stops.

Viosoft RootFS
v0.1+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

U-Boot 1.1.1 (Oct 10 2006 - 21:35:44)

U-Boot code: 80EC0000 -> 80EE9600  BSS: -> 80EEAEE0
SDRAM : 32M detected
RAM Configuration:
Bank #0: 80000000 31 MB
Bank #1: 00000000  0 kB
Flash:  0 kB
NAND:NAND device: Manufacturer ID: 0x20, Chip ID: 0x35 (ST Micro NAND 32MiB
1,8V 8-bit)
Scanning device for bad blocks
Using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
Phytec # bootm 80600000
Boot reached stage 1
## Booting image at 80600000 ...
Boot reached stage 2
Boot reached stage 3
   Image Name:   Linux-2.6.32
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1301608 Bytes =  1.2 MB
   Load Address: 80008000
   Entry Point:  80008000
Boot reached stage 4
Boot reached stage 5
Boot reached stage 6
OK
Boot reached stage 7
Boot reached stage 8
Boot reached stage 14
Boot reached stage 15

Starting kernel ...

Uncompressing
Linux.................................................................................
done, booting the kern.
A
41069264:00001267:0005107C
8015F0A8-803C8FA8>80008000
803C8FB8
80008000: E321F0D3 EE109F10 EB0000D0 E1B0A005  0A00005F EB0000E6 E1B08005
0A000072
80008020: EB0000F5 EB000013 E59FD0F4 E28FE000  E28AF010 E3800002 E3A0501F
EE035F10
80008040: EE024F10 EA000005 E1A00000 E1A00000  E1A00000 E1A00000 E1A00000
E1A00000
80008060: E1A00000 EE010F10 EE103F10 E1A03003  E1A0300D E1A0F003 E59F409C
E1A00004
80008080: E3A03000 E2806901 E4803004 E4803004  E4803004 E4803004 E1300006
1AFFFFF9
800080A0: E59A7008 E1A0600F E1A06A26 E1873A06  E7843106 E2840A03 E5A03000
E59F605C
800080C0: E2800004 E0846926 E1500006 E2833601  94803004 9AFFFFFB E2840A03
E3876102
800080E0: E5806000 E59A700C E5983008 E0840003  E2633901 E3530B02 83A03B02
E0806003
B<5>Linux version 2.6.32 (kk at KK) (gcc version 4.6.1 (Sourcery CodeBench
Lite 2011.09-70) ) #62 Mon May 28 18:25:32 IST 2012
CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00057177
CPU: VIVT data cache, VIVT instruction cache
Machine: LPC3180
serial : early init
Memory policy: ECC disabled, Data cache writethrough
<7>On node 0 totalpages: 7936
<7>free_area_init_node: node 0, pgdat c026fd5c, node_mem_map c0283000
<7>  Normal zone: 62 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 7874 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 7874
<5>Kernel command line: console=ttyS0,115200n8 root=/dev/ram
initrd=0x80800000,12M
<6>*PID hash table entries: 128 (order: -3, 512 bytes)*
<6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
<6>Memory: 31MB = 31MB total
<5>Memory: 16600KB available (2268K code, 156K data, 104K init, 0K highmem)
<6>SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
<6>Hierarchical RCU implementation.
<6>NR_IRQS:96
<1>*Unable to handle kernel paging request at virtual address f0008010*
<1>pgd = c0004000
<1>[f0008010] *pgd=802c6051, *pte=00000000, *ppte=00000000
<0>Internal error: Oops: 27 [#1]
<0>last sysfs file:
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.32 #62)
PC is at set_irq_level+0xc/0x1c
LR is at LPC3180_set_irq_type+0xe4/0x13c
pc : [<c002bb80>]    lr : [<c002be10>]    psr: 800000d3
sp : c025bf80  ip : c025bf90  fp : c025bf8c
r10: 8001d8ac  r9 : 41069264  r8 : 8001d8e0
r7 : 00000004  r6 : f0008000  r5 : 00000000  r4 : 00000002
r3 : 00000003  r2 : c01d9a30  r1 : f0008000  r0 : 00000004
Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005717f  Table: 80004000  DAC: 00000017
<0>Process swapper (pid: 0, stack limit = 0xc025a260)
<0>Stack: (0xc025bf80 to 0xc025c000)
<0>bf80: c025bfac c025bf90 c002be10 c002bb84 00000003 c001fe08 c02c8060
c025e2f4
<0>bfa0: c025bfc0 c025bfb0 c000d7e8 c002bd3c c0271ea0 c025bfd0 c025bfc4
c000b378
<0>bfc0: c000d7cc c025bff4 c025bfd4 c00089f0 c000b350 c0008550 c001fe08
00057175
<0>bfe0: c02721c4 c002020c 00000000 c025bff8 80008034 c00088b8 00000000
00000000
Backtrace:
[<c002bb74>] (set_irq_level+0x0/0x1c) from [<c002be10>]
(LPC3180_set_irq_type+0xe4/0x13c)
[<c002bd2c>] (LPC3180_set_irq_type+0x0/0x13c) from [<c000d7e8>]
(LPC3180_init_irq+0x2c/0xdc)
 r7:c025e2f4 r6:c02c8060 r5:c001fe08 r4:00000003
[<c000d7bc>] (LPC3180_init_irq+0x0/0xdc) from [<c000b378>]
(init_IRQ+0x38/0x44)
 r4:c0271ea0
[<c000b340>] (init_IRQ+0x0/0x44) from [<c00089f0>]
(start_kernel+0x148/0x2ac)
[<c00088a8>] (start_kernel+0x0/0x2ac) from [<80008034>] (0x80008034)
 r6:c002020c r5:c02721c4 r4:00057175
<0>Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5912010)
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill the idle task!
Backtrace:
[<c00268e0>] (dump_backtrace+0x0/0x110) from [<c01d5384>]
(dump_stack+0x18/0x1c)
 r6:c025a000 r5:0000000b r4:c0272344
[<c01d536c>] (dump_stack+0x0/0x1c) from [<c01d5434>] (panic+0x48/0x118)
[<c01d53ec>] (panic+0x0/0x118) from [<c0041120>] (do_exit+0x68/0x5cc)
 r3:00000000 r2:00000000 r1:c025be0c r0:c0229bb1
[<c00410b8>] (do_exit+0x0/0x5cc) from [<c0026d98>] (die+0x164/0x188)
 r7:c0272780
[<c0026c34>] (die+0x0/0x188) from [<c0028914>] (__do_kernel_fault+0x6c/0x7c)
 r7:c025bf38
[<c00288a8>] (__do_kernel_fault+0x0/0x7c) from [<c0028ae4>]
(do_page_fault+0x1c0/0x1d8)
 r7:00000000 r6:c025bf38 r5:c025d688 r4:f0008010
[<c0028924>] (do_page_fault+0x0/0x1d8) from [<c0022238>]
(do_DataAbort+0x3c/0xa0)
[<c00221fc>] (do_DataAbort+0x0/0xa0) from [<c0022960>]
(__dabt_svc+0x40/0x60)
Exception stack(0xc025bf38 to 0xc025bf80)
bf20:                                                       00000004
f0008000
bf40: c01d9a30 00000003 00000002 00000000 f0008000 00000004 8001d8e0
41069264
bf60: 8001d8ac c025bf8c c025bf90 c025bf80 c002be10 c002bb80 800000d3
ffffffff
 r7:00000004 r6:f0008000 r5:c025bf6c r4:ffffffff
[<c002bb74>] (set_irq_level+0x0/0x1c) from [<c002be10>]
(LPC3180_set_irq_type+0xe4/0x13c)
[<c002bd2c>] (LPC3180_set_irq_type+0x0/0x13c) from [<c000d7e8>]
(LPC3180_init_irq+0x2c/0xdc)
 r7:c025e2f4 r6:c02c8060 r5:c001fe08 r4:00000003
[<c000d7bc>] (LPC3180_init_irq+0x0/0xdc) from [<c000b378>]
(init_IRQ+0x38/0x44)
 r4:c0271ea0
[<c000b340>] (init_IRQ+0x0/0x44) from [<c00089f0>]
(start_kernel+0x148/0x2ac)
[<c00088a8>] (start_kernel+0x0/0x2ac) from [<80008034>] (0x80008034)
 r6:c002020c r5:c02721c4 r4:00057175


can any idea to get rid of this issue.


Thanks,
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120528/c38f788e/attachment.html>
