From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 2 Nov 2015 16:52:49 +0100
Subject: [PATCH v8 0/2] Sigma Designs Tango4 port
In-Reply-To: <56377E76.2080209@sigmadesigns.com>
References: <56377E76.2080209@sigmadesigns.com>
Message-ID: <563786D1.5030604@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And here's the boot log I get with the submitted code:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.2.0+ (mgonzalez at summerrain) (gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11) ) #303 SMP PREEMPT Mon Nov 2 16:27:25 CET 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Sigma Designs SMP8758 Vantage-1172 dev board
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 163840
[    0.000000] free_area_init_node: node 0, pgdat c0374640, node_mem_map e7afa000
[    0.000000]   Normal zone: 1280 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 163840 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 10 pages/cpu @e7ade000 s9152 r8192 d23616 u40960
[    0.000000] pcpu-alloc: s9152 r8192 d23616 u40960 alloc=10*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 162560
[    0.000000] Kernel command line: ip=dhcp root=/dev/nfs rdinit=/none console=ttyS0,115200 mem=640M debug
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 645572K/655360K available (2531K kernel code, 84K rwdata, 728K rodata, 160K init, 218K bss, 9788K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe8800000 - 0xff000000   ( 360 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe8000000   ( 640 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc033702c   (3261 kB)
[    0.000000]       .init : 0xc0338000 - 0xc0360000   ( 160 kB)
[    0.000000]       .data : 0xc0360000 - 0xc03752c0   (  85 kB)
[    0.000000]        .bss : 0xc03752c0 - 0xc03abe50   ( 219 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 4 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x72860401
[    0.000000] clocksource: tango-xtal: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 70787423951 ns
[    0.000004] sched_clock: 32 bits at 27MHz, resolution 37ns, wraps every 79536431085ns
[    0.000014] Switching to timer-based delay loop, resolution 37ns
[    0.000276] Console: colour dummy device 80x30
[    0.000296] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.25 BogoMIPS (lpj=90000)
[    0.000307] pid_max: default: 32768 minimum: 301
[    0.000426] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000434] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000883] CPU: Testing write buffer coherency: ok
[    0.001097] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001152] Setting up static identity map for 0x80008280 - 0x800082b4
[    0.010308] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.010364] Brought up 2 CPUs
[    0.010377] SMP: Total of 2 processors activated (108.50 BogoMIPS).
[    0.010383] CPU: All CPU(s) started in SVC mode.
[    0.010814] devtmpfs: initialized
[    0.014256] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.014689] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.015140] NET: Registered protocol family 16
[    0.015894] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.017808] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.017821] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.024985] clocksource: Switched to clocksource tango-xtal
[    0.034805] NET: Registered protocol family 2
[    0.035633] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.035768] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.035867] TCP: Hash tables configured (established 8192 bind 8192)
[    0.035995] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.036044] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.036305] NET: Registered protocol family 1
[    0.036581] RPC: Registered named UNIX socket transport module.
[    0.036589] RPC: Registered udp transport module.
[    0.036595] RPC: Registered tcp transport module.
[    0.036600] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.036715] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.036860] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    0.037969] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.080837] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.082049] console [ttyS0] disabled
[    0.082169] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 18, base_baud = 460800) is a Palmchip BK-3103
[    0.586997] console [ttyS0] enabled
[    0.591384] tangox-enet 26000.ethernet: SMP86xx internal Ethernet at 0x26000
[    0.601390] libphy: tangox-mii: probed
[    0.665161] tangox-enet 26000.ethernet: PHY: found Atheros 8035 ethernet at 0x4
[    0.675815] tangox-enet 26000.ethernet eth0: MAC address 00:16:e8:02:08:42
[    0.683155] NET: Registered protocol family 17
[    0.687714] ThumbEE CPU extension supported.
[    0.692030] Registering SWP/SWPB emulation handler
[    1.211659] Sending DHCP requests ..
[    4.678605] tangox-enet 26000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    8.811641] ., OK
[    8.831647] IP-Config: Got DHCP answer from 172.27.200.1, my address is 172.27.64.49
[    8.839659] IP-Config: Complete: (snip)
[    8.885469] VFS: Mounted root (nfs filesystem) readonly on device 0:12.
[    8.892390] Freeing unused kernel memory: 160K (c0338000 - c0360000)
                                                  
Regards.
