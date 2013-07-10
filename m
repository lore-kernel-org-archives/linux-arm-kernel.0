From: tibor@harsszegi.com (Tibor Harsszegi)
Date: Wed, 10 Jul 2013 18:44:16 +0200
Subject: NSA310 + DT
In-Reply-To: <51DD8E8B.2040505@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
 <20130709202143.GD26223@lunn.ch>
 <2544f179ed4349545a25aa60d52a664a@harsszegi.com>
 <20130710134119.GA30885@lunn.ch> <51DD8E8B.2040505@harsszegi.com>
Message-ID: <51DD8F60.8040708@harsszegi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

just attached a bootlog for a working 2.5 (same /dev/sda2 as the rootfs):
          __  __                      _ _
         |  \/  | __ _ _ ____   _____| | |
         | |\/| |/ _` | '__\ \ / / _ \ | |
         | |  | | (_| | |   \ V /  __/ | |
         |_|  |_|\__,_|_|    \_/ \___|_|_|
  _   _     ____              _
| | | |   | __ )  ___   ___ | |_
| | | |___|  _ \ / _ \ / _ \| __|
| |_| |___| |_) | (_) | (_) | |_
  \___/    |____/ \___/ \___/ \__|
  ** MARVELL BOARD: RD-88F6281A LE

U-Boot 1.1.4 (Feb 22 2011 - 10:31:35) Marvell version: 3.4.19

U-Boot code: 00600000 -> 0067FFF0  BSS: -> 006CFEE0

Soc: 88F6281 A1 (DDR2)
CPU running @ 1200Mhz L2 running @ 400Mhz
SysClock = 400Mhz , TClock = 200Mhz

DRAM CAS Latency = 5 tRP = 5 tRAS = 18 tRCD=6
DRAM CS[0] base 0x00000000   size 256MB
DRAM Total size 256MB  16bit width
Addresses 10M - 0M are saved for the U-Boot usage.
Mem malloc Initialization (10M - 7M): Done
NAND:128 MB
Flash:  0 kB

CPU : Marvell Feroceon (Rev 1)
Kernel address is 0xc80000.

Streaming disabled
Write allocate disabled

Module 0 is RGMII
Module 1 is TDM

USB 0: host mode
PEX 0: PCI Express Root Complex Interface
PEX interface detected Link X1
Net:   egiga0, egiga1 [PRIME]
Hit any key to stop autoboot:  0
NSA310>> setenv bootargs 'console=ttyS0,115200 root=/dev/sda2 
rootfstype=ext4'
NSA310>> bootm
## Booting image at 02000000 ...
Bad Magic Number
NSA310>> saveenv
Saving Environment to NAND...
Erasing Nand...Writing to Nand... done
NSA310>> reboot
Unknown command 'reboot' - try 'help'
NSA310>> bootm 0x800000
## Booting image at 00800000 ...
Bad Magic Number
NSA310>> ?
          __  __                      _ _
         |  \/  | __ _ _ ____   _____| | |
         | |\/| |/ _` | '__\ \ / / _ \ | |
         | |  | | (_| | |   \ V /  __/ | |
         |_|  |_|\__,_|_|    \_/ \___|_|_|
  _   _     ____              _
| | | |   | __ )  ___   ___ | |_
| | | |___|  _ \ / _ \ / _ \| __|
| |_| |___| |_) | (_) | (_) | |_
  \___/    |____/ \___/ \___/ \__|
  ** MARVELL BOARD: RD-88F6281A LE

U-Boot 1.1.4 (Feb 22 2011 - 10:31:35) Marvell version: 3.4.19

U-Boot code: 00600000 -> 0067FFF0  BSS: -> 006CFEE0

Soc: 88F6281 A1 (DDR2)
CPU running @ 1200Mhz L2 running @ 400Mhz
SysClock = 400Mhz , TClock = 200Mhz

DRAM CAS Latency = 5 tRP = 5 tRAS = 18 tRCD=6
DRAM CS[0] base 0x00000000   size 256MB
DRAM Total size 256MB  16bit width
Addresses 10M - 0M are saved for the U-Boot usage.
Mem malloc Initialization (10M - 7M): Done
NAND:128 MB
Flash:  0 kB

CPU : Marvell Feroceon (Rev 1)
Kernel address is 0xc80000.

Streaming disabled
Write allocate disabled

