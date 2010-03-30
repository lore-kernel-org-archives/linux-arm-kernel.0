From: dexterdidi1-laboratory@yahoo.com (dexterdidi1-laboratory at yahoo.com)
Date: Tue, 30 Mar 2010 02:45:05 -0700 (PDT)
Subject: s3c2410 ohci-hcd problem
Message-ID: <367747.87861.qm@web45116.mail.sp1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I recently upgraded kernel on my board from 2.6.29.4 to 2.6.32.9 and now I have problem. My board doesn't recognize any device plugged on s3c2410 ohci-hcd controller. Kernel shows message: "can't read configurations, error -22". Any ideas?

I have not applied any patches related to host controller.
Here is output from dmesg:
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 8192
free_area_init_node: node 0, pgdat c0197068, node_mem_map c01a6000
  Normal zone: 64 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 8128 pages, LIFO batch:0
CPU S3C2410A (id 0x32410002)
S3C24XX Clocks, (c) 2004 Simtec Electronics
S3C2410: core 202.800 MHz, memory 101.400 MHz, peripheral 50.700 MHz
CLOCK: Slow mode (1.500 MHz), fast, MPLL on, UPLL on
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: console=ttySAC0 root=/dev/ram0
PID hash table entries: 128 (order: -3, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB = 32MB total
Memory: 29776KB available (1452K code, 121K data, 76K init, 0K highmem)
Hierarchical RCU implementation.
NR_IRQS:85
irq: clearing subpending status 00000003
irq: clearing subpending status 00000002
timer tcon=00000000, tcnt a509, tcfg 00000200,00000000, usec 00001e4c
Console: colour dummy device 80x30
console [ttySAC0] enabled
Calibrating delay loop... 100.96 BogoMIPS (lpj=252416)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
S3C2410: Initialising architecture
S3C24XX DMA Driver, (c) 2003-2004,2006 Simtec Electronics
DMA channel 0 at c2808000, irq 33
DMA channel 1 at c2808040, irq 34
DMA channel 2 at c2808080, irq 35
DMA channel 3 at c28080c0, irq 36
bio: create slab <bio-0> at 0
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 1024K
NetWinder Floating Point Emulator V0.97 (double precision)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
msgmni has been set to 60
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
s3c2410-uart.0: s3c2410_serial0 at MMIO 0x50000000 (irq = 70) is a S3C2410
s3c2410-uart.1: s3c2410_serial1 at MMIO 0x50004000 (irq = 73) is a S3C2410
s3c2410-uart.2: s3c2410_serial2 at MMIO 0x50008000 (irq = 76) is a S3C2410
brd: module loaded
NET: Registered protocol family 17
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
Freeing init memory: 76K
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
s3c2410-ohci s3c2410-ohci: s3c2410_start_hc:
s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000
s3c2410-ohci s3c2410-ohci: created debug files
s3c2410-ohci s3c2410-ohci: OHCI controller state
s3c2410-ohci s3c2410-ohci: OHCI 1.0, NO legacy support registers
s3c2410-ohci s3c2410-ohci: control 0x083 HCFS=operational CBSR=3
s3c2410-ohci s3c2410-ohci: cmdstatus 0x00000 SOC=0
s3c2410-ohci s3c2410-ohci: intrstatus 0x00000004 SF
s3c2410-ohci s3c2410-ohci: intrenable 0x8000005a MIE RHSC UE RD WDH
s3c2410-ohci s3c2410-ohci: hcca frame #0005
s3c2410-ohci s3c2410-ohci: roothub.a 02001202 POTPGT=2 NOCP NPS NDP=2(2)
s3c2410-ohci s3c2410-ohci: roothub.b 00000000 PPCM=0000 DR=0000
s3c2410-ohci s3c2410-ohci: roothub.status 00008000 DRWE
s3c2410-ohci s3c2410-ohci: roothub.portstatus [0] 0x00000100 PPS
s3c2410-ohci s3c2410-ohci: roothub.portstatus [1] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: udev 1, busnum 1, minor = 0
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: S3C24XX OHCI
usb usb1: Manufacturer: Linux 2.6.32.9 ohci_hcd
usb usb1: SerialNumber: s3c24xx
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa006,0x2900,0x0000,c1c33a10,000f)
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: no over-current protection
hub 1-0:1.0: power on to power good time: 4ms
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa000,0x0000,0x0000,c1c339c4,0004)
hub 1-0:1.0: local power source is good
hub 1-0:1.0: trying to enable port power on non-switchable hub
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0008,0x0001,c1c3398c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0008,0x0002,c1c3398c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c1c13e00,0004)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0002,c1c13e00,0004)
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
zero gadget: Gadget Zero, version: Cinco de Mayo 2008
zero gadget: zero ready
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0002
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bde8,0004)
s3c2410-ohci s3c2410-ohci: GetStatus roothub.portstatus [0] = 0x00010101 CSC PPS CCS
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0010,0x0001,c182be08,0000)
hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bde8,0004)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bde8,0004)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bde8,0004)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bde8,0004)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bde8,0004)
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0004,0x0001,c182bd7c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bd5c,0004)
s3c2410-ohci s3c2410-ohci: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0014,0x0001,c182bd7c,0000)
usb 1-1: new full speed USB device using s3c2410-ohci and address 2
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0004,0x0001,c182bd7c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bd5c,0004)
s3c2410-ohci s3c2410-ohci: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0014,0x0001,c182bd7c,0000)
usb 1-1: ep0 maxpacket = 8
usb 1-1: no configurations
usb 1-1: can't read configurations, error -22
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0001,0x0001,c182bde8,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0004,0x0001,c182bd7c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bd5c,0004)
s3c2410-ohci s3c2410-ohci: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0014,0x0001,c182bd7c,0000)
usb 1-1: new full speed USB device using s3c2410-ohci and address 3
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0004,0x0001,c182bd7c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bd5c,0004)
s3c2410-ohci s3c2410-ohci: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0014,0x0001,c182bd7c,0000)
usb 1-1: ep0 maxpacket = 8
usb 1-1: no configurations
usb 1-1: can't read configurations, error -22
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0001,0x0001,c182bde8,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0004,0x0001,c182bd7c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bd5c,0004)
s3c2410-ohci s3c2410-ohci: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0014,0x0001,c182bd7c,0000)
usb 1-1: new full speed USB device using s3c2410-ohci and address 4
usb 1-1: ep0 maxpacket = 8
usb 1-1: no configurations
usb 1-1: can't read configurations, error -22
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0001,0x0001,c182bde8,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2303,0x0004,0x0001,c182bd7c,0000)
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0xa300,0x0000,0x0001,c182bd5c,0004)
s3c2410-ohci s3c2410-ohci: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
s3c2410-ohci s3c2410-ohci: s3c2410_hub_control(c0951920,0x2301,0x0014,0x0001,c182bd7c,0000)
usb 1-1: new full speed USB device using s3c2410-ohci and address 5
usb 1-1: ep0 maxpacket = 8
usb 1-1: no configurations
usb 1-1: can't read configurations, error -22


      
