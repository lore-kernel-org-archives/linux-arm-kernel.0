From: coosty@163.com (cini)
Date: Wed, 11 Sep 2013 13:30:42 +0800 (CST)
Subject: [PATCH ] ARM: sunxi: Add Emac,SMP and Arch_timer support
 for sunxi A20;Add phy cnt arch timer for ARMv7 support.
In-Reply-To: <22532daa.1421.1410a870d46.Coremail.coosty@163.com>
References: <16b7467c.1f121.141089f3d81.Coremail.coosty@163.com>
 <522F6964.9060603@elopez.com.ar>
 <22532daa.1421.1410a870d46.Coremail.coosty@163.com>
Message-ID: <2318a8c3.6a83.1410b8009a4.Coremail.coosty@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new patch(add_smp_emac_archtimer_forA20.patch) including miss files.plz replace old add_smp_emac_archtimer_forA20.patch.?
This is boot log:
Starting kernel ...




[ ? ?0.000000] Booting Linux on physical CPU 0x0
[ ? ?0.000000] Linux version 3.11.0-next-20130903-dirty (root at cini-VirtualBox) (gcc version 4.7.3 (Sourcery CodeBench Lite 2013.05-24) ) #137 SMP Tue Sep 10 23:13:01 CST 2013
[ ? ?0.000000] CPU: ARMv7 Processor [410fc074] revision 4 (ARMv7), cr=10c53c7d
[ ? ?0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[ ? ?0.000000] Machine: Allwinner A1X (Device Tree), model: Cubietech Cubieboard2
[ ? ?0.000000] Memory policy: ECC disabled, Data cache writealloc
[ ? ?0.000000] [sunxi7i_smp_init_cpus] ncores=2
[ ? ?0.000000] PERCPU: Embedded 7 pages/cpu @c0ef6000 s6464 r8192 d14016 u32768
[ ? ?0.000000] Built 1 zonelists in Zone order, mobility grouping on. ?Total pages: 260624
[ ? ?0.000000] Kernel command line: console=ttyS0,115200
[ ? ?0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[ ? ?0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[ ? ?0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[ ? ?0.000000] Memory: 1032396K/1048576K available (3439K kernel code, 179K rwdata, 980K rodata, 1966K init, 482K bss, 16180K reserved, 270336K highmem)
[ ? ?0.000000] Virtual kernel memory layout:
[ ? ?0.000000] ? ? vector ?: 0xffff0000 - 0xffff1000 ? ( ? 4 kB)
[ ? ?0.000000] ? ? fixmap ?: 0xfff00000 - 0xfffe0000 ? ( 896 kB)
[ ? ?0.000000] ? ? vmalloc : 0xf0000000 - 0xff000000 ? ( 240 MB)
[ ? ?0.000000] ? ? lowmem ?: 0xc0000000 - 0xef800000 ? ( 760 MB)
[ ? ?0.000000] ? ? pkmap ? : 0xbfe00000 - 0xc0000000 ? ( ? 2 MB)
[ ? ?0.000000] ? ? modules : 0xbf000000 - 0xbfe00000 ? ( ?14 MB)
[ ? ?0.000000] ? ? ? .text : 0xc0008000 - 0xc0458f3c ? (4420 kB)
[ ? ?0.000000] ? ? ? .init : 0xc0459000 - 0xc0644940 ? (1967 kB)
[ ? ?0.000000] ? ? ? .data : 0xc0646000 - 0xc0672ec0 ? ( 180 kB)
[ ? ?0.000000] ? ? ? ?.bss : 0xc0672ec8 - 0xc06eba54 ? ( 483 kB)
[ ? ?0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[ ? ?0.000000] Hierarchical RCU implementation.
[ ? ?0.000000] ?RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[ ? ?0.000000] NR_IRQS:16 nr_irqs:16 16
[ ? ?0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[ ? ?0.000000] Architected cp15 timer(s) running at 24.00MHz (virt).
[ ? ?0.000000] Switching to timer-based delay loop
[ ? ?0.000000] sched_clock: ARM arch timer >56 bits at 24000kHz, resolution 41ns
[ ? ?0.000000] Console: colour dummy device 80x30
[ ? 15.060670] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[ ? 15.060684] pid_max: default: 32768 minimum: 301
[ ? 15.060824] Mount-cache hash table entries: 512
[ ? 15.061500] CPU: Testing write buffer coherency: ok
[ ? 15.061788] CPU0: update cpu_power 1024
[ ? 15.061801] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[ ? 15.061835] Setting up static identity map for 0xc0343f70 - 0xc0343fa4
[ ? 15.062610] [sunxi7i_boot_secondary] enter cpu 1
[ ? 15.062674] cc_base is f0020c00
[ ? 15.073695] CPU1: Booted secondary processor
[ ? 15.073729] CPU1: update cpu_power 1024
[ ? 15.073735] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[ ? 15.073843] Brought up 2 CPUs
[ ? 15.073861] SMP: Total of 2 processors activated.
[ ? 15.073866] CPU: All CPU(s) started in SVC mode.
[ ? 15.074533] devtmpfs: initialized
[ ? 15.077992] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 4
[ ? 15.078161] pinctrl core: initialized pinctrl subsystem
[ ? 15.078317] regulator-dummy: no parameters
[ ? 15.079295] NET: Registered protocol family 16
[ ? 15.079546] DMA: preallocated 256 KiB pool for atomic coherent allocations
[ ? 15.083223] bio: create slab <bio-0> at 0
[ ? 15.084390] Switched to clocksource arch_sys_counter
[ ? 15.089338] NET: Registered protocol family 2
[ ? 15.089919] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[ ? 15.090092] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[ ? 15.090212] TCP: Hash tables configured (established 8192 bind 8192)
[ ? 15.090290] TCP: reno registered
[ ? 15.090303] UDP hash table entries: 512 (order: 2, 16384 bytes)
[ ? 15.090359] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[ ? 15.090942] RPC: Registered named UNIX socket transport module.
[ ? 15.090955] RPC: Registered udp transport module.
[ ? 15.090960] RPC: Registered tcp transport module.
[ ? 15.090966] RPC: Registered tcp NFSv4.1 backchannel transport module.
[ ? 15.220334] bounce pool size: 64 pages
[ ? 15.227490] NFS: Registering the id_resolver key type
[ ? 15.227577] Key type id_resolver registered
[ ? 15.227586] Key type id_legacy registered
[ ? 15.227601] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[ ? 15.228087] fuse init (API version 7.22)
[ ? 15.229159] Key type asymmetric registered
[ ? 15.229171] Asymmetric key parser 'x509' registered
[ ? 15.229369] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[ ? 15.229380] io scheduler noop registered
[ ? 15.229386] io scheduler deadline registered
[ ? 15.229523] io scheduler cfq registered (default)
[ ? 15.231164] sunxi-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
[ ? 15.262592] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[ ? 15.283675] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 33, base_baud = 1500000) is a U6_16550A
[ ? 15.746682] console [ttyS0] enabled
[ ? 15.755447] brd: module loaded
[ ? 15.758582] sun4i-mdio 1c0b080.mdio: no regulator found
[ ? 15.763792] libphy: sun4i_mii_bus: probed
[ ? 15.804858] sun4i-emac 1c0b000.ethernet: using random MAC address c6:9a:96:62:ad:9b
[ ? 15.814192] sun4i-emac 1c0b000.ethernet: eth0: at f006c000, IRQ 87 MAC: c6:9a:96:62:ad:9b
[ ? 15.822582] mousedev: PS/2 mouse device common for all mice
[ ? 15.828377] sdhci: Secure Digital Host Controller Interface driver
[ ? 15.834470] sdhci: Copyright(c) Pierre Ossman
[ ? 15.838751] sdhci-pltfm: SDHCI platform and OF driver helper
[ ? 15.844936] ipip: IPv4 over IPv4 tunneling driver
[ ? 15.850116] TCP: cubic registered
[ ? 15.853490] Key type dns_resolver registered
[ ? 15.860975] Freeing unused kernel memory: 1964K (c0459000 - c0644000)




Fiddlesticks login:?
Fiddlesticks login: root
-------------- next part --------------
A non-text attachment was scrubbed...
Name: add_smp_emac_archtimer_forA20.patch
Type: application/octet-stream
Size: 25670 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/eacb841e/attachment-0001.obj>