Module 0 is RGMII
Module 1 is TDM

USB 0: host mode
PEX 0: PCI Express Root Complex Interface
PEX interface detected Link X1
Net:   egiga0, egiga1 [PRIME]
Hit any key to stop autoboot:  0

Reset IDE:
Marvell Serial ATA Adapter
Integrated Sata device found
[0 0 0]: Enable DMA mode (6)
   Device 0 @ 0 0:
Model: SAMSUNG HN-M500MBB                       Firm: 2AR10001 Ser#: 
S2R7J9CB602267
             Type: Hard Disk
             Supports 48-bit addressing
             Capacity: 476940.0 MB = 465.7 GB (976773168 x 512)


2869242 bytes read
## Booting image at 00800000 ...
    Image Name:   Linux-3.10.0-77487-g7693569-dirt
    Created:      2013-07-10  16:32:23 UTC
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2869178 Bytes =  2.7 MB
    Load Address: 00008000
    Entry Point:  00008000
    Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.10.0-77487-g7693569-dirty (root at harsszegi.com) (gcc 
version 4.7.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #3 PREEMPT Wed Jul 10 
18:28:53 CEST 2013
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Marvell Kirkwood (Flattened Device Tree), model: ZyXEL NSA310 TDC
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS0,115200 root=/dev/sda2 rootfstype=ext4
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB = 256MB total
Memory: 253636k/253636k available, 8508k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc050f2e4   (5149 kB)
       .init : 0xc0510000 - 0xc0535770   ( 150 kB)
       .data : 0xc0536000 - 0xc0572fa0   ( 244 kB)
        .bss : 0xc0572fa0 - 0xc060c2c4   ( 613 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:114
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
Console: colour dummy device 80x30
Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc03d1068 - 0xc03d10a4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
Kirkwood: MV88F6281-A1, TCLK=200000000.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
Kirkwood PCIe port 0: link up
PCI: bus0 uses PCIe port 0
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: BAR 6: assigned [mem 0xe0000000-0xe000ffff pref]
pci 0000:00:01.0: BAR 4: assigned [mem 0xe0010000-0xe0013fff 64bit pref]
pci 0000:00:01.0: BAR 2: assigned [mem 0xe0014000-0xe0014fff 64bit pref]
pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x10ff]
bio: create slab <bio-0> at 0
USB Power Off: Failed to request enable GPIO21: -517
reg-fixed-voltage 1.regulator: Failed to register regulator: -517
platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource orion_clocksource
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
msgmni has been set to 495
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
mv_xor f1060800.xor: Marvell shared XOR driver
mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
mv_xor f1060800.xor: Marvell XOR: ( xor fill cpy )
mv_xor f1060900.xor: Marvell shared XOR driver
mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
mv_xor f1060900.xor: Marvell XOR: ( xor fill cpy )
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
console [ttyS0] enabled
loop: module loaded
sata_mv f1080000.sata: slots 32 ports 2
scsi0 : sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 21
ata2: SATA max UDMA/133 irq 21
NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 
3,3V 8-bit), 128MiB, page size: 2048, OOB size: 64
Scanning device for bad blocks
9 ofpart partitions found on MTD device orion_nand
Creating 9 MTD partitions on "orion_nand":
0x000000000000-0x000000100000 : "uboot"
0x000000100000-0x000000180000 : "uboot_env"
0x000000180000-0x000000200000 : "key_store"
0x000000200000-0x000000280000 : "info"
0x000000280000-0x000000c80000 : "etc"
0x000000c80000-0x000001680000 : "kernel_1"
0x000001680000-0x000004640000 : "rootfs1"
0x000004640000-0x000005040000 : "kernel_2"
0x000005040000-0x000008000000 : "rootfs2"
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-orion: EHCI orion driver
orion-ehci f1050000.ehci: EHCI Host Controller
orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
orion-ehci f1050000.ehci: irq 19, io mem 0xf1050000
orion-ehci f1050000.ehci: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver ums-datafab
usbcore: registered new interface driver ums-freecom
usbcore: registered new interface driver ums-jumpshot
usbcore: registered new interface driver ums-sddr09
usbcore: registered new interface driver ums-sddr55
mousedev: PS/2 mouse device common for all mice
rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
i2c /dev entries driver
gpio_poweroff_probe: Could not get GPIO 48
platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
hwmon_vid: Unknown VRM version of your CPU
lm85 0-002e: Starting monitoring
orion_wdt: Initial timeout 21 sec
cpuidle: using governor ladder
cpuidle: using governor menu
leds-gpio gpio-leds.2: pins are not configured from the driver
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: no performance counters
oprofile: using timer interrupt.
TCP: cubic registered
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
USB Power Off: Failed to request enable GPIO21: -517
reg-fixed-voltage 1.regulator: Failed to register regulator: -517
platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
gpio_poweroff_probe: Could not get GPIO 48
platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
gpio-keys gpio_keys.1: Failed to request GPIO 46, error -517
platform gpio_keys.1: Driver gpio-keys requests probe deferral
rtc-mv f1010300.rtc: setting system clock to 2013-07-10 16:37:24 UTC 
(1373474244)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
ata1.00: ATA-8: SAMSUNG HN-M500MBB, 2AR10001, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
usb 1-1: new high-speed USB device number 2 using orion-ehci
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HN-M500M 2AR1 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 0:0:0:0: [sda] Write Protect is off
USB Power Off: Failed to request enable GPIO21: -517
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
reg-fixed-voltage 1.regulator: Failed to register regulator: -517
platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
gpio_poweroff_probe: Could not get GPIO 48
platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
gpio-keys gpio_keys.1: Failed to request GPIO 46, error -517
platform gpio_keys.1: Driver gpio-keys requests probe deferral
  sda: sda1 sda2 sda3 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
