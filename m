From: linux@mniewoehner.de (Michael =?ISO-8859-1?Q?Niew=F6hner?=)
Date: Mon, 03 Oct 2016 15:08:13 +0200
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com> <57C41582.1030604@linux.intel.com>
 <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
Message-ID: <1475500093.2024.27.camel@mniewoehner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Di, 2016-09-20 at 23:12 +0200, Michael Niew?hner wrote:
> 
> 
> Hi guys,
> > 
> > 
> > > 
> > > 
> > > Hi All
> > > ?
> > > Adding Vivek Gautam.
> > > ?
> > > On 29 August 2016 at 16:35, Michael Niew?hner
> > <linux@mniewoehner.de>
> > > 
> > > 
> > > wrote:
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > > ?
> > > > > Hi Mathias,
> > > > > On Mo, 2016-08-29 at 13:59 +0300, Mathias Nyman wrote:
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > ?
> > > > > > > On 29.08.2016 10:28, Felipe Balbi wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > ?
> > > > > > > > > ?
> > > > > > > > > ?
> > > > > > > > > Hi,
> > > > > > > > > ?
> > > > > > > > > Michael Niew?hner <linux@mniewoehner.de> writes:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > ?
> > > > > > > > > > > ?
> > > > > > > > > > > [1.] One line summary of the problem:
> > > > > > > > > > > DWC3 USB 3.0 not working on Odroid-XU4 with
> > > > > > Exynos 5422
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > ?
> > > > > > > > > > > [2.] Full description of the problem/report:
> > > > > > > > > > > No usb 3.0 devices are being detected when
> > > > > > attached while USB
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 2.0
> > > > > > > > > > > devices work on the same port.
> > > > > > > > > > > USB 3.0 works after applying patches [9.1] and
> > > > > > [9.2], but
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > seems
> > > > > > > > > > > to be
> > > > > > > > > > > buggy. The usb hub is redetected every time an
> > > > > > usb device is
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > attached.
> > > > > > > > > ?
> > > > > > > > > dwc3 is host, which means it's actually XHCI :-)
> > > > > > > > > ?
> > > > > > > > > Adding Mathias
> > > > > > > > > ?
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > ?
> > > > > > > > > > > ?
> > > > > > > > > > > dmesg:
> > > > > > > > > > > [??192.287080] usb 3-1.2: USB disconnect, device
> > > > > > number 7
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > [??210.370699] hub 3-1:1.0: hub_ext_port_status
> > > > > > failed (err =
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > -71)
> > > > > > > ?
> > > > > > > Looks like the hub GetPortStatus request fails with
> > > > protocol
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > error.
> > > > > > > ?
> > > > > > > Reading xhci root hub port status is mostly just register
> > > > reads
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > and
> > > > > > > writes. It
> > > > > > > shouldn't include any actual transfers that could return
> > > > -EPROTO
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > ?
> > > > > > > So this is not the root hub? but a external or integrated
> > > > on your
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > board, right?
> > > > > > > ?
> > > > > > > The protocol error -71 is returned at transfer errors or
> > > > if
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > device
> > > > > > > stalled.
> > > > > > > ?
> > > > > > > Adding more xhci debugging options could show something:
> > > > > > > echo -n 'module xhci_hcd =p' >
> > > > > > > /sys/kernel/debug/dynamic_debug/control
> > > > > > > ?
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > ?
> > > > > > > > > ?
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > ?
> > > > > > > > > > > ?
> > > > > > > > > > > [9.] Other notes, patches, fixes, workarounds:
> > > > > > > > > > > [9.1] https://lkml.org/lkml/2014/4/28/234
> > > > > > > > > > > [9.2] https://lkml.org/lkml/2015/2/2/259
> > > > > > > ?
> > > > > > > The additional patches that makes things somehow work
> > > > involve
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > tuning
> > > > > > > the PHY,
> > > > > > > this is an area I'm not familiar with
> > > > > > > ?
> > > > > > > -Mathias
> > > > > > > ?
> > > > > ?
> > > > > ?
> > > > > I'm sorry, I should have said that this is the dmesg output
> > > with
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > > the
> > > > > patches applied. Without them there is no output at all when
> > > I
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > > attach
> > > > > an usb 3.0 device.
> > > > > ?
> > > > > Michael
> > > ?
> > > There are two dwc3 ports in the SoC : one for Gbit Ethernet
> > another
> > > 
> > > 
> > > one for on-board GL3521 USB 3.0 hub controller.
> > > ?
> > > 3.10.x kernel
> > > odroid at odroid:~$ lsusb -t
> > > /:??Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 5000M
> > > 
> > > 
> > > ?????|__ Port 1: Dev 2, If 0, Class=Vendor Specific Class,
> > > Driver=r8152, 5000M
> > > /:??Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 480M
> > > 
> > > 
> > > /:??Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 5000M
> > > 
> > > 
> > > ?????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
> > > /:??Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 480M
> > > 
> > > 
> > > ?????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> > > /:??Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p,
> > 12M
> > > 
> > > 
> > > /:??Bus 01.Port 1: Dev 1, Class=root_hub, Driver=s5p-ehci/3p,
> > 480M
> > > 
> > > 
> > > ?
> > > 4.x kernel
> > > odroid at odroid:~$ lsusb -t
> > > /:??Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 5000M
> > > 
> > > 
> > > /:??Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 480M
> > > 
> > > 
> > > ?????|__ Port 1: Dev 2, If 0, Class=Vendor Specific Class,
> > > Driver=r8152, 480M
> > > /:??Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 5000M
> > > 
> > > 
> > > ?????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
> > > ?????????|__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-
> > > storage, 5000M
> > > ?????????|__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-
> > > storage, 5000M
> > > /:??Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p,
> > 480M
> > > 
> > > 
> > > ?????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> > > /:??Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p,
> > 12M
> > > 
> > > 
> > > /:??Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p,
> > 480M
> > > 
> > > 
> > > ?
> > > I fell that Ethernet driver r8152 is not getting registered to
> > > xhci-hcd to bus port 06
> > > which lead to other ports to miss configure, some time the
> > Ethernet
> > > 
> > > 
> > > port get register to bus port 04
> > > ?
> > > Their is also a possibility that all the port are not getting
> > proper
> > > 
> > > 
> > > power from the S2MPS11 PMIC
> > > and possible some reset of the phy is needed to reconfigure the
> > > exynos
> > > USB HSIC controller.
> > > ?
> > > Best Regards
> > > -Anand Moon
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> > > samsung-soc" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at??http://vger.kernel.org/majordomo-
> > info.html
> ?
> ?
> today I've tested v4.8-rc7 (without the patches above). The USB 3.0
> ports have stopped working completely for me. Neither USB 2.0 nor USB
> 3.0 are being detected. The Ethernet port does not work, too. The
> USB-2.0-only Port works.
> ?
> There are some failures in the dmesg log:
> ...
> [???15.096251] 12100000.phy supply vbus not found, using dummy
> regulator
> ...
> [???19.642578] usb usb5-port1: connect-debounce failed
> ?
> ?
> dmesg:


