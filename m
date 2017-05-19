From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 19 May 2017 15:23:49 +0200
Subject: [PATCH 7/8 v2] clocksource/drivers/fttmr010: Merge Moxa into
 FTTMR010
In-Reply-To: <20170518201705.28790-7-linus.walleij@linaro.org>
References: <20170518201705.28790-1-linus.walleij@linaro.org>
 <20170518201705.28790-7-linus.walleij@linaro.org>
Message-ID: <CACmBeS24u8T94-=3tB5m0_+LG=aPdwhki=RZBt-E-8ypb6+RDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2017 at 22:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> ChangeLog v1->v2:
> - As it appears that the Aspeed timers can only count downwards,
>   augment the code to deal with downward counting clockevent,
>   clock source and sched_clock(), and flag the Aspeed for this
>   mode.

Adding another successful spin from me using v2 of the complete series [1].

[1] https://bitbucket.org/Kasreyn/linux-next/commits/78456248df9eeb48c963b574f50c7268713ef0b1
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc1-next-20170518-00010-g7845624
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4486 PREEMPT
Fri May 19 14:04:54 CEST 2017
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
[    0.000000] Memory: 19132K/32768K available (3453K kernel code,
157K rwdata, 728K rodata, 192K init, 8587K bss, 13636K reserved, 0K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc2800000 - 0xff800000   ( 976 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0367910   (3455 kB)
[    0.000000]       .init : 0xc043a000 - 0xc046a000   ( 192 kB)
[    0.000000]       .data : 0xc046a000 - 0xc0491560   ( 158 kB)
[    0.000000]        .bss : 0xc0495cdc - 0xc0cf8c4c   (8588 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] RCU lockdep checking is enabled.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: FTTMR010-TIMER2: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 39817925974 ns
[    0.000089] sched_clock: 32 bits at 48MHz, resolution 20ns, wraps
every 44739242997ns
[    0.009440] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.017790] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.024511] ... MAX_LOCK_DEPTH:          48
[    0.029422] ... MAX_LOCKDEP_KEYS:        8191
[    0.034102] ... CLASSHASH_SIZE:          4096
[    0.039125] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.043886] ... MAX_LOCKDEP_CHAINS:      65536
[    0.048627] ... CHAINHASH_SIZE:          32768
[    0.053753]  memory used by lock dependency info: 5167 kB
[    0.059859]  per task-struct memory footprint: 1536 bytes
[    0.072501] kmemleak: Kernel memory leak detector disabled
[    0.090759] kmemleak: Early log buffer exceeded (1229), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.100997] Calibrating delay loop... 143.76 BogoMIPS (lpj=718848)
[    0.175633] pid_max: default: 4096 minimum: 301
[    0.183379] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.191120] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.217285] CPU: Testing write buffer coherency: ok
[    0.249546] Setting up static identity map for 0x8200 - 0x8248
[    0.261082] Hierarchical SRCU implementation.
[    0.329338] devtmpfs: initialized
[    0.409206] DMA-API: preallocated 4096 debug entries
[    0.414554] DMA-API: debugging enabled by kernel config
[    0.445030] kworker/u2:0 (14) used greatest stack depth: 6224 bytes left
[    0.455985] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.467884] futex hash table entries: 16 (order: -3, 704 bytes)
[    0.497799] NET: Registered protocol family 16
[    0.517950] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.557803] kworker/u2:1 (17) used greatest stack depth: 5856 bytes left
[    1.316981] clocksource: Switched to clocksource FTTMR010-TIMER2
[    1.415454] NET: Registered protocol family 2
[    1.440312] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    1.449574] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    1.460123] TCP: Hash tables configured (established 1024 bind 1024)
[    1.471541] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.479360] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.493097] NET: Registered protocol family 1
[    1.545526] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    2.049607] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    2.186448] io scheduler noop registered
[    2.199676] io scheduler cfq registered (default)
[    2.204813] io scheduler mq-deadline registered
[    2.212844] io scheduler kyber registered
[    2.273164] ftgpio010-gpio 98700000.gpio: FTGPIO010 @c289e000 registered
[    2.311358] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    2.392108] console [ttyS0] disabled
[    2.403351] 98200000.uart: ttyS0 at MMIO 0x98200000 (irq = 21,
base_baud = 921600) is a 16550A
[    2.417906] console [ttyS0] enabled
[    2.417906] console [ttyS0] enabled
[    2.425654] bootconsole [earlycon0] disabled
[    2.425654] bootconsole [earlycon0] disabled
[    2.508660] 80000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    2.520534] Intel/Sharp Extended Query Table at 0x0031
[    2.525990] Intel/Sharp Extended Query Table at 0x0031
[    2.531858] Using buffer write method
[    2.535736] cfi_cmdset_0001: Erase suspend on write enabled
[    2.543134] 4 ofpart partitions found on MTD device 80000000.flash
[    2.550035] Creating 4 MTD partitions on "80000000.flash":
[    2.555941] 0x000000000000-0x000000040000 : "bootloader"
[    2.563134] random: fast init done
[    2.634452] 0x000000040000-0x000000200000 : "linux kernel"
[    2.686438] 0x000000200000-0x000000a00000 : "root filesystem"
[    2.744918] 0x000000a00000-0x000001000000 : "user filesystem"
[    3.460849] libphy: MOXA ART Ethernet MII: probed
[    4.147623] libphy: MOXA ART Ethernet MII: probed
[    4.194338] libphy: Fixed MDIO Bus: probed
[    4.316628] moxart-rtc 90000000.soc:rtc: rtc core: registered
90000000.soc:rtc as rtc0
[    4.396418] sdhci: Secure Digital Host Controller Interface driver
[    4.406095] sdhci: Copyright(c) Pierre Ossman
[    4.500912] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.563980] NET: Registered protocol family 17
[    4.575489] mmc0: new SD card at address e624
[    4.662702] mmcblk0: mmc0:e624 SD02G 1.84 GiB
[    4.722683]  mmcblk0: p1
[    4.733139] console [netcon0] enabled
[    4.748281] netconsole: network logging started
[    4.778193] moxart-rtc 90000000.soc:rtc: setting system clock to
2017-05-19 12:59:09 UTC (1495198749)
[    4.835127] EXT4-fs (mmcblk0p1): mounting ext3 file system using
the ext4 subsystem
[    6.235992] EXT4-fs (mmcblk0p1): recovery complete
[    6.254832] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
data mode. Opts: (null)
[    6.265796] VFS: Mounted root (ext3 filesystem) on device 179:1.
[    6.373316] devtmpfs: mounted
[    6.410728] Freeing unused kernel memory: 192K
[    6.415430] This architecture does not have kernel memory protection.
INIT: version 2.88 booting


Tested-by: Jonas Jensen <jonas.jensen@gmail.com>


   Jonas