USB Power Off: Failed to request enable GPIO21: -517
reg-fixed-voltage 1.regulator: Failed to register regulator: -517
platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
gpio_poweroff_probe: Could not get GPIO 48
platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
gpio-keys gpio_keys.1: Failed to request GPIO 46, error -517
platform gpio_keys.1: Driver gpio-keys requests probe deferral
ata2: SATA link down (SStatus 0 SControl F300)
VFS: Cannot open root device "sda2" or unknown-block(8,2): error -19
Please append a correct "root=" boot option; here are the available 
partitions:
1f00            1024 mtdblock0  (driver?)
1f01             512 mtdblock1  (driver?)
1f02             512 mtdblock2 usb 1-1.2: new high-speed USB device 
number 3 using orion-ehci
  (driver?)
1f03             512 mtdblock3  (driver?)
1f04           10240 mtdblock4  (driver?)
1f05           10240 mtdblock5  (driver?)
1f06           48896 mtdblock6  (driver?)
1f07           10240 mtdblock7  (driver?)
1f08           48896 mtdblock8  (driver?)
0800       488386584 sda  driver: sd
   0801          145408 sda1 0004cbfe-01
   0802         9765888 sda2 0004cbfe-02
   0803               1 sda3
   0805          487424 sda5 0004cbfe-05
   0806       477984768 sda6 0004cbfe-06
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(8,2)
CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-77487-g7693569-dirty #3
[<c000cf6c>] (unwind_backtrace+0x0/0xf0) from [<c000adec>] 
(show_stack+0x10/0x14)
[<c000adec>] (show_stack+0x10/0x14) from [<c03c7514>] (panic+0x9c/0x1ec)
[<c03c7514>] (panic+0x9c/0x1ec) from [<c0510c58>] 
(mount_block_root+0x1a0/0x258)
[<c0510c58>] (mount_block_root+0x1a0/0x258) from [<c0510e00>] 
(mount_root+0xf0/0x118)
[<c0510e00>] (mount_root+0xf0/0x118) from [<c0510f48>] 
(prepare_namespace+0x120/0x174)
[<c0510f48>] (prepare_namespace+0x120/0x174) from [<c05108dc>] 
(kernel_init_freeable+0x16c/0x1b0)
[<c05108dc>] (kernel_init_freeable+0x16c/0x1b0) from [<c03c566c>] 
(kernel_init+0x8/0xe4)
[<c03c566c>] (kernel_init+0x8/0xe4) from [<c0008d10>] 
(ret_from_fork+0x14/0x24)
?
          __  __                      _ _
         |  \/  | __ _ _ ____   _____| | |
         | |\/| |/ _` | '__\ \ / / _ \ | |
         | |  | | (_| | |   \ V /  __/ | |
         |_|  |_|\__,_|_|    \_/ \___|_|_|
  _   _     ____              _
| | | |   | __ )  ___   ___ | |_
| | | |___|  _ \ / _ \ / _ \| __|
| |_| |___| |_) | (_) | (_) | |_
  \___/    |____/ \___/ \___/ \__|
  ** MARVELL BOARD: RD-88F6281A LE

U-Boot 1.1.4 (Feb 22 2011 - 10:31:35) Marvell version: 3.4.19

U-Boot code: 00600000 -> 0067FFF0  BSS: -> 006CFEE0

Soc: 88F6281 A1 (DDR2)
CPU running @ 1200Mhz L2 running @ 400Mhz
SysClock = 400Mhz , TClock = 200Mhz

DRAM CAS Latency = 5 tRP = 5 tRAS = 18 tRCD=6
DRAM CS[0] base 0x00000000   size 256MB
DRAM Total size 256MB  16bit width
Addresses 10M - 0M are saved for the U-Boot usage.
Mem malloc Initialization (10M - 7M): Done
NAND:128 MB
Flash:  0 kB

CPU : Marvell Feroceon (Rev 1)
Kernel address is 0xc80000.

Streaming disabled
Write allocate disabled

Module 0 is RGMII
Module 1 is TDM

USB 0: host mode
PEX 0: PCI Express Root Complex Interface
PEX interface detected Link X1
Net:   egiga0, egiga1 [PRIME]
Hit any key to stop autoboot:  0
NSA310>> usb start
(Re)start USB...
USB:   scanning bus for devices... 3 USB Device(s) found
        scanning bus for storage devices... 1 Storage Device(s) found
NSA310>> fatload usb 0 0x800000 uImage
reading uImage
.
....................................................................................................................................................................................................

3002408 bytes read
NSA310>> setenv bootargs 'console=ttyS0,115200 root=/dev/sda2'
NSA310>> bootm 0x800000
## Booting image at 00800000 ...
    Image Name:   Linux-3.5.1
    Created:      2012-09-24  17:18:17 UTC
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    3002344 Bytes =  2.9 MB
    Load Address: 00008000
    Entry Point:  00008000
    Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Initializing cgroup subsys cpu
Linux version 3.5.1 (peter at Ubuntu) (gcc version 4.6.3 (Ubuntu/Linaro 
4.6.3-1ubuntu5) ) #1 Mon Sep 24 19:17:28 CEST 2012
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Zyxel NSA-310
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS0,115200 root=/dev/sda2
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB = 256MB total
Memory: 253896k/253896k available, 8248k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc0536930   (5307 kB)
       .init : 0xc0537000 - 0xc055c524   ( 150 kB)
       .data : 0xc055e000 - 0xc058f3a0   ( 197 kB)
        .bss : 0xc058f3c4 - 0xc05d19e0   ( 266 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:114
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
Initializing cgroup subsys blkio
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x464778 - 0x4647b4
devtmpfs: initialized
NET: Registered protocol family 16
Kirkwood: MV88F6281-A1, TCLK=200000000.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
NSA310: Power resume enabled
NSA310: Power-off GPIO enabled
Kirkwood PCIe port 0:
link up
PCI: bus0 uses PCIe port 0
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: BAR 6: assigned [mem 0xe0000000-0xe000ffff pref]
pci 0000:00:01.0: BAR 4: assigned [mem 0xe0010000-0xe0013fff 64bit pref]
pci 0000:00:01.0: BAR 2: assigned [mem 0xe0014000-0xe0014fff 64bit pref]
pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x10ff]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.25.
Switching to clocksource orion_clocksource
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
Key type cifs.spnego registered
NTFS driver 2.1.30 [Flags: R/W].
fuse init (API version 7.19)
Btrfs loaded
msgmni has been set to 495
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
console [ttyS0] enabled
brd: module loaded
loop: module loaded
Loading iSCSI transport class v2.0-870.
iscsi: registered transport (tcp)
sata_mv sata_mv.0: cannot get optional clkdev
sata_mv sata_mv.0: slots 32 ports 2
scsi0 : sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 21
ata2: SATA max UDMA/133 irq 21
NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 
3,3V 8-bit), page size: 2048, OOB size: 64
Scanning device for bad blocks
Creating 9 MTD partitions on "orion_nand":
0x000000000000-0x000000100000 : "uboot"
0x000000100000-0x000000180000 : "uboot_env"
0x000000180000-0x000000200000 : "key_store"
0x000000200000-0x000000280000 : "info"
0x000000280000-0x000000c80000 : "etc"
0x000000c80000-0x000001680000 : "kernel_1"
0x000001680000-0x000004640000 : "rootfs1"
0x000004640000-0x000005040000 : "kernel_2"
0x000005040000-0x000008000000 : "rootfs2"
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:00:01.0: eth0: RTL8168d/8111d at 0xd0806000, 
00:00:00:00:00:30, XID 083000c0 IRQ 9
r8169 0000:00:01.0: eth0: jumbo features [frames: 9200 bytes, tx 
checksumming: ko]
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
orion-ehci orion-ehci.0: Marvell Orion EHCI
orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
orion-ehci orion-ehci.0: irq 19, io mem 0xf1050000
orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Marvell Orion EHCI
usb usb1: Manufacturer: Linux 3.5.1 ehci_hcd
usb usb1: SerialNumber: orion-ehci.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
rtc-mv rtc-mv: rtc core: registered rtc-mv as rtc0
i2c /dev entries driver
hwmon_vid: Unknown VRM version of your CPU
lm85 0-002e: Starting monitoring
orion_wdt: Initial timeout 21 sec
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
usbcore: registered new interface driver snd-usb-audio
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
registered taskstats version 1
input: gpio-keys as /devices/platform/gpio-keys/input/input0
rtc-mv rtc-mv: setting system clock to 2013-07-10 16:41:21 UTC (1373474481)
ALSA device list:
   No soundcards found.
usb 1-1: new high-speed USB device number 2 using orion-ehci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
ata1.00: ATA-8: SAMSUNG HN-M500MBB, 2AR10001, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HN-M500M 2AR1 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-1: Product: USB2.0 Hub
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
ata2: SATA link down (SStatus 0 SControl F300)
usb 1-1.2: new high-speed USB device number 3 using orion-ehci
  sda: sda1 sda2 sda3 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
EXT2-fs (sda2): error: couldn't mount because of unsupported optional 
features (240)
usb 1-1.2: New USB device found, idVendor=0951, idProduct=1607
usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1.2: Product: DataTraveler 2.0
usb 1-1.2: Manufacturer: Kingston
usb 1-1.2: SerialNumber: 5B7C15001BF2
scsi2 : usb-storage 1-1.2:1.0
EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 8:2.
devtmpfs: mounted
Freeing init memory: 148K
INIT: version 2.88 booting
scsi 2:0:0:0: Direct-Access     Kingston DataTraveler 2.0 PMAP PQ: 0 
ANSI: 0 CCS
sd 2:0:0:0: [sdb] 1953792 512-byte logical blocks: (1.00 GB/954 MiB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] No Caching mode page present
sd 2:0:0:0: [sdb] Assuming drive cache: write through
sd 2:0:0:0: [sdb] No Caching mode page present
sd 2:0:0:0: [sdb] Assuming drive cache: write through
  sdb: sdb1
sd 2:0:0:0: [sdb] No Caching mode page present
sd 2:0:0:0: [sdb] Assuming drive cache: write through
sd 2:0:0:0: [sdb] Attached SCSI removable disk
[info] Using makefile-style concurrent boot in runlevel S.
findfs: unable to resolve 'UUID=07ec974b-3603-488f-91d9-da5dcb3a76f8'
[....] Starting the hotplug events dispatcher: udevdudevd[693]: starting 
version 175
. ok
[....] Synthesizing the initial hotplug events...done.
[....] Waiting for /dev to be fully populated...done.
[....] Setting preliminary keymap...done.
[....] Setting parameters of disc: (none). ok
[....] Activating swap...Adding 487420k swap on /dev/sda5. Priority:-1 
extents:1 across:487420k
done.
EXT4-fs (sda2): re-mounted. Opts: (null)
[....] Checking root file system...fsck from util-linux 2.20.1
Debian: clean, 83959/610800 files, 479183/2441472 blocks
done.
EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[....] Cleaning up temporary files... /tmp /run/shm. ok
[....] Loading kernel modules...done.
[....] Activating lvm and md swap...done.
[....] Checking file systems...fsck from util-linux 2.20.1
boot: clean, 16/72720 files, 27148/145408 blocks
home has been mounted 27 times without being checked, check forced.
NSA310: USB power enabled==================================    - 93.2%
home: 24/29876224 files (0.0% non-contiguous), 2222043/119496192 blocks
done.
[....] Mounting local filesystems...EXT4-fs (sda6): mounted filesystem 
with ordered data mode. Opts: (null)
done.
[....] Activating swapfile swap...done.
[....] Cleaning up temporary files.... ok
[....] Setting kernel variables ...done.
[....] Configuring network interfaces...r8169 0000:00:01.0: eth0: unable 
to load firmware patch rtl_nic/rtl8168d-2.fw (-2)
r8169 0000:00:01.0: eth0: link down
r8169 0000:00:01.0: eth0: link down
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
r8169 0000:00:01.0: eth0: link up
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
done.
[....] Starting rpcbind daemon.... ok
[....] Starting NFS common utilities: statd idmapd. ok
[....] Cleaning up temporary files.... ok
[info] Setting console screen modes.
[info] Skipping font and keymap setup (handled by console-setup).
[....] Setting up console font and keymap...done.
[....] Setting sensors limits. ok
INIT: Entering runlevel: 2
[info] Using makefile-style concurrent boot in runlevel 2.
[....] Starting rpcbind daemon...[....] Already running.. ok
[....] Starting NFS common utilities: statd idmapd. ok
[....] Not starting NFS kernel daemon: no exports. ... (warning).
[....] Starting enhanced syslogd: rsyslogd. ok
[....] Starting ACPI services...RTNETLINK1 answers: No such file or 
directory
acpid: error talking to the kernel via netlink
. ok
[....] Starting anac(h)ronistic cron: anacron. ok
[....] Starting deferred execution scheduler: atd. ok
[....] Starting periodic command scheduler: cron. ok
[....] Starting system message bus: dbus. ok
[....] Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon. ok
[....] Starting MTA:[....] Starting bluetooth: bluetoothd. ok
  exim4. ok
[....] Starting internet superserver: inetd. ok
[....] Starting Common Unix Printing System: cupsd. ok
[....] Starting Samba daemons: nmbdsaned disabled; edit /etc/default/saned
[....] Starting OpenBSD Secure Shell server: sshd. ok
  smbd. ok
[....] Starting the Winbind daemon: winbind. ok
r8169 0000:00:01.0: eth0: link down
r8169 0000:00:01.0: eth0: link down
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
100000
r8169 0000:00:01.0: eth0: link up
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

Debian GNU/Linux 7 nsa310 ttyS0

nsa310 login:

> Hello Andrew,
>
> I did a:
>
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make clean
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make kirkwood_defconfig
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make zImage
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make dtbs
> cat arch/arm/boot/zImage arch/arm/boot/dts/kirkwood-nsa310-tdc.dtb > 
> /tmp/X
> mv /tmp/X arch/arm/boot/zImage
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make uImage
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make modules
>
> [attached .config]
>
> copied the uImage over the NSA310, rebooted.
> Good news: console is back
> Bad news: LEDs still don't work (all green), kernel stops (tried 
> forcing rootfstype=ext4, didn't help)
> Bootlog:
>
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.10.0-77487-g7693569-dirty (root at harsszegi.com) (gcc 
> version 4.7.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #3 PREEMPT Wed Jul 10 
> 18:28:53 CEST 2013
> CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Marvell Kirkwood (Flattened Device Tree), model: ZyXEL NSA310 
> TDC
> Memory policy: ECC disabled, Data cache writeback
> Built 1 zonelists in Zone order, mobility grouping on. Total pages: 65024
> Kernel command line: console=ttyS0,115200 root=/dev/sda2 rootfstype=ext4
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 256MB = 256MB total
> Memory: 253636k/253636k available, 8508k reserved, 0K highmem
> Virtual kernel memory layout:
> vector : 0xffff0000 - 0xffff1000 ( 4 kB)
> fixmap : 0xfff00000 - 0xfffe0000 ( 896 kB)
> vmalloc : 0xd0800000 - 0xff000000 ( 744 MB)
> lowmem : 0xc0000000 - 0xd0000000 ( 256 MB)
> modules : 0xbf000000 - 0xc0000000 ( 16 MB)
> .text : 0xc0008000 - 0xc050f2e4 (5149 kB)
> .init : 0xc0510000 - 0xc0535770 ( 150 kB)
> .data : 0xc0536000 - 0xc0572fa0 ( 244 kB)
> .bss : 0xc0572fa0 - 0xc060c2c4 ( 613 kB)
> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Preemptible hierarchical RCU implementation.
> NR_IRQS:114
> sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
> Console: colour dummy device 80x30
> Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0xc03d1068 - 0xc03d10a4
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> Kirkwood: MV88F6281-A1, TCLK=200000000.
> Feroceon L2: Enabling L2
> Feroceon L2: Cache support initialised.
> Kirkwood PCIe port 0: link up
> PCI: bus0 uses PCIe port 0
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> pci_bus 0000:00: root bus resource [io 0x1000-0xffff]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 
> 00-ff]
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:01.0: BAR 6: assigned [mem 0xe0000000-0xe000ffff pref]
> pci 0000:00:01.0: BAR 4: assigned [mem 0xe0010000-0xe0013fff 64bit pref]
> pci 0000:00:01.0: BAR 2: assigned [mem 0xe0014000-0xe0014fff 64bit pref]
> pci 0000:00:01.0: BAR 0: assigned [io 0x1000-0x10ff]
> bio: create slab <bio-0> at 0
> USB Power Off: Failed to request enable GPIO21: -517
> reg-fixed-voltage 1.regulator: Failed to register regulator: -517
> platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
> vgaarb: loaded
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> cfg80211: Calling CRDA to update world regulatory domain
> Switching to clocksource orion_clocksource
> NET: Registered protocol family 2
> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP: reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
> msgmni has been set to 495
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> mv_xor f1060800.xor: Marvell shared XOR driver
> mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
> mv_xor f1060800.xor: Marvell XOR: ( xor fill cpy )
> mv_xor f1060900.xor: Marvell shared XOR driver
> mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
> mv_xor f1060900.xor: Marvell XOR: ( xor fill cpy )
> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
> console [ttyS0] enabled
> loop: module loaded
> sata_mv f1080000.sata: slots 32 ports 2
> scsi0 : sata_mv
> scsi1 : sata_mv
> ata1: SATA max UDMA/133 irq 21
> ata2: SATA max UDMA/133 irq 21
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 
> 3,3V 8-bit), 128MiB, page size: 2048, OOB size: 64
> Scanning device for bad blocks
> 9 ofpart partitions found on MTD device orion_nand
> Creating 9 MTD partitions on "orion_nand":
> 0x000000000000-0x000000100000 : "uboot"
> 0x000000100000-0x000000180000 : "uboot_env"
> 0x000000180000-0x000000200000 : "key_store"
> 0x000000200000-0x000000280000 : "info"
> 0x000000280000-0x000000c80000 : "etc"
> 0x000000c80000-0x000001680000 : "kernel_1"
> 0x000001680000-0x000004640000 : "rootfs1"
> 0x000004640000-0x000005040000 : "kernel_2"
> 0x000005040000-0x000008000000 : "rootfs2"
> libertas_sdio: Libertas SDIO driver
> libertas_sdio: Copyright Pierre Ossman
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-pci: EHCI PCI platform driver
> ehci-orion: EHCI orion driver
> orion-ehci f1050000.ehci: EHCI Host Controller
> orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
> orion-ehci f1050000.ehci: irq 19, io mem 0xf1050000
> orion-ehci f1050000.ehci: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> usbcore: registered new interface driver usb-storage
> usbcore: registered new interface driver ums-datafab
> usbcore: registered new interface driver ums-freecom
> usbcore: registered new interface driver ums-jumpshot
> usbcore: registered new interface driver ums-sddr09
> usbcore: registered new interface driver ums-sddr55
> mousedev: PS/2 mouse device common for all mice
> rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
> i2c /dev entries driver
> gpio_poweroff_probe: Could not get GPIO 48
> platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
> hwmon_vid: Unknown VRM version of your CPU
> lm85 0-002e: Starting monitoring
> orion_wdt: Initial timeout 21 sec
> cpuidle: using governor ladder
> cpuidle: using governor menu
> leds-gpio gpio-leds.2: pins are not configured from the driver
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> oprofile: no performance counters
> oprofile: using timer interrupt.
> TCP: cubic registered
> NET: Registered protocol family 17
> lib80211: common routines for IEEE802.11 drivers
> USB Power Off: Failed to request enable GPIO21: -517
> reg-fixed-voltage 1.regulator: Failed to register regulator: -517
> platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
> gpio_poweroff_probe: Could not get GPIO 48
> platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
> gpio-keys gpio_keys.1: Failed to request GPIO 46, error -517
> platform gpio_keys.1: Driver gpio-keys requests probe deferral
> rtc-mv f1010300.rtc: setting system clock to 2013-07-10 16:37:24 UTC 
> (1373474244)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
> ata1.00: ATA-8: SAMSUNG HN-M500MBB, 2AR10001, max UDMA/133
> ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> usb 1-1: new high-speed USB device number 2 using orion-ehci
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access ATA SAMSUNG HN-M500M 2AR1 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> USB Power Off: Failed to request enable GPIO21: -517
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> reg-fixed-voltage 1.regulator: Failed to register regulator: -517
> platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
> gpio_poweroff_probe: Could not get GPIO 48
> platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
> gpio-keys gpio_keys.1: Failed to request GPIO 46, error -517
> platform gpio_keys.1: Driver gpio-keys requests probe deferral
> sda: sda1 sda2 sda3 < sda5 sda6 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> hub 1-1:1.0: USB hub found
> hub 1-1:1.0: 4 ports detected
> USB Power Off: Failed to request enable GPIO21: -517
> reg-fixed-voltage 1.regulator: Failed to register regulator: -517
> platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
> gpio_poweroff_probe: Could not get GPIO 48
> platform gpio_poweroff.3: Driver poweroff-gpio requests probe deferral
> gpio-keys gpio_keys.1: Failed to request GPIO 46, error -517
> platform gpio_keys.1: Driver gpio-keys requests probe deferral
> ata2: SATA link down (SStatus 0 SControl F300)
> VFS: Cannot open root device "sda2" or unknown-block(8,2): error -19
> Please append a correct "root=" boot option; here are the available 
> partitions:
> 1f00 1024 mtdblock0 (driver?)
> 1f01 512 mtdblock1 (driver?)
> 1f02 512 mtdblock2 usb 1-1.2: new high-speed USB device number 3 using 
> orion-ehci
> (driver?)
> 1f03 512 mtdblock3 (driver?)
> 1f04 10240 mtdblock4 (driver?)
> 1f05 10240 mtdblock5 (driver?)
> 1f06 48896 mtdblock6 (driver?)
> 1f07 10240 mtdblock7 (driver?)
> 1f08 48896 mtdblock8 (driver?)
> 0800 488386584 sda driver: sd
> 0801 145408 sda1 0004cbfe-01
> 0802 9765888 sda2 0004cbfe-02
> 0803 1 sda3
> 0805 487424 sda5 0004cbfe-05
> 0806 477984768 sda6 0004cbfe-06
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(8,2)
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-77487-g7693569-dirty #3
> [<c000cf6c>] (unwind_backtrace+0x0/0xf0) from [<c000adec>] 
> (show_stack+0x10/0x14)
> [<c000adec>] (show_stack+0x10/0x14) from [<c03c7514>] (panic+0x9c/0x1ec)
> [<c03c7514>] (panic+0x9c/0x1ec) from [<c0510c58>] 
> (mount_block_root+0x1a0/0x258)
> [<c0510c58>] (mount_block_root+0x1a0/0x258) from [<c0510e00>] 
> (mount_root+0xf0/0x118)
> [<c0510e00>] (mount_root+0xf0/0x118) from [<c0510f48>] 
> (prepare_namespace+0x120/0x174)
> [<c0510f48>] (prepare_namespace+0x120/0x174) from [<c05108dc>] 
> (kernel_init_freeable+0x16c/0x1b0)
> [<c05108dc>] (kernel_init_freeable+0x16c/0x1b0) from [<c03c566c>] 
> (kernel_init+0x8/0xe4)
> [<c03c566c>] (kernel_init+0x8/0xe4) from [<c0008d10>] 
> (ret_from_fork+0x14/0x24)
>
>> Hi Tibor
>>
>> I created a DTS file based on the tree you gave me.
>>
>> Please could you try
>>
>> https://github.com/lunn/linux.git branch v3.10-nsa310-tdc
>>
>> and the DTS file arch/arm/boot/dts/kirkwood-nsa310-tdc.dts
>>
>> Please use
>>
>> make kirkwood_defconfig
>> make
>>
>> and it should have the lm85 built in.
>>
>> The two different NSA310 are mostly similar, just a few different gpio
>> LEDs and buttons, so i might actually refactor the two dts files with
>> what is shared. But lets get your box working first.
>>
>>       Andrew
>
