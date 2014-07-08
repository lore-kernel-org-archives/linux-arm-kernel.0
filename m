From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 11:17:05 -0400
Subject: dove (marvell A510) crash on boot with config_preempt
In-Reply-To: <20140706080845.723e9787@armhf>
References: <20140706080845.723e9787@armhf>
Message-ID: <20140708151705.GE13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Francois,

+ Sebastian, Russell

On Sun, Jul 06, 2014 at 08:08:45AM +0200, Jean-Francois Moine wrote:
> Since the official 3.15.0 release, the kernel crashes at boot time
> when compiled with the option CONFIG_PREEMPT.
> 
> Reverting the commit 431a84b1a4f7d1a0085d5b91330c5053cc8e8b12
> 
>    ARM: 8034/1: Disable preemption in iwmmxt_task_enable()
> 
> removes the problem.
> 
> Linux version 3.16.0-rc3-00062-gd92a333-dirty (jef at armhf) (gcc version 4.8.3 (Debian 4.8.3-4) ) #5 PREEMPT Thu Jul 3 19:46:39 CEST 2014
> CPU: ARMv7 Processor [560f5815] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> Machine model: SolidRun CuBox
> cma: CMA: reserved 64 MiB at 3c000000
> Memory policy: Data cache writeback
> CPU: All CPU(s) started in SVC mode.
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
> Kernel command line: console=ttyS0,115200n8 console=tty1,115200 root=/dev/sda2 rootwait video=HDMI-A-1:1920x1080-32 at 60
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 968540K/1048576K available (3791K kernel code, 152K rwdata, 1012K rodata, 141K init, 135K bss, 80036K reserved)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
>     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
>     modules : 0x7f000000 - 0x80000000   (  16 MB)
>       .text : 0x80008000 - 0x804b8f0c   (4804 kB)
>       .init : 0x804b9000 - 0x804dc754   ( 142 kB)
>       .data : 0x804de000 - 0x805043c0   ( 153 kB)
>        .bss : 0x805043cc - 0x805260b8   ( 136 kB)
> Preemptible hierarchical RCU implementation.
>         Dump stacks of tasks blocking RCU-preempt GP.
> NR_IRQS:16 nr_irqs:16 16
> sched_clock: 32 bits at 166MHz, resolution 6ns, wraps every 25769803770ns
> Console: colour dummy device 80x30
> console [tty1] enabled
> Calibrating delay loop... 789.70 BogoMIPS (lpj=3948544)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0x3b9950 - 0x3b9984
> devtmpfs: initialized
> VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 5
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> Dove 88AP510 SoC
> Tauros2: Disabling L2 prefetch.
> Tauros2: Disabling line fill burt8.
> Tauros2: Enabling L2 cache.
> Tauros2: L2 cache support initialised in ARMv7 mode.
> reg-fixed-voltage regulators:regulator at 1: could not find pctldev for node /mbus/internal-regs/pin-ctrl at d0200/pmx-gpio-1, deferring probe
> platform regulators:regulator at 1: Driver reg-fixed-voltage requests probe deferral
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Linux video capture interface: v2.00
> Switched to clocksource orion_clocksource
> NET: Registered protocol family 2
> TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP: reno registered
> UDP hash table entries: 512 (order: 1, 8192 bytes)
> UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
> NET: Registered protocol family 1
> futex hash table entries: 256 (order: -1, 3072 bytes)
> audit: initializing netlink subsys (disabled)
> audit: type=2000 audit(0.090:1): initialized
> msgmni has been set to 2019
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> dove-pinctrl f10d0200.pin-ctrl: falling back to hardcoded PMU resource
> dove-pinctrl f10d0200.pin-ctrl: [Firmware Bug]: Missing pinctrl regs in DTB. Please update your firmware.
> dove-pinctrl f10d0200.pin-ctrl: registered pinctrl driver
> irq: Cannot allocate irq_descs @ IRQ38, assuming pre-allocated
> irq: Cannot allocate irq_descs @ IRQ70, assuming pre-allocated
> mv_xor f1060800.dma-engine: Marvell shared XOR driver
> mv_xor f1060800.dma-engine: Marvell XOR: ( xor cpy )
> mv_xor f1060800.dma-engine: Marvell XOR: ( xor cpy )
> mv_xor f1060900.dma-engine: Marvell shared XOR driver
> mv_xor f1060900.dma-engine: Marvell XOR: ( xor cpy )
> mv_xor f1060900.dma-engine: Marvell XOR: ( xor cpy )
> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> console [ttyS0] disabled
> f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 20, base_baud = 10416666) is a 16550A
> console [ttyS0] enabled
> brd: module loaded
> sata_mv f10a0000.sata-host: slots 32 ports 1
> scsi0 : sata_mv
> ata1: SATA max UDMA/133 irq 29
> libphy: orion_mdio_bus: probed
> mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
> mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 00:50:43:b6:3b:10
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-orion: EHCI orion driver
> orion-ehci f1050000.usb-host: EHCI Host Controller
> orion-ehci f1050000.usb-host: new USB bus registered, assigned bus number 1
> orion-ehci f1050000.usb-host: irq 24, io mem 0xf1050000
> orion-ehci f1050000.usb-host: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> orion-ehci f1051000.usb-host: EHCI Host Controller
> orion-ehci f1051000.usb-host: new USB bus registered, assigned bus number 2
> orion-ehci f1051000.usb-host: irq 25, io mem 0xf1051000
> orion-ehci f1051000.usb-host: USB 2.0 started, EHCI 1.00
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> usbcore: registered new interface driver usb-storage
> mousedev: PS/2 mouse device common for all mice
> rtc-mv f10d8500.real-time-clock: rtc core: registered f10d8500.real-time- as rtc0
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> mmc0: no vqmmc regulator found
> mmc0: no vmmc regulator found
> mmc0: SDHCI controller on f1092000.sdio-host [f1092000.sdio-host] using DMA
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> TCP: cubic registered
> NET: Registered protocol family 10
> NET: Registered protocol family 17
> ThumbEE CPU extension supported.
> PJ4 iWMMXt v2 coprocessor enabled.
> USB Power: 5000 mV 
> rtc-mv f10d8500.real-time-clock: setting system clock to 2014-07-04 07:37:21 UTC (1404459441)
> mmc0: new high speed SDHC card at address e624
> mmcblk0: mmc0:e624 SU16G 14.8 GiB 
>  mmcblk0: p1 p2 p3
> usb 1-1: new high-speed USB device number 2 using orion-ehci
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
> ata1.00: ATA-8: WDC WD10EARX-32N0YB0, 51.0AB51, max UDMA/133
> ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EARX-32N AB51 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> usb-storage 1-1:1.0: USB Mass Storage device detected
> sd 0:0:0:0: [sda] 4096-byte physical blocks
> scsi1 : usb-storage 1-1:1.0
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> EXT3-fs (sda2): error: couldn't mount because of unsupported optional features (240)
> EXT2-fs (sda2): error: couldn't mount because of unsupported optional features (240)
> usb 2-1: new high-speed USB device number 2 using orion-ehci
> EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
> devtmpfs: mounted
> Freeing unused kernel memory: 140K (804b9000 - 804dc000)
> hub 2-1:1.0: USB hub found
> hub 2-1:1.0: 4 ports detected
> usb 2-1.3: new low-speed USB device number 3 using orion-ehci
> input: Generic USB K/B as /devices/mbus/mbus:internal-regs/f1051000.usb-host/usb2/2-1/2-1.3/2-1.3:1.0/0003:13BA:0017.0001/input/input0
> hid-generic 0003:13BA:0017.0001: input: USB HID v1.10 Keyboard [Generic USB K/B] on usb-f1051000.usb-host-1.3/input0
> input: Generic USB K/B as /devices/mbus/mbus:internal-regs/f1051000.usb-host/usb2/2-1/2-1.3/2-1.3:1.1/0003:13BA:0017.0002/input/input1
> hid-generic 0003:13BA:0017.0002: input: USB HID v1.10 Mouse [Generic USB K/B] on usb-f1051000.usb-host-1.3/input1
> usb 2-1.4: new high-speed USB device number 4 using orion-ehci
> hub 2-1.4:1.0: USB hub found
> hub 2-1.4:1.0: 4 ports detected
> scsi 1:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.01 PQ: 0 ANSI: 2
> sd 1:0:0:0: [sdb] 7821312 512-byte logical blocks: (4.00 GB/3.72 GiB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] No Caching mode page found
> sd 1:0:0:0: [sdb] Assuming drive cache: write through
>  sdb: sdb1 sdb2
> sd 1:0:0:0: [sdb] Attached SCSI removable disk
> usb 2-1.4.2: new low-speed USB device number 5 using orion-ehci
> input: Dell Dell USB Optical Mouse as /devices/mbus/mbus:internal-regs/f1051000.usb-host/usb2/2-1/2-1.4/2-1.4.2/2-1.4.2:1.0/0003:413C:3012.0003/input/input2
> hid-generic 0003:413C:3012.0003: input: USB HID v1.11 Mouse [Dell Dell USB Optical Mouse] on usb-f1051000.usb-host-1.4.2/input0
> usb 2-1.4.3: new high-speed USB device number 6 using orion-ehci
> Unable to handle kernel paging request at virtual address fffffffe
> pgd = bb25c000
> [fffffffe] *pgd=3bfde821, *pte=00000000, *ppte=00000000
> Internal error: Oops: 80000007 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 62 Comm: startpar Not tainted 3.16.0-rc3-00062-gd92a333-dirty #5
> task: bb230b80 ti: bb256000 task.ti: bb256000
> PC is at 0xfffffffe
> LR is at iwmmxt_task_copy+0x44/0x4c
> pc : [<fffffffe>]    lr : [<800130ac>]    psr: 40000033
> sp : bb257de8  ip : 00000013  fp : bb257ea4
> r10: bb256000  r9 : fffffdfe  r8 : 76e898e6
> r7 : bb257ec8  r6 : bb256000  r5 : 7ea12760  r4 : 000000a0
> r3 : ffffffff  r2 : 00000003  r1 : bb257df8  r0 : 00000000
> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
> Control: 10c5387d  Table: 3b25c019  DAC: 00000015
> Process startpar (pid: 62, stack limit = 0xbb256248)
> Stack: (0xbb257de8 to 0xbb258000)
> 7de0:                   bb1b32a0 bb218890 12ef842a 000000a0 00000000 00000000
> 7e00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 7e20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 7e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 7e60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 7e80: 00000000 00000000 00000000 00000000 00000000 7ea12678 bb257ec4 bb257ea8
> 7ea0: 80010d04 80010b28 5ac3c35a bb257fb0 7ea12678 00000000 bb257f8c bb257ec8
> 7ec0: 80011190 80010b7c 0000af65 14000000 76e98cb1 08010a00 00000000 00000011
> 7ee0: 00000000 00040001 00000040 00000000 00000000 00000001 00000001 00000008
> 7f00: bb257f24 bb257f10 80029bc0 80027734 bb257f28 bb257f58 bb257f44 7ea12978
> 7f20: 00000008 7ea12978 00000008 00000000 00000000 00000000 bb257fa4 bb257f48
> 7f40: 800bf418 800be3f4 bb257f70 bb257f58 bb257f70 00000000 7ffabef8 00000011
> 7f60: 00010000 bb256010 bb256000 8000e904 bb257fb0 8000e904 bb256000 00020000
> 7f80: bb257fac bb257f90 80011468 80010e98 7ea12978 7ea12980 7ea12b44 0000014f
> 7fa0: 00000000 bb257fb0 8000e7c0 800113e4 fffffffc 00000000 00000000 00000000
> 7fc0: 7ea12978 7ea12980 7ea12b44 0000014f 00000000 00016210 00002030 00000001
> 7fe0: 0000014f 7ea12968 76f010e9 76e898e6 00000030 00000000 00000000 00000000
> Backtrace: 
> [<80010b1c>] (preserve_iwmmxt_context) from [<80010d04>] (setup_sigframe+0x194/0x1a8)
>  r5:7ea12678 r4:00000000
> [<80010b70>] (setup_sigframe) from [<80011190>] (do_signal+0x304/0x448)
>  r6:00000000 r5:7ea12678 r4:bb257fb0 r3:5ac3c35a
> [<80010e8c>] (do_signal) from [<80011468>] (do_work_pending+0x90/0xd0)
>  r10:00020000 r9:bb256000 r8:8000e904 r7:bb257fb0 r6:8000e904 r5:bb256000
>  r4:bb256010
> [<800113d8>] (do_work_pending) from [<8000e7c0>] (work_pending+0xc/0x20)
>  r7:0000014f r6:7ea12b44 r5:7ea12980 r4:7ea12978
> Code: bad PC value
> ---[ end trace 458bee342241e359 ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> 
> -- 
> Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
> Jef		|		http://moinejf.free.fr/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
