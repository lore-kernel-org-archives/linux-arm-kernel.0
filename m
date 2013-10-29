From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Oct 2013 15:20:37 -0400
Subject: [PATCHv2 0/7] ARM: imx: add IMX50 SoC support
In-Reply-To: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
Message-ID: <20131029192037.GE26784@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Tue, Oct 29, 2013 at 03:15:50PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> This set of patches is the code and device tree support for the Freescale
> IMX50 SoC. This part is similar to the IMX53 SoC family, and I have resued
> as much of its support as possible. These patches are against Shawn Guo's
> linux-2.6.git for-next branch.
> 
> This loads and runs on the Freescale IMX50-EVK board.

Hmmm... here's how far it gets:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.12.0-rc7+ (jason at triton) (gcc version 4.6.3 (Gentoo 4.6.3 p1.6, pie-0.5.2) ) #215 SMP Tue Oct 29 19:12:05 GMT 2013
[    0.000000] CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Freescale i.MX50 (Device Tree Support), model: SanDisk Connect Wireless Media Drive
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat 808cc480, node_mem_map 80929000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] PERCPU: Embedded 7 pages/cpu @80a33000 s7488 r8192 d12992 u32768
[    0.000000] pcpu-alloc: s7488 r8192 d12992 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. Total pages: 32512
[    0.000000] Kernel command line: debug ignore_loglevel earlyprintk console=ttymxc0,115200 init=/bin/sh root=/dev/ram0
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 120476K/131072K available (5555K kernel code, 259K rwdata, 1568K rodata, 1595K init, 364K bss, 10596K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0x88800000 - 0xff000000   (1896 MB)
[    0.000000]     lowmem  : 0x80000000 - 0x88000000   ( 128 MB)
[    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
[    0.000000]       .text : 0x80008000 - 0x806fcef4   (7124 kB)
[    0.000000]       .init : 0x806fd000 - 0x8088bd40   (1596 kB)
[    0.000000]       .data : 0x8088c000 - 0x808ccce0   ( 260 kB)
[    0.000000]        .bss : 0x808ccce8 - 0x80928030   ( 365 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] TrustZone Interrupt Controller (TZIC) initialized
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating delay loop... 

and, nothing...  I'll take a closer look later.

btw - this is with the two includes added into the clock patch.

thx,

Jason.