looks like I forgot to append the dmesg in my last mail. Sorry about
that.
The problem is also present in v4.8. Let me know if you need more
information.

Michael


dmesg v4.8 without any additional patches:

[????0.000000] Booting Linux on physical CPU 0x100
[????0.000000] Linux version 4.8.0 (c0d3 at z3r0) (gcc version 5.3.1
20160412 (Linaro GCC 5.3-2016.05) ) #3 SMP Mon Oct 3 14:11:40 CEST 2016
[????0.000000] CPU: ARMv7 Processor [410fc073] revision 3 (ARMv7),
cr=10c5387d
[????0.000000] CPU: div instructions available: patching division code
[????0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[????0.000000] OF: fdt:Machine model: Hardkernel Odroid XU4
[????0.000000] Reserved memory: created DMA memory pool at 0xbe200000,
size 8 MiB
[????0.000000] OF: reserved mem: initialized node region_mfc_right,
compatible id shared-dma-pool
[????0.000000] Reserved memory: created DMA memory pool at 0xbd200000,
size 16 MiB
[????0.000000] OF: reserved mem: initialized node region_mfc_left,
compatible id shared-dma-pool
[????0.000000] Memory policy: Data cache writealloc
[????0.000000] Samsung CPU ID: 0xe5422001
[????0.000000] On node 0 totalpages: 512512
[????0.000000] free_area_init_node: node 0, pgdat c0c81840,
node_mem_map eee52000
[????0.000000]???Normal zone: 1728 pages used for memmap
[????0.000000]???Normal zone: 0 pages reserved
[????0.000000]???Normal zone: 196608 pages, LIFO batch:31
[????0.000000]???HighMem zone: 315904 pages, LIFO batch:31
[????0.000000] Running under secure firmware.
[????0.000000] percpu: Embedded 15 pages/cpu @eeda1000 s30272 r8192
d22976 u61440
[????0.000000] pcpu-alloc: s30272 r8192 d22976 u61440 alloc=15*4096
[????0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6
[0] 7?
[????0.000000] Built 1 zonelists in Zone order, mobility grouping
on.??Total pages: 510784
[????0.000000] Kernel command line: console=ttySAC2,115200n8
root=/dev/mmcblk1p2 rootfstype=ext4 rootwait earlyprintk debug
[????0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[????0.000000] Dentry cache hash table entries: 131072 (order: 7,
524288 bytes)
[????0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[????0.000000] Memory: 2018124K/2050048K available (7168K kernel code,
618K rwdata, 2064K rodata, 1024K init, 375K bss, 31924K reserved, 0K
cma-reserved, 1263616K highmem)
[????0.000000] Virtual kernel memory layout:
????vector??: 0xffff0000 - 0xffff1000???(???4 kB)
????fixmap??: 0xffc00000 - 0xfff00000???(3072 kB)
????vmalloc : 0xf0800000 - 0xff800000???( 240 MB)
????lowmem??: 0xc0000000 - 0xf0000000???( 768 MB)
????pkmap???: 0xbfe00000 - 0xc0000000???(???2 MB)
????modules : 0xbf000000 - 0xbfe00000???(??14 MB)
??????.text : 0xc0008000 - 0xc0800000???(8160 kB)
??????.init : 0xc0b00000 - 0xc0c00000???(1024 kB)
??????.data : 0xc0c00000 - 0xc0c9aafc???( 619 kB)
???????.bss : 0xc0c9c000 - 0xc0cf9d04???( 376 kB)
[????0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8,
Nodes=1
[????0.000000] Hierarchical RCU implementation.
[????0.000000]??Build-time adjustment of leaf fanout to 32.
[????0.000000]??RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=8.
[????0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32,
nr_cpu_ids=8
[????0.000000] NR_IRQS:16 nr_irqs:16 16
[????0.000000] Switching to timer-based delay loop, resolution 41ns
[????0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635851949 ns
[????0.000007] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
every 89478484971ns
[????0.001695] Console: colour dummy device 80x30
[????0.001738] Calibrating delay loop (skipped), value calculated using
timer frequency.. 48.00 BogoMIPS (lpj=240000)
[????0.001758] pid_max: default: 32768 minimum: 301
[????0.001911] Security Framework initialized
[????0.001928] Yama: becoming mindful.
[????0.001960] AppArmor: AppArmor disabled by boot time parameter
[????0.002017] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes)
[????0.002033] Mountpoint-cache hash table entries: 2048 (order: 1,
8192 bytes)
[????0.003077] CPU: Testing write buffer coherency: ok
[????0.003125] ftrace: allocating 25558 entries in 75 pages
[????0.058307] CPU0: update cpu_capacity 448
[????0.058329] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
[????0.058499] Setting up static identity map for 0x40100000 -
0x40100058
[????0.059140] ARM CCI driver probed
[????0.059353] Exynos MCPM support installed
[????0.063820] CPU1: update cpu_capacity 448
[????0.063828] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
[????0.064893] CPU2: update cpu_capacity 448
[????0.064901] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
[????0.065969] CPU3: update cpu_capacity 448
[????0.065977] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
[????0.066934] CPU4: update cpu_capacity 1535
[????0.066942] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
[????0.067971] CPU5: update cpu_capacity 1535
[????0.067978] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
[????0.068967] CPU6: update cpu_capacity 1535
[????0.068974] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
[????0.069977] CPU7: update cpu_capacity 1535
[????0.069984] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
[????0.070124] Brought up 8 CPUs
[????0.070187] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[????0.070198] CPU: WARNING: CPU(s) started in wrong/inconsistent modes
(primary CPU mode 0x1a)
[????0.070207] CPU: This may indicate a broken bootloader or firmware.
[????0.072308] devtmpfs: initialized
[????0.097643] VFP support v0.3: implementor 41 architecture 2 part 30
variant 7 rev 3
[????0.098142] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[????0.098457] pinctrl core: initialized pinctrl subsystem
[????0.101390] NET: Registered protocol family 16
[????0.102209] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[????0.149996] cpuidle: using governor ladder
[????0.189985] cpuidle: using governor menu
[????0.198708] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
watchpoint registers.
[????0.198724] hw-breakpoint: maximum watchpoint size is 8 bytes.
[????0.199088] Serial: AMBA PL011 UART driver
[????0.208742] iommu: Adding device 11000000.codec to group 0
[????0.244099] iommu: Adding device 14450000.mixer to group 1
[????0.244643] iommu: Adding device 11c00000.rotator to group 2
[????0.254076] iommu: Adding device 13e00000.video-scaler to group 3
[????0.254594] iommu: Adding device 13e10000.video-scaler to group 4
[????0.255107] iommu: Adding device 11f50000.jpeg to group 5
[????0.255613] iommu: Adding device 11f60000.jpeg to group 6
[????0.256003] EXYNOS5420 PMU initialized
[????0.312565] SCSI subsystem initialized
[????0.312938] usbcore: registered new interface driver usbfs
[????0.313031] usbcore: registered new interface driver hub
[????0.313226] usbcore: registered new device driver usb
[????0.314692] s3c-i2c 12c80000.i2c: slave address 0x00
[????0.314712] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[????0.315240] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter
[????0.315709] media: Linux media interface: v0.10
[????0.315777] Linux video capture interface: v2.00
[????0.315874] pps_core: LinuxPPS API ver. 1 registered
[????0.315885] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[????0.315914] PTP clock support registered
[????0.317980] clocksource: Switched to clocksource mct-frc
[????0.385905] VFS: Disk quotas dquot_6.6.0
[????0.385987] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
[????0.405341] NET: Registered protocol family 2
[????0.406054] TCP established hash table entries: 8192 (order: 3,
32768 bytes)
[????0.406137] TCP bind hash table entries: 8192 (order: 4, 65536
bytes)
[????0.406295] TCP: Hash tables configured (established 8192 bind 8192)
[????0.406360] UDP hash table entries: 512 (order: 2, 16384 bytes)
[????0.406402] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[????0.406639] NET: Registered protocol family 1
[????0.410133] futex hash table entries: 2048 (order: 5, 131072 bytes)
[????0.410271] audit: initializing netlink subsys (disabled)
[????0.410335] audit: type=2000 audit(0.380:1): initialized
[????0.411455] workingset: timestamp_bits=14 max_order=19
bucket_order=5
[????0.422219] zbud: loaded
[????0.428206] Key type asymmetric registered
[????0.428281] bounce: pool size: 64 pages
[????0.428544] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 247)
[????0.428787] io scheduler noop registered
[????0.428801] io scheduler deadline registered (default)
[????0.429058] io scheduler cfq registered
[????0.439042] dma-pl330 121a0000.pdma: Loaded driver for PL330 DMAC-
241330
[????0.439060] dma-pl330 121a0000.pdma:?????????DBUFF-32x4bytes
Num_Chans-8 Num_Peri-32 Num_Events-32
[????0.443549] dma-pl330 121b0000.pdma: Loaded driver for PL330 DMAC-
241330
[????0.443568] dma-pl330 121b0000.pdma:?????????DBUFF-32x4bytes
Num_Chans-8 Num_Peri-32 Num_Events-32
[????0.444825] dma-pl330 10800000.mdma: Loaded driver for PL330 DMAC-
241330
[????0.444842] dma-pl330 10800000.mdma:?????????DBUFF-64x8bytes
Num_Chans-8 Num_Peri-1 Num_Events-32
[????0.446009] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[????0.448993] Serial: AMBA driver
[????0.449384] 12c00000.serial: ttySAC0 at MMIO 0x12c00000 (irq = 76,
base_baud = 0) is a S3C6400/10
[????0.449890] 12c10000.serial: ttySAC1 at MMIO 0x12c10000 (irq = 77,
base_baud = 0) is a S3C6400/10
[????0.450386] 12c20000.serial: ttySAC2 at MMIO 0x12c20000 (irq = 78,
base_baud = 0) is a S3C6400/10
[????1.007347] random: fast init done
[????1.291220] console [ttySAC2] enabled
[????1.295362] 12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq = 79,
base_baud = 0) is a S3C6400/10
[????1.304951] [drm] Initialized drm 1.1.0 20060810
[????1.311440] exynos-hdmi 14530000.hdmi: Failed to get supply 'vdd':
-517
[????1.318159] exynos-rot 11c00000.rotator: The exynos rotator is
probed successfully
[????1.324687] exynos-drm-gsc 13e00000.video-scaler: failed to get
system register.
[????1.331876] exynos-drm-gsc 13e00000.video-scaler: drm gsc registered
successfully.
[????1.339273] exynos-drm-gsc 13e10000.video-scaler: failed to get
system register.
[????1.346771] exynos-drm-gsc 13e10000.video-scaler: drm gsc registered
successfully.
[????1.354919] exynos-drm-ipp exynos-drm-ipp: drm ipp registered
successfully.
[????1.367209] libphy: Fixed MDIO Bus: probed
[????1.370337] usbcore: registered new interface driver usb-storage
[????1.376279] mousedev: PS/2 mouse device common for all mice
[????1.400256] vdd_ldo9: Bringing 3300000uV into 3000000-3000000uV
[????1.413855] vddq_mmc2: Bringing 3300000uV into 2800000-2800000uV
[????1.423183] vdd_ldo15: Bringing 3300000uV into 3100000-3100000uV
[????1.436801] vdd_sd: Bringing 3300000uV into 2800000-2800000uV
[????1.499343] s5m-rtc s2mps14-rtc: rtc core: registered s5m-rtc as
rtc0
[????1.512014] exynos-tmu 10060000.tmu: More trip points than supported
by this TMU.
[????1.518056] exynos-tmu 10060000.tmu: 2 trip points should be
configured in polling mode.
[????1.543169] sdhci: Secure Digital Host Controller Interface driver
[????1.547861] sdhci: Copyright(c) Pierre Ossman
[????1.552447] Synopsys Designware Multimedia Card Interface Driver
[????1.558827] dwmmc_exynos 12200000.mmc: IDMAC supports 32-bit address
mode.
[????1.565036] dwmmc_exynos 12200000.mmc: Using internal DMA
controller.
[????1.571462] dwmmc_exynos 12200000.mmc: Version ID is 250a
[????1.576835] dwmmc_exynos 12200000.mmc: DW MMC controller at irq
91,64 bit host data width,64 deep fifo
[????1.586254] dwmmc_exynos 12200000.mmc: Got CD GPIO
[????1.590920] dwmmc_exynos 12200000.mmc: allocated mmc-pwrseq
[????1.628648] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req
400000Hz, actual 396825HZ div = 63)
[????1.658185] dwmmc_exynos 12200000.mmc: 1 slots initialized
[????1.662422] dwmmc_exynos 12220000.mmc: IDMAC supports 32-bit address
mode.
[????1.669071] dwmmc_exynos 12220000.mmc: Using internal DMA
controller.
[????1.675448] dwmmc_exynos 12220000.mmc: Version ID is 250a
[????1.680869] dwmmc_exynos 12220000.mmc: DW MMC controller at irq
92,64 bit host data width,64 deep fifo
[????1.718450] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
400000Hz, actual 396825HZ div = 63)
[????1.748015] dwmmc_exynos 12220000.mmc: 1 slots initialized
[????1.752198] sdhci-pltfm: SDHCI platform and OF driver helper
[????1.758808] ledtrig-cpu: registered to indicate activity on CPUs
[????1.763667] hidraw: raw HID events driver (C) Jiri Kosina
[????1.769408] usbcore: registered new interface driver usbhid
[????1.774539] usbhid: USB HID core driver
[????1.779758] exynos-audss-clk 3810000.audss-clock-controller: setup
completed
[????1.797575] exynos-nocp: new NoC Probe device registered:
10ca1000.nocp
[????1.802874] exynos-nocp: new NoC Probe device registered:
10ca1400.nocp
[????1.807126] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
50000000Hz, actual 50000000HZ div = 0)
[????1.807273] mmc1: new high speed SDHC card at address 59b4
[????1.807917] mmcblk1: mmc1:59b4 USDU1 14.7 GiB?
[????1.808982]??mmcblk1: p1 p2
[????1.831801] exynos-nocp: new NoC Probe device registered:
10ca1800.nocp
[????1.838398] exynos-nocp: new NoC Probe device registered:
10ca1c00.nocp
[????1.846409] NET: Registered protocol family 10
[????1.850110] mip6: Mobile IPv6
[????1.852315] NET: Registered protocol family 17
[????1.856737] mpls_gso: MPLS GSO support
[????1.860858] ThumbEE CPU extension supported.
[????1.864710] Registering SWP/SWPB emulation handler
[????1.870156] registered taskstats version 1
[????1.873593] zswap: loaded using pool lzo/zbud
[????1.882872] [drm] Exynos DRM: using 14450000.mixer device for DMA
mapping operations
[????1.889454] exynos-drm exynos-drm: bound 14450000.mixer (ops
0xc086e904)
[????1.896004] exynos-drm exynos-drm: bound 14530000.hdmi (ops
0xc086ead4)
[????1.902413] [drm] Supports vblank timestamp caching Rev 2
(21.10.2013).
[????1.908997] [drm] No driver support for vblank timestamp query.
[????1.914979] [drm] Initialized exynos 1.0.0 20110530 on minor 0
[????1.921516] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[????1.926279] s3c-rtc 101e0000.rtc: warning: invalid RTC value so
initializing it
[????1.933578] rtc rtc1: invalid alarm value: 1900-1-2 0:0:0
[????1.939095] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc1
[????1.946585] exynos-bus: new bus device registered: soc:bus_wcore (
84000 KHz ~ 400000 KHz)
[????1.954159] exynos-bus: new bus device registered: soc:bus_noc (
67000 KHz ~ 100000 KHz)
[????1.962043] exynos-bus: new bus device registered: soc:bus_fsys_apb
(100000 KHz ~ 200000 KHz)
[????1.970370] exynos-bus: new bus device registered: soc:bus_fsys
(100000 KHz ~ 200000 KHz)
[????1.978708] exynos-bus: new bus device registered: soc:bus_fsys2 (
75000 KHz ~ 150000 KHz)
[????1.987052] exynos-bus: new bus device registered: soc:bus_mfc (
96000 KHz ~ 333000 KHz)
[????1.995093] exynos-bus: new bus device registered: soc:bus_gen (
89000 KHz ~ 267000 KHz)
[????2.003458] exynos-bus: new bus device registered: soc:bus_peri (
67000 KHz ~??67000 KHz)
[????2.011853] devfreq soc:bus_wcore: Couldn't update frequency
transition information.
[????2.012120] exynos-bus: new bus device registered: soc:bus_g2d (
84000 KHz ~ 333000 KHz)
[????2.012845] exynos-bus: new bus device registered: soc:bus_g2d_acp (
67000 KHz ~ 267000 KHz)
[????2.013561] exynos-bus: new bus device registered: soc:bus_jpeg (
75000 KHz ~ 300000 KHz)
[????2.014273] exynos-bus: new bus device registered: soc:bus_jpeg_apb
( 84000 KHz ~ 167000 KHz)
[????2.014866] exynos-bus: new bus device registered:
soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
[????2.015523] exynos-bus: new bus device registered: soc:bus_disp1
(120000 KHz ~ 300000 KHz)
[????2.016166] exynos-bus: new bus device registered:
soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
[????2.016941] exynos-bus: new bus device registered: soc:bus_mscl (
84000 KHz ~ 400000 KHz)
[????2.019383] Power domain power-domain at 10044120 disable failed
[????2.026352] s5m-rtc s2mps14-rtc: setting system clock to 2000-01-01
00:00:04 UTC (946684804)
[????2.044135] PM: Hibernation image not present or could not be
loaded.
[????2.113332] EXT4-fs (mmcblk1p2): mounted filesystem with ordered
data mode. Opts: (null)
[????2.120019] VFS: Mounted root (ext4 filesystem) readonly on device
179:2.
[????2.127364] Freeing unused kernel memory: 1024K (c0b00000 -
c0c00000)
[????2.359928] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpuset of
type cgroup with options cpuset.
[????2.419442] systemd[1]: Mounting cgroup to
/sys/fs/cgroup/cpu,cpuacct of type cgroup with options cpu,cpuacct.
[????2.428599] systemd[1]: Mounting cgroup to /sys/fs/cgroup/blkio of
type cgroup with options blkio.
[????2.438504] systemd[1]: Mounting cgroup to /sys/fs/cgroup/memory of
type cgroup with options memory.
[????2.452714] systemd[1]: Mounting cgroup to /sys/fs/cgroup/devices of
type cgroup with options devices.
[????2.461081] systemd[1]: Mounting cgroup to /sys/fs/cgroup/freezer of
type cgroup with options freezer.
[????2.470341] systemd[1]: Mounting cgroup to
/sys/fs/cgroup/net_cls,net_prio of type cgroup with options
net_cls,net_prio.
[????2.481222] systemd[1]: Mounting cgroup to /sys/fs/cgroup/perf_event
of type cgroup with options perf_event.
[????2.491343] systemd[1]: systemd 215 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP
-APPARMOR)
[????2.503894] systemd[1]: Detected architecture 'arm'.
[????2.733937] systemd-getty-generator[111]: Automatically adding
serial getty for /dev/ttySAC2.
[????2.738699] systemd-fstab-generator[112]: Parsing /etc/fstab
[????2.744149] systemd-rc-local-generator[120]: Automatically adding
rc-local.service.
[????2.745372] systemd-default-display-manager-generator[114]: No
/etc/X11/default-display-manager file, nothing to generate
[????2.746322] systemd-fstab-generator[112]: Found entry
what=/dev/mmcblk1p2 where=/ type=ext4
[????2.813116] systemd-gpt-auto-generator[117]: Root device
/dev/mmcblk1.
[????2.813603] systemd-sysv-generator[116]: Looking for unit files in
(higher priority first):
[????2.813612] systemd-sysv-generator[116]:?????/etc/systemd/system
[????2.813620] systemd-sysv-generator[116]:?????/run/systemd/system
[????2.813628] systemd-sysv-
generator[116]:?????/usr/local/lib/systemd/system
[????2.813635] systemd-sysv-generator[116]:?????/lib/systemd/system
[????2.813642] systemd-sysv-generator[116]:?????/usr/lib/systemd/system
[????2.813681] systemd-sysv-generator[116]: Looking for SysV init
scripts in:
[????2.813689] systemd-sysv-generator[116]:?????/etc/init.d
[????2.813699] systemd-sysv-generator[116]: Looking for SysV rcN.d
links in:
[????2.813706] systemd-sysv-generator[116]:?????/etc
[????2.815816] systemd-fstab-generator[112]: Found entry
what=/dev/mmcblk1p1 where=/boot type=vfat
[????2.819599] systemd-fstab-generator[112]: Checking was requested for
/dev/mmcblk1p1, but fsck.vfat does not exist: No such file or directory
[????2.874868] systemd-sysv-ge: 77 output lines suppressed due to
ratelimiting
[????2.959658] systemd-gpt-auto-generator[117]: Not a GPT partition
table, ignoring.
[????3.832303] systemd-journald[135]: Fixed max_use=98.5M
max_size=12.3M min_size=4.0M keep_free=147.8M
[????3.845615] systemd-journald[135]: Reserving 22435 entries in hash
table.
[????3.852075] systemd-journald[135]: Vacuuming...
[????3.855454] systemd-journald[135]: Vacuuming done, freed 0 bytes
[????3.861956] systemd-journald[135]: Flushing /dev/kmsg...
[????3.871445] systemd-journald[135]: Compressed data object 537 -> 288
[????3.899706] systemd-journald[135]: systemd-journald running as pid
135
[????4.454812] systemd-udevd[147]: starting version 215
[????4.611192] s5p-secss 10830000.sss: s5p-sss driver registered
[????4.626630] 12100000.phy supply vbus not found, using dummy
regulator
[????4.631925] 12100000.phy supply vbus-boost not found, using dummy
regulator
[????4.633739] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
Driver
[????4.638239] ehci-exynos: EHCI EXYNOS driver
[????4.642228] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[????4.646782] ohci-exynos: OHCI EXYNOS driver
[????4.660779] 12130000.phy supply vbus not found, using dummy
regulator
[????4.669297] exynos-ohci 12120000.usb: USB Host Controller
[????4.669734] exynos-ehci 12110000.usb: EHCI Host Controller
[????4.670063] exynos-ehci 12110000.usb: new USB bus registered,
assigned bus number 1
[????4.670250] exynos-ehci 12110000.usb: irq 89, io mem 0x12110000
[????4.693595] exynos-ohci 12120000.usb: new USB bus registered,
assigned bus number 2
[????4.698079] exynos-ehci 12110000.usb: USB 2.0 started, EHCI 1.00
[????4.698464] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002
[????4.698472] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[????4.698481] usb usb1: Product: EHCI Host Controller
[????4.698489] usb usb1: Manufacturer: Linux 4.8.0 ehci_hcd
[????4.698496] usb usb1: SerialNumber: 12110000.usb
[????4.699299] hub 1-0:1.0: USB hub found
[????4.699350] hub 1-0:1.0: 3 ports detected
[????4.742843] exynos-ohci 12120000.usb: irq 89, io mem 0x12120000
[????4.822232] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0001
[????4.827543] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[????4.834815] usb usb2: Product: USB Host Controller
[????4.839569] usb usb2: Manufacturer: Linux 4.8.0 ohci_hcd
[????4.839580] usb usb2: SerialNumber: 12120000.usb
[????4.840406] hub 2-0:1.0: USB hub found
[????4.840468] hub 2-0:1.0: 3 ports detected
[????4.841589] 12500000.phy supply vbus not found, using dummy
regulator
[????4.841673] 12500000.phy supply vbus-boost not found, using dummy
regulator
[????4.842135] exynos-dwc3 soc:usb3-0: no suspend clk specified
[????4.843822] usb_phy_generic.0.auto supply vcc not found, using dummy
regulator
[????4.844425] usb_phy_generic.1.auto supply vcc not found, using dummy
regulator
[????4.845346] exynos-dwc3 soc:usb3-1: no suspend clk specified
[????4.848262] usb_phy_generic.2.auto supply vcc not found, using dummy
regulator
[????4.848573] usb_phy_generic.3.auto supply vcc not found, using dummy
regulator
[????4.873852] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[????4.874040] xhci-hcd xhci-hcd.4.auto: new USB bus registered,
assigned bus number 3
[????4.874254] xhci-hcd xhci-hcd.4.auto: hcc params 0x0220f04c hci
version 0x100 quirks 0x00010010
[????4.874296] xhci-hcd xhci-hcd.4.auto: irq 135, io mem 0x12000000
[????4.874566] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002
[????4.874571] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[????4.874575] usb usb3: Product: xHCI Host Controller
[????4.874579] usb usb3: Manufacturer: Linux 4.8.0 xhci-hcd
[????4.874583] usb usb3: SerialNumber: xhci-hcd.4.auto
[????4.875065] hub 3-0:1.0: USB hub found
[????4.875105] hub 3-0:1.0: 1 port detected
[????4.875475] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[????4.875623] xhci-hcd xhci-hcd.4.auto: new USB bus registered,
assigned bus number 4
[????4.875743] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[????4.875926] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003
[????4.875930] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[????4.875934] usb usb4: Product: xHCI Host Controller
[????4.875938] usb usb4: Manufacturer: Linux 4.8.0 xhci-hcd
[????4.875942] usb usb4: SerialNumber: xhci-hcd.4.auto
[????4.876431] hub 4-0:1.0: USB hub found
[????4.876471] hub 4-0:1.0: 1 port detected
[????4.876897] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[????4.877063] xhci-hcd xhci-hcd.5.auto: new USB bus registered,
assigned bus number 5
[????4.877266] xhci-hcd xhci-hcd.5.auto: hcc params 0x0220f04c hci
version 0x100 quirks 0x00010010
[????4.877299] xhci-hcd xhci-hcd.5.auto: irq 136, io mem 0x12400000
[????4.877525] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0002
[????4.877530] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[????4.877534] usb usb5: Product: xHCI Host Controller
[????4.877538] usb usb5: Manufacturer: Linux 4.8.0 xhci-hcd
[????4.877541] usb usb5: SerialNumber: xhci-hcd.5.auto
[????4.878099] hub 5-0:1.0: USB hub found
[????4.878138] hub 5-0:1.0: 1 port detected
[????4.878494] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[????4.878654] xhci-hcd xhci-hcd.5.auto: new USB bus registered,
assigned bus number 6
[????4.878769] usb usb6: We don't know the algorithms for LPM for this
host, disabling LPM.
[????4.878947] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0003
[????4.878952] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[????4.878955] usb usb6: Product: xHCI Host Controller
[????4.878959] usb usb6: Manufacturer: Linux 4.8.0 xhci-hcd
[????4.878963] usb usb6: SerialNumber: xhci-hcd.5.auto
[????4.879480] hub 6-0:1.0: USB hub found
[????4.879520] hub 6-0:1.0: 1 port detected
[????5.304287] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-
241330
[????5.309497] dma-pl330 3880000.adma:??DBUFF-4x8bytes Num_Chans-6
Num_Peri-16 Num_Events-6
[????5.459652] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
[????5.673544] FAT-fs (mmcblk1p1): utf8 is not a recommended IO charset
for FAT filesystems, filesystem will be case sensitive!
[????5.701124] FAT-fs (mmcblk1p1): Volume was not properly unmounted.
Some data may be corrupt. Please run fsck.
[????6.087658] systemd-journald[135]: Received request to flush runtime
journal from PID 1
[????6.095519] systemd-journald[135]: Vacuuming...
[????6.100071] systemd-journald[135]: Vacuuming done, freed 0 bytes
[????7.335312] RPC: Registered named UNIX socket transport module.
[????7.339802] RPC: Registered udp transport module.
[????7.344429] RPC: Registered tcp transport module.
[????7.349165] RPC: Registered tcp NFSv4.1 backchannel transport
module.
[????7.370961] FS-Cache: Loaded
[????7.406152] FS-Cache: Netfs 'nfs' registered for caching
[????7.453960] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[????8.160157] random: crng init done
[????9.170682] usb usb5-port1: connect-debounce failed
[????9.170698] usb usb3-port1: connect-debounce failed
