From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jun 2015 18:40:14 -0300
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
Message-ID: <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 11:02 AM, Fabio Estevam <festevam@gmail.com> wrote:

> root at wandboard-solo:~# kexec -e
> [   33.853279] kexec: Starting new kernel
> [   33.857076] Disabling non-boot CPUs ...
> [   33.861107] Bye!
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.1.0-rc7-00063-gcff100f (fabio at fabio-Latitude-E645
> [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instructie
> [    0.000000] Machine model: Wandboard i.MX6 Dual Lite Board
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] cma: Reserved 16 MiB at 0x4f000000
> [    0.000000] Memory policy: Data cache writeback
>
> And then it hangs here.

I am using a mx6qsabresd now and running linux-next. In this case I am
able to proceed with the boot further:

root at wandboard-solo:~# kexec -d -l /tmp/zImage --dtb /tmp/imx6q-sabresd.dtb --co
mmand-line="console=ttymxc0,115200 earlyprintk root=/dev/mmcblk0p2 rootwait rw"
my_load:667: do
kernel: 0x75dd3008 kernel_size: 0x5dfc18
kexec_load: entry = 0x10008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0x75dd3008
segment[0].bufsz = 0x5dfc18
segment[0].mem   = 0x10008000
segment[0].memsz = 0x5e0000
segment[1].buf   = 0x3f0008
segment[1].bufsz = 0x8970
segment[1].mem   = 0x11781000
segment[1].memsz = 0x9000
root at wandboard-solo:~# kexec -e
[   70.267087] kexec: Starting new kernel
[   70.270941] Disabling non-boot CPUs ...
[   70.317951] CPU1: shutdown
[   70.447787] CPU2: shutdown
[   70.517750] CPU3: shutdown
[   70.551034] Bye!
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.1.0-rc7-next-20150615-dirty
(fabio at fabio-Latitude-E6410) (gcc version 4.7.3 (Ubuntu/Linaro
4.7.3-12ubu5
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: Freescale i.MX6 Quad SABRE Smart Device Board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 16 MiB at 0x4f000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 12 pages/cpu @be795000 s16960 r8192
d24000 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 260096
[    0.000000] Kernel command line: console=ttymxc0,115200 earlyprintk
root=/dev/mmcblk0p2 rootwait rw
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1003112K/1048576K available (7767K kernel code,
408K rwdata, 2648K rodata, 420K init, 8371K bss, 29080K reserv)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
[    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
[    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
[    0.000000]       .text : 0x80008000 - 0x80a3408c   (10417 kB)
[    0.000000]       .init : 0x80a35000 - 0x80a9e000   ( 420 kB)
[    0.000000]       .data : 0x80a9e000 - 0x80b04040   ( 409 kB)
[    0.000000]        .bss : 0x80b07000 - 0x81333dc4   (8372 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000006] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.008281] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.019091] Console: colour dummy device 80x30
[    0.023649] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.031478] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.035671] ... MAX_LOCK_DEPTH:          48
[    0.039939] ... MAX_LOCKDEP_KEYS:        8191
[    0.044391] ... CLASSHASH_SIZE:          4096
[    0.048833] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.053361] ... MAX_LOCKDEP_CHAINS:      65536
[    0.057898] ... CHAINHASH_SIZE:          32768
[    0.062427]  memory used by lock dependency info: 5167 kB
[    0.067919]  per task-struct memory footprint: 1152 bytes
[    0.073418] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=30000)
[    0.083713] pid_max: default: 32768 minimum: 301
[    0.088621] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.095341] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.103834] CPU: Testing write buffer coherency: ok
[    0.109472] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.115292] Setting up static identity map for 0x100082c0 - 0x10008330
[    0.125591] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.126896] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.127894] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.128054] Brought up 4 CPUs
[    0.148367] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.154644] CPU: All CPU(s) started in SVC mode.
[    0.160883] devtmpfs: initialized
[    0.186252] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.194779] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.206101] pinctrl core: initialized pinctrl subsystem
[    0.214024] NET: Registered protocol family 16
[    0.221896] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.230531] CPU identified as i.MX6Q, silicon rev 1.2
[    0.271546] No ATAGs?
[    0.273715] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.282076] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.290359] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.349288] mxs-dma 110000.dma-apbh: initialized
[    0.358562] vgaarb: loaded
[    0.362081] SCSI subsystem initialized
[    0.366785] usbcore: registered new interface driver usbfs
[    0.372468] usbcore: registered new interface driver hub
[    0.378053] usbcore: registered new device driver usb
[    0.385024] i2c i2c-0: IMX I2C adapter registered
[    0.389830] i2c i2c-0: can't use DMA
[    0.394338] i2c i2c-1: IMX I2C adapter registered
[    0.399141] i2c i2c-1: can't use DMA
[    0.403649] i2c i2c-2: IMX I2C adapter registered
[    0.408452] i2c i2c-2: can't use DMA
[    0.412235] Linux video capture interface: v2.00
[    0.417154] pps_core: LinuxPPS API ver. 1 registered
[    0.422207] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.431480] PTP clock support registered
[    0.436119] Advanced Linux Sound Architecture Driver Initialized.
[    0.444783] Bluetooth: Core ver 2.20
[    0.448510] NET: Registered protocol family 31
[    0.453041] Bluetooth: HCI device and connection manager initialized
[    0.459546] Bluetooth: HCI socket layer initialized
[    0.464540] Bluetooth: L2CAP socket layer initialized
[    0.469779] Bluetooth: SCO socket layer initialized
[    0.475927] cfg80211: Calling CRDA to update world regulatory domain
[    0.483790] clocksource: Switched to clocksource mxc_timer1
[    0.512511] NET: Registered protocol family 2
[    0.518616] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.525903] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.534677] TCP: Hash tables configured (established 8192 bind 8192)
[    0.541326] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.547649] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.554974] NET: Registered protocol family 1
[    0.560325] RPC: Registered named UNIX socket transport module.
[    0.566360] RPC: Registered udp transport module.
[    0.571153] RPC: Registered tcp transport module.
[    0.575962] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.583897] hw perfevents: Failed to parse /soc/pmu/interrupt-affinity[0]
[    0.590839] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    0.601578] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.621860] VFS: Disk quotas dquot_6.6.0
[    0.626237] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.638944] NFS: Registering the id_resolver key type
[    0.644296] Key type id_resolver registered
[    0.648571] Key type id_legacy registered
[    0.652804] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    0.660409] fuse init (API version 7.23)
[    0.671351] io scheduler noop registered
[    0.675400] io scheduler deadline registered
[    0.679822] io scheduler cfq registered (default)
[    0.685176] imx-weim 21b8000.weim: Driver registered.
[    0.807637] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.814026] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    0.820299] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.827283] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.833904] PCI: bus0: Fast back to back transfers disabled
[    0.853714] PCI: bus1: Fast back to back transfers disabled
[    0.859552] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.866463] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.873346] pci 0000:00:00.0: BAR 6: assigned [mem
0x01200000-0x0120ffff pref]
[    0.880685] pci 0000:01:00.0: BAR 0: assigned [mem
0x01100000-0x01101fff 64bit]
[    0.888158] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.893217] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.900681] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
[    0.907760] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.916043] backlight supply power not found, using dummy regulator
[    0.925893] imx-sdma 20ec000.sdma: Direct firmware load for
imx/sdma/sdma-imx6q.bin failed with error -2
[    0.935510] imx-sdma 20ec000.sdma: external firmware not found,
using ROM firmware
[    0.941269] imx-sdma 20ec000.sdma: initialized
[    0.943507] pfuze100-regulator 1-0008: Full layer: 1, Metal layer: 1
[    0.944228] pfuze100-regulator 1-0008: FAB: 0, FIN: 0
[    0.944236] pfuze100-regulator 1-0008: pfuze100 found.

[Hangs here]
