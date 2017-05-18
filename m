From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Thu, 18 May 2017 12:32:24 +0200
Subject: [PATCH 0/8] clocksource: Generalize Faraday timer
In-Reply-To: <20170517140542.20016-1-linus.walleij@linaro.org>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
Message-ID: <CACmBeS2S=0Qg2jnWMw0PR4Rdkz8hhsdV5VYqMNMBbrdOn-CkrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 May 2017 at 16:05, Linus Walleij <linus.walleij@linaro.org> wrote:
> The patches can be applied as soon as Jonas Jensen and Joel
> Stanley says they work for them.

Thanks! fttmr010 seem to work OK!

I did the usual test on UC-7112-LX [1] after merging
linux-nomadik/fttmr010 into next-20170518.

[1] https://bitbucket.org/Kasreyn/linux-next/commits/2904b508ad46bd98b09c11e312c396d672fc7e9a
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc1-next-20170518-00010-g2904b50
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4483 PREEMPT
Thu May 18 11:38:28 CEST 2017
[    0.000000] CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] OF: fdt: Machine model: MOXA UC-7112-LX
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 8128
[    0.000000] Kernel command line: console=ttyS0,115200n8 earlyprintk
root=/dev/mmcblk0p1 rw rootwait
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Memory: 19172K/32768K available (3421K kernel code,
156K rwdata, 724K rodata, 192K init, 8587K bss, 13596K reserved, 0K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc2800000 - 0xff800000   ( 976 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]       .text : 0xc0008000 - 0xc035f700   (3422 kB)
[    0.000000]       .init : 0xc0430000 - 0xc0460000   ( 192 kB)
[    0.000000]       .data : 0xc0460000 - 0xc0487360   ( 157 kB)
[    0.000000]        .bss : 0xc048ba40 - 0xc0cee7ec   (8588 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] RCU lockdep checking is enabled.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: FTTMR010-TIMER2: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 39817925974 ns
[    0.000087] sched_clock: 32 bits at 48MHz, resolution 20ns, wraps
every 44739242997ns
[    0.009487] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.017848] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.024640] ... MAX_LOCK_DEPTH:          48
[    0.029566] ... MAX_LOCKDEP_KEYS:        8191
[    0.034261] ... CLASSHASH_SIZE:          4096
[    0.039299] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.044069] ... MAX_LOCKDEP_CHAINS:      65536
[    0.049183] ... CHAINHASH_SIZE:          32768
[    0.053969]  memory used by lock dependency info: 5167 kB
[    0.060064]  per task-struct memory footprint: 1536 bytes
[    0.072855] kmemleak: Kernel memory leak detector disabled
[    0.091073] kmemleak: Early log buffer exceeded (1229), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.101346] Calibrating delay loop... 143.76 BogoMIPS (lpj=718848)
[    0.175662] pid_max: default: 4096 minimum: 301
[    0.183736] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.191487] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.217924] CPU: Testing write buffer coherency: ok
[    0.250678] Setting up static identity map for 0x8200 - 0x8248
[    0.262190] Hierarchical SRCU implementation.
[    0.327717] devtmpfs: initialized
[    0.407364] DMA-API: preallocated 4096 debug entries
[    0.413210] DMA-API: debugging enabled by kernel config
[    0.445120] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.458278] kworker/u2:0 (14) used greatest stack depth: 6224 bytes left
[    0.467584] futex hash table entries: 16 (order: -3, 704 bytes)
[    0.498128] NET: Registered protocol family 16
[    0.518378] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.558707] kworker/u2:1 (17) used greatest stack depth: 5856 bytes left
[    1.322437] clocksource: Switched to clocksource FTTMR010-TIMER2
[    1.426799] NET: Registered protocol family 2
[    1.448712] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    1.457909] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    1.468402] TCP: Hash tables configured (established 1024 bind 1024)
[    1.479267] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.487244] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.501083] NET: Registered protocol family 1
[    1.555364] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    2.067555] jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    2.209611] io scheduler noop registered
[    2.221533] io scheduler cfq registered (default)
[    2.229911] io scheduler mq-deadline registered
[    2.236161] io scheduler kyber registered
[    2.298243] ftgpio010-gpio 98700000.gpio: FTGPIO010 @c289e000 registered
[    2.338079] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    2.419644] console [ttyS0] disabled
[    2.429418] 98200000.uart: ttyS0 at MMIO 0x98200000 (irq = 21,
base_baud = 921600) is a 16550A
[    2.444308] console [ttyS0] enabled
[    2.444308] console [ttyS0] enabled
[    2.452080] bootconsole [earlycon0] disabled
[    2.452080] bootconsole [earlycon0] disabled
[    2.534670] 80000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    2.546948] Intel/Sharp Extended Query Table at 0x0031
[    2.554074] random: fast init done
[    2.559148] Intel/Sharp Extended Query Table at 0x0031
[    2.565687] Using buffer write method
[    2.569613] cfi_cmdset_0001: Erase suspend on write enabled
[    2.577158] 4 ofpart partitions found on MTD device 80000000.flash
[    2.584094] Creating 4 MTD partitions on "80000000.flash":
[    2.590023] 0x000000000000-0x000000040000 : "bootloader"
[    2.666600] 0x000000040000-0x000000200000 : "linux kernel"
[    2.725067] 0x000000200000-0x000000a00000 : "root filesystem"
[    2.781665] 0x000000a00000-0x000001000000 : "user filesystem"
[    3.499737] libphy: MOXA ART Ethernet MII: probed
[    4.186428] libphy: MOXA ART Ethernet MII: probed
[    4.234239] libphy: Fixed MDIO Bus: probed
[    4.359522] moxart-rtc 90000000.soc:rtc: rtc core: registered
90000000.soc:rtc as rtc0
[    4.439789] sdhci: Secure Digital Host Controller Interface driver
[    4.451775] sdhci: Copyright(c) Pierre Ossman
[    4.546512] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.609536] NET: Registered protocol family 17
[    4.621712] mmc0: new SD card at address e624
[    4.704356] mmcblk0: mmc0:e624 SD02G 1.84 GiB
[    4.768791]  mmcblk0: p1
[    4.779134] console [netcon0] enabled
[    4.794176] netconsole: network logging started
[    4.834073] moxart-rtc 90000000.soc:rtc: setting system clock to
2017-05-18 10:10:23 UTC (1495102223)
[    4.889168] EXT4-fs (mmcblk0p1): mounting ext3 file system using
the ext4 subsystem
[    5.309434] EXT4-fs (mmcblk0p1): warning: mounting fs with errors,
running e2fsck is recommended
[    5.351091] EXT4-fs (mmcblk0p1): recovery complete
[    5.370392] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
data mode. Opts: (null)
[    5.381420] VFS: Mounted root (ext3 filesystem) on device 179:1.
[    5.475945] devtmpfs: mounted
[    5.514759] Freeing unused kernel memory: 192K
[    5.521611] This architecture does not have kernel memory protection.
INIT: version 2.88 booting

   Jonas
