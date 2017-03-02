From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 2 Mar 2017 14:36:23 +0100
Subject: DIfferent BogoMIPS value after bbaa06702719
 ("clocksource/drivers/arm_global_timer: Register delay timer")
Message-ID: <d22ec429-1a71-e56f-e1d7-28b066be8c1b@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just updated kernel on my SmartRG SR400ac (bcm4708-smartrg-sr400ac.dts) from
4.4 to 4.9 and noticed that this part of the log:
[    0.020820] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
(...)
[    0.190806] Brought up 2 CPUs
[    0.200022] SMP: Total of 2 processors activated (3188.32 BogoMIPS).

became:
[    0.027082] Calibrating delay loop (skipped), value calculated using timer frequency.. 800.00 BogoMIPS (lpj=4000000)
(...)
[    0.078858] Brought up 2 CPUs
[    0.088254] SMP: Total of 2 processors activated (1600.00 BogoMIPS).

This is caused by commit bbaa06702719 ("clocksource/drivers/arm_global_timer:
Register delay timer").

Is this something expected? Or should I be worried about this? I'm aware it's
just BogoMIPS, but I still prefer to ask :)

Boot log from 4.9.13
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.13 (zajec at linux-samsung.lan) (gcc version 5.4.0 (LEDE GCC 5.4.0 r3346+1-9eacb9d7fc) ) #0 SMP Wed Mar 1 14:40:17 2017
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: SmartRG SR400ac
[    0.000000] earlycon: ns16550 at MMIO 0x18000300 (options '')
[    0.000000] bootconsole [ns16550] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Hit pending asynchronous external abort (FSR=0x00001c06) during first unmask, this is most likely caused by a firmware/bootloader bug.
[    0.000000] percpu: Embedded 12 pages/cpu @c6dd7000 s17868 r8192 d23092 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65280
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 254860K/262144K available (3409K kernel code, 104K rwdata, 892K rodata, 228K init, 293K bss, 7284K reserved, 0K cma-reserved, 131072K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc035ca48   (3411 kB)
[    0.000000]       .init : 0xc043d000 - 0xc0476000   ( 228 kB)
[    0.000000]       .data : 0xc0476000 - 0xc0490180   ( 105 kB)
[    0.000000]        .bss : 0xc0490180 - 0xc04d95e0   ( 294 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: DT/platform modifies aux control register: 0x0a130000 -> 0x0a530000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e530001
[    0.000016] sched_clock: 64 bits at 400MHz, resolution 2ns, wraps every 4398046511103ns
[    0.008678] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
[    0.020820] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
[    0.113646] pid_max: default: 32768 minimum: 301
[    0.118723] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.125908] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.134089] CPU: Testing write buffer coherency: ok
[    0.139608] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.145842] Setting up static identity map for 0x82a0 - 0x82d4
[    0.190681] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.190806] Brought up 2 CPUs
[    0.200022] SMP: Total of 2 processors activated (3188.32 BogoMIPS).

Boot log from 4.9.13 with bbaa06702719 reverted
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.13 (zajec at linux-samsung.lan) (gcc version 5.4.0 (LEDE GCC 5.4.0 r3346+1-9eacb9d7fc) ) #0 SMP Wed Mar 1 14:40:17 2017
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: SmartRG SR400ac
[    0.000000] earlycon: ns16550 at MMIO 0x18000300 (options '')
[    0.000000] bootconsole [ns16550] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Hit pending asynchronous external abort (FSR=0x00001c06) during first unmask, this is most likely caused by a firmware/bootloader bug.
[    0.000000] percpu: Embedded 12 pages/cpu @c6dd7000 s17868 r8192 d23092 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65280
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 254860K/262144K available (3409K kernel code, 104K rwdata, 892K rodata, 228K init, 293K bss, 7284K reserved, 0K cma-reserved, 131072K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc035ca68   (3411 kB)
[    0.000000]       .init : 0xc043d000 - 0xc0476000   ( 228 kB)
[    0.000000]       .data : 0xc0476000 - 0xc0490180   ( 105 kB)
[    0.000000]        .bss : 0xc0490180 - 0xc04d95e0   ( 294 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: DT/platform modifies aux control register: 0x0a130000 -> 0x0a530000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e530001
[    0.000015] sched_clock: 64 bits at 400MHz, resolution 2ns, wraps every 4398046511103ns
[    0.008567] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
[    0.020571] Switching to timer-based delay loop, resolution 2ns
[    0.027082] Calibrating delay loop (skipped), value calculated using timer frequency.. 800.00 BogoMIPS (lpj=4000000)
[    0.038359] pid_max: default: 32768 minimum: 301
[    0.043367] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.050561] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.058779] CPU: Testing write buffer coherency: ok
[    0.064363] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.070593] Setting up static identity map for 0x82a0 - 0x82d4
[    0.078744] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.078858] Brought up 2 CPUs
[    0.088254] SMP: Total of 2 processors activated (1600.00 BogoMIPS).
