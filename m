From: dianders@google.com (Doug Anderson)
Date: Thu, 5 Jun 2014 18:08:32 -0700
Subject: Problems booting exynos5420 with >1 CPU
Message-ID: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When I try to boot linuxnext on my exynos5420-peach-pit chromebook I
have problems bringing up extra CPUs:

1. They don't come up

2. As they're coming up you can see U-Boot print out (!).  This sounds
similar to something that was happening during bringup where the other
CPUs didn't realize that they were not the primary CPU and started the
boot process all over again.

Can someone from Samsung take a look, or point at any in-flight
patches that will fix this?


Thanks!  Logs are below...  I'm on linuxnext 20140605 + my patch to
fix earlyprintk.  I'm using
<https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/eclass/cros-kernel/exynos5_defconfig>
but with CONFIG_NR_CPUS=8.


-Doug

---

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.15.0-rc8-next-20140605-00001-gdd2e9c6
(dianders at tictac.mtv.corp.google.com) (gcc version 4.8.x-google
20140307 (prerelease) (4.8.2_cos_gg_38c6bf0_4.8.2-r73) ) #96 SMP Thu
Jun 5 18:00:08 PDT 2014
[    0.000000] CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Google Peach Pit Rev 6+
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat 807a0a40,
node_mem_map ee7f3000
[    0.000000]   Normal zone: 3568 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 456704 pages, LIFO batch:31
[    0.000000]   HighMem zone: 528 pages used for memmap
[    0.000000]   HighMem zone: 67584 pages, LIFO batch:15
[    0.000000] PERCPU: Embedded 9 pages/cpu @ee781000 s13184 r8192 d15488 u36864
[    0.000000] pcpu-alloc: s13184 r8192 d15488 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 520720
[    0.000000] Kernel command line: cros_legacy cros_debug
console=ttySAC3,115200 debug slub_debug=FZPUA kgdboc=ttySAC3
earlyprintk root=/dev/mmcblk0p3 rootwait ro
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Memory: 2069908K/2097152K available (5445K kernel code,
357K rwdata, 1544K rodata, 444K init, 895K bss, 27244K reserved,
270336K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xef800000   (1784 MB)
[    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
[    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
[    0.000000]       .text : 0x80008000 - 0x806db78c   (6990 kB)
[    0.000000]       .init : 0x806dc000 - 0x8074b380   ( 445 kB)
[    0.000000]       .data : 0x8074c000 - 0x807a55a8   ( 358 kB)
[    0.000000]        .bss : 0x807a55a8 - 0x8088526c   ( 896 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: failed to init: -19
[    0.000005] sched_clock: 64 bits at 24MHz, resolution 41ns, wraps
every 2863311519744ns
[    0.008328] Console: colour dummy device 80x30
[    0.012698] Calibrating delay loop... 3581.54 BogoMIPS (lpj=8953856)
[    0.047723] pid_max: default: 32768 minimum: 301
[    0.052945] Security Framework initialized
[    0.057701] Mount-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.064325] Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.074789] CPU: Testing write buffer coherency: ok
[    0.079570] ftrace: allocating 19911 entries in 59 pages
[    0.104146] CPU0: update cpu_power 1535
[    0.107910] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.113925] Setting up static identity map for 0x204e2908 - 0x204e2960
[    1.125030] CPU1: failed to boot: -38
[    2.130043] CPU2: failed to boot: -38
[    3.135059] CPU3: failed to boot: -38


U-Boot 2013.04 (Apr 12 2014 - 13:50:09) for Peach

CPU:    Exynos5420 at 1800MHz

Board: Google Peach Pit, rev 9.0
I2C:   ready
DRAM:  2 GiB
[    4.140071] CPU4: failed to boot: -38
[    5.145086] CPU5: failed to boot: -38
[    6.150106] CPU6: failed to boot: -38
[    7.155127] CPU7: failed to boot: -38
[    7.158721] Brought up 1 CPUs
[    7.161746] SMP: Total of 1 processors activated.
[    7.166516] CPU: All CPU(s) started in SVC mode.
