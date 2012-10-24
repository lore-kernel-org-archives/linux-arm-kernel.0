From: michael@walle.cc (Michael Walle)
Date: Wed, 24 Oct 2012 20:06:55 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
Message-ID: <201210242006.55879.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Am Mittwoch 24 Oktober 2012, 16:53:45 schrieb Andrew Lunn:
> This patchset converts all DT kirkwood boards to using pinctrl.
> 
> This patchset depends on an earlier patchset to allow the mvebu
> pinctrl driver and gpio driver to be built for kirkwood.
> 
> Only the TS219 conversion has been tested on hardware. The remaining
> are compile tested. Before merging upstream, it would be good if the
> others could be tested on hardware.
> 
> This series along with the dependents can be found in:

Unfortunately, this doesn't work for me. git bisect tells me its commit 
e01139ec82162f21875d09e820686aede4219695.

I guess it has something to do with the lsxl_init calling gpio_set_value().


Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.7.0-rc2-00015-g2773c33 (mw at thanatos) (gcc version 4.4.5 
(Debian 4.4.5-8) ) #8 PREEMPT Wed Oct 24 20:05:32 CEST 2012
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Marvell Kirkwood (Flattened Device Tree), model: Buffalo Linkstation 
LS-CHLv2
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS0,115200 root=/dev/sda2 earlyprintk
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 55828k/55828k available, 9708k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc04e2660   (4970 kB)
      .init : 0xc04e3000 - 0xc0506cc0   ( 144 kB)
      .data : 0xc0508000 - 0xc0540280   ( 225 kB)
       .bss : 0xc05402a4 - 0xc05d7a3c   ( 606 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:114
sched_clock: 32 bits at 166MHz, resolution 5ns, wraps every 25769ms
Console: colour dummy device 80x30
Calibrating delay loop... 597.60 BogoMIPS (lpj=2988032)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x3baaa8 - 0x3baae4
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 1024 KiB pool for atomic coherent allocations
Kirkwood: MV88F6281-A1, TCLK=166666667.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
Unable to handle kernel NULL pointer dereference at virtual address 0000003c
pgd = c0004000
[0000003c] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Not tainted  (3.7.0-rc2-00015-g2773c33 #8)
PC is at __gpio_set_value+0x20/0xb4
LR is at lsxl_init+0x14/0x58
pc : [<c01ab75c>]    lr : [<c04e99d0>]    psr: 20000053
sp : c342ff20  ip : 00000000  fp : 00000000
r10: 00000089  r9 : c0506878  r8 : c04e4498
r7 : 00000000  r6 : c05cea18  r5 : 00000000  r4 : 0000000b
r3 : 00000084  r2 : 00000001  r1 : 00000001  r0 : 0000000b
Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005397f  Table: 00004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc342e1b8)
Stack: (0xc342ff20 to 0xc3430000)
ff20: 00000037 c3b5508c c0516230 00000004 c05402c0 c04e99d0 c05005f8 c04e9640
ff40: c05005f8 c04e44b4 c05005f8 c0008614 00000003 00000003 00000000 c05005f8
ff60: c05005f8 00000004 c05402c0 c0500610 c04e31b0 00000089 00000000 c03ab064
ff80: 00000003 00000003 c04e31b0 c03aaf74 00000000 c03aaf74 00000000 00000000
ffa0: 00000000 00000000 00000000 c0008dd0 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c01ab75c>] (__gpio_set_value+0x20/0xb4) from [<c04e99d0>] 
(lsxl_init+0x14/0x58)
[<c04e99d0>] (lsxl_init+0x14/0x58) from [<c04e9640>] 
(kirkwood_dt_init+0xe4/0x158)
[<c04e9640>] (kirkwood_dt_init+0xe4/0x158) from [<c04e44b4>] 
(customize_machine+0x1c/0x28)
[<c04e44b4>] (customize_machine+0x1c/0x28) from [<c0008614>] 
(do_one_initcall+0x30/0x174)
[<c0008614>] (do_one_initcall+0x30/0x174) from [<c03ab064>] 
(kernel_init+0xf0/0x2a0)
[<c03ab064>] (kernel_init+0xf0/0x2a0) from [<c0008dd0>] 
(ret_from_fork+0x14/0x24)
Code: e24dd008 e1a04000 e7965003 e1a02001 (e5d5303c) 
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b



-- 
Michael
