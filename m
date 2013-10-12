From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 17:18:06 -0700
Subject: [PATCH 00/11] ARM: OMAP2+: CM cleanup series
In-Reply-To: <20131012000942.GH29913@atomide.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <20131012000942.GH29913@atomide.com>
Message-ID: <20131012001805.GI29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131011 17:18]:
> * Tero Kristo <t-kristo@ti.com> [131011 09:24]:
> > 
> > If someone could verify the omap2 changes, that would be nice.
> 
> Seems to boot on my n800 just fine, dmesg below.

Sorry that was the log without these patches, still boots
fine with the patches too though. Bootlog with your
patches below, at least now you can diff them after removing
the time stamps :)

Regards,

Tony


[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.12.0-rc4-00061-gb99884a (tmlind at muffinssi) (gcc version 4.3.5 (Debian 4.3.5-4) ) #247 Fri Oct 11 17:14:37 PDT 2013
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387d
[    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Nokia N800
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c075891c, node_mem_map c0cb9000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP2420
[    0.000000] 
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 rootwait console=ttyO2,115200 earlyprintk ignore_loglevel
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 116864K/131072K available (5069K kernel code, 344K rwdata, 1812K rodata, 271K init, 5489K bss, 14208K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06c0700   (6882 kB)
[    0.000000]       .init : 0xc06c1000 - 0xc0704ddc   ( 272 kB)
[    0.000000]       .data : 0xc0706000 - 0xc075c200   ( 345 kB)
[    0.000000]        .bss : 0xc075c200 - 0xc0cb8808   (5490 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] omap2_sync32k_clocksource_init: failed to get counter_32k resource
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
[    0.000000] hw-breakpoint: CPUID feature registers not supported. Assuming v6 debug is present.
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.070000] Calibrating delay loop... 217.49 BogoMIPS (lpj=1087488)
[    0.150000] pid_max: default: 32768 minimum: 301
[    0.150000] Security Framework initialized
[    0.160000] Mount-cache hash table entries: 512
[    0.170000] CPU: Testing write buffer coherency: ok
[    0.180000] Setting up static identity map for 0xc04d3618 - 0xc04d3688
[    0.210000] VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
[    0.260000] pinctrl core: initialized pinctrl subsystem
[    0.280000] regulator-dummy: no parameters
[    0.290000] NET: Registered protocol family 16
[    0.300000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.310000] omap-gpmc omap-gpmc: GPMC revision 2.0
[    0.340000] omap_gpio omap_gpio.0: Could not get gpio dbck
[    0.350000] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.360000] OMAP GPIO hardware version 1.8
[    0.360000] omap_gpio omap_gpio.1: Could not get gpio dbck
[    0.370000] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.380000] omap_gpio omap_gpio.2: Could not get gpio dbck
[    0.390000] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.400000] omap_gpio omap_gpio.3: Could not get gpio dbck
[    0.410000] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.440000] omap_mux_init: Add partition: #1: core, flags: b
[    0.500000]  mmci-omap.0: alias fck already exists
[    0.530000] TUSB 6010
[    0.530000] hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
[    0.540000] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.590000] OMAP DMA hardware revision 2.0
[    0.600000] Missing cpus node, bailing out
[    0.830000] bio: create slab <bio-0> at 0
[    1.100000] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    1.120000] SCSI subsystem initialized
[    1.130000] usbcore: registered new interface driver usbfs
[    1.140000] usbcore: registered new interface driver hub
[    1.140000] usbcore: registered new device driver usb
[    1.170000] omap_i2c omap_i2c.1: bus 1 rev3.3 at 400 kHz
[    1.180000] omap_i2c omap_i2c.2: bus 2 rev3.3 at 400 kHz
[    1.560000] NET: Registered protocol family 2
[    1.570000] TCP established hash table entries: 1024 (order: 1, 8192 bytes)
[    1.570000] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    1.580000] TCP: Hash tables configured (established 1024 bind 1024)
[    1.590000] TCP: reno registered
[    1.590000] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.600000] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.610000] NET: Registered protocol family 1
[    1.620000] RPC: Registered named UNIX socket transport module.
[    1.620000] RPC: Registered udp transport module.
[    1.630000] RPC: Registered tcp transport module.
[    1.630000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.650000] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.660000] CPU PMU: probing PMU on CPU 0
[    1.660000] hw perfevents: enabled with v6 PMU driver, 3 counters available
[    2.220000] VFS: Disk quotas dquot_6.5.2
[    2.220000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.240000] NFS: Registering the id_resolver key type
[    2.240000] Key type id_resolver registered
[    2.250000] Key type id_legacy registered
[    2.250000] jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
[    2.260000] msgmni has been set to 228
[    2.280000] io scheduler noop registered
[    2.280000] io scheduler deadline registered
[    2.290000] io scheduler cfq registered (default)
[    2.300000] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.330000] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88, base_baud = 3000000) is a OMAP UART0
[    2.340000] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
[    2.360000] omap_uart.2: ttyO2 at MMIO 0x4806e000 (irq = 90, base_baud = 3000000) is a OMAP UART2
[    2.370000] console [ttyO2] enabled, bootconsole disabled
[    2.370000] console [ttyO2] enabled, bootconsole disabled
[    2.390000] omap_rng omap_rng: OMAP Random Number Generator ver. 40
[    2.480000] brd: module loaded
[    2.530000] loop: module loaded
[    2.540000] Menelaus rev 2.2
[    2.580000] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.590000] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base c88c0000, freq 54 MHz
[    2.600000] OneNAND Manufacturer: Samsung (0xec)
[    2.600000] Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
[    2.610000] OneNAND version = 0x0011
[    2.610000] Chip support all block unlock
[    2.620000] onenand_wait: controller error! state 15 ctrl 0x0400 intr 0x8000
[    2.630000] Scanning device for bad blocks
[    2.880000] Creating 5 MTD partitions on "omap2-onenand":
[    2.890000] 0x000000000000-0x000000020000 : "bootloader"
[    2.910000] 0x000000020000-0x000000080000 : "config"
[    2.930000] 0x000000080000-0x000000280000 : "kernel"
[    2.940000] 0x000000280000-0x000000680000 : "initfs"
[    2.960000] 0x000000680000-0x000010000000 : "rootfs"
[    3.010000] omap-dma-engine omap-dma-engine: allocating channel for 44
[    3.020000] omap-dma-engine omap-dma-engine: allocating channel for 43
[    3.040000] usbcore: registered new interface driver asix
[    3.050000] usbcore: registered new interface driver ax88179_178a
[    3.060000] usbcore: registered new interface driver cdc_ether
[    3.070000] usbcore: registered new interface driver r815x
[    3.080000] usbcore: registered new interface driver smsc95xx
[    3.080000] usbcore: registered new interface driver net1080
[    3.090000] usbcore: registered new interface driver cdc_subset
[    3.100000] usbcore: registered new interface driver zaurus
[    3.110000] usbcore: registered new interface driver cdc_ncm
[    3.120000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.130000] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
[    3.130000] ehci-omap: OMAP-EHCI Host Controller driver
[    3.140000] usbcore: registered new interface driver cdc_wdm
[    3.150000] usbcore: registered new interface driver usb-storage
[    3.160000] usbcore: registered new interface driver usbtest
[    3.190000] tusb: prcm2.0 int2.0 gpio3.0 dma3.0 dieid2 rev3.1
[    3.190000] drivers/usb/musb/tusb6010.c tusb_musb_disable: dma still active
[    3.200000] musb-hdrc: ConfigData=0x06 (UTMI-8, dyn FIFOs, SoftConn)
[    3.210000] musb-hdrc: MHDRC RTL version 1.400 
[    3.210000] musb-hdrc: setup fifo_mode 4
[    3.220000] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    3.220000] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[    3.240000] musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 1
[    3.240000] musb-hdrc musb-hdrc.0.auto: supports USB remote wakeup
[    3.260000] usb usb1: default language 0x0409
[    3.260000] usb usb1: udev 1, busnum 1, minor = 0
[    3.270000] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.270000] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.280000] usb usb1: Product: MUSB HDRC host driver
[    3.290000] usb usb1: Manufacturer: Linux 3.12.0-rc4-00061-gb99884a musb-hcd
[    3.290000] usb usb1: SerialNumber: musb-hdrc.0.auto
[    3.310000] usb usb1: usb_probe_device
[    3.310000] usb usb1: configuration #1 chosen from 1 choice
[    3.320000] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    3.330000] hub 1-0:1.0: usb_probe_interface
[    3.330000] hub 1-0:1.0: usb_probe_interface - got id
[    3.340000] hub 1-0:1.0: USB hub found
[    3.340000] hub 1-0:1.0: 1 port detected
[    3.350000] hub 1-0:1.0: standalone hub
[    3.350000] hub 1-0:1.0: individual port power switching
[    3.360000] hub 1-0:1.0: no over-current protection
[    3.360000] hub 1-0:1.0: Single TT
[    3.370000] hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.370000] hub 1-0:1.0: power on to power good time: 10ms
[    3.380000] hub 1-0:1.0: 200mA bus power budget for each child
[    3.390000] hub 1-0:1.0: local power source is good
[    3.400000] hub 1-0:1.0: enabling power on all ports
[    3.400000] drivers/usb/musb/tusb6010.c tusb_musb_enable: dma not reactivated
[    3.430000] udc musb-hdrc.0.auto: registering UDC driver [g_ether]
[    3.440000] using random self ethernet address
[    3.440000] using random host ethernet address
[    3.450000] usb0: HOST MAC 66:06:ef:28:8c:1b
[    3.460000] usb0: MAC ca:88:a1:22:1b:cd
[    3.460000] using random self ethernet address
[    3.470000] using random host ethernet address
[    3.470000] g_ether gadget: adding config #2 'RNDIS'/c074c92c
[    3.480000] rndis_register: configNr = 0
[    3.480000] g_ether gadget: adding 'rndis'/c7b379c0 to config 'RNDIS'/c074c92c
[    3.490000] rndis_set_param_medium: 0 0
[    3.500000] g_ether gadget: RNDIS: dual speed IN/ep1in OUT/ep1out NOTIFY/ep2in
[    3.500000] g_ether gadget: cfg 2/c074c92c speeds: high full
[    3.510000] g_ether gadget:   interface 0 = rndis/c7b379c0
[    3.520000] g_ether gadget:   interface 1 = rndis/c7b379c0
[    3.520000] g_ether gadget: adding config #1 'CDC Ethernet (EEM)'/c074c8b8
[    3.530000] g_ether gadget: adding 'cdc_eem'/c7b37900 to config 'CDC Ethernet (EEM)'/c074c8b8
[    3.540000] g_ether gadget: CDC Ethernet (EEM): dual speed IN/ep1in OUT/ep1out
[    3.550000] g_ether gadget: cfg 1/c074c8b8 speeds: high full
[    3.550000] g_ether gadget:   interface 0 = cdc_eem/c7b37900
[    3.560000] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    3.570000] g_ether gadget: g_ether ready
[    3.580000] mousedev: PS/2 mouse device common for all mice
[    3.600000] i2c /dev entries driver
[    3.630000] retu-mfd 3-0001: Retu & Vilma v1.5 found
[    3.650000] input: retu-pwrbutton as /devices/platform/i2c-cbus-gpio.3/i2c-3/3-0001/retu-pwrbutton/input/input0
[    3.670000] Driver for 1-wire Dallas network protocol.
[    3.680000] omap_wdt: OMAP Watchdog Timer Rev 0x11: initial timeout 60 sec
[    3.700000] omap-dma-engine omap-dma-engine: allocating channel for 61
[    3.710000] omap-dma-engine omap-dma-engine: allocating channel for 62
[    3.720000] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[    3.730000] hub 1-0:1.0: hub_suspend
[    3.730000] usb usb1: bus auto-suspend, wakeup 1
[    3.850000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    3.860000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    3.890000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.890000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.900000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.910000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.930000] usbcore: registered new interface driver usbhid
[    3.940000] usbhid: USB HID core driver
[    3.950000] oprofile: using arm/armv6
[    3.950000] TCP: cubic registered
[    3.960000] Initializing XFRM netlink socket
[    3.960000] NET: Registered protocol family 17
[    3.970000] NET: Registered protocol family 15
[    3.970000] Key type dns_resolver registered
[    3.990000] mux: Failed to setup hwmod io irq -22
[    4.000000] Power Management for OMAP2 initializing
[    4.010000] PRCM revision 1.0
[    4.030000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    4.050000] Waiting for root device /dev/mmcblk0p2...
[    4.070000] mmc0: host does not support reading read-only switch. assuming write-enable.
[    4.080000] mmc0: new SDHC card at address ea4d
[    4.090000] mmcblk0: mmc0:ea4d SU04G 3.79 GiB 
[    4.110000]  mmcblk0: p1 p2
[    4.120000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.130000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.140000] mmci-omap mmci-omap.0: command timeout (CMD8)
[    4.140000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.150000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.170000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.180000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.200000] mmci-omap mmci-omap.0: command timeout (CMD8)
[    4.200000] kjournald starting.  Commit interval 5 seconds
[    4.210000] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck is recommended
[    4.230000] EXT3-fs (mmcblk0p2): using internal journal
[    4.230000] EXT3-fs (mmcblk0p2): recovery complete
[    4.240000] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
[    4.250000] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    4.260000] Freeing unused kernel memory: 268K (c06c1000 - c0704000)
[    4.330000] mmc1: SD Status: Invalid Allocation Unit size.
[    4.340000] mmc1: host does not support reading read-only switch. assuming write-enable.
[    4.360000] mmc1: new SD card at address e624
[    4.370000] mmcblk1: mmc1:e624 SD128 120 MiB 
[    4.400000]  mmcblk1: p1
