From: michael@walle.cc (Michael Walle)
Date: Wed, 24 Oct 2012 22:47:57 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121024200128.GY21046@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210242006.55879.michael@walle.cc> <20121024200128.GY21046@lunn.ch>
Message-ID: <201210242247.57786.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 24 Oktober 2012, 22:01:28 schrieb Andrew Lunn:
> What happens if you comment out these two gpio_set_value calls?

After commenting out and fixing the mpp funtions (see earlier mail from me) 
the kernel hangs after rtc-mv/before orion_wdt.


Your tree:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.7.0-rc2-00015-g2773c33-dirty (mw at thanatos) (gcc version 4.4.5 
(Debian 4.4.5-8) ) #9 PREEMPT Wed Oct 24 22:27:07 CEST 2012
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Marvell Kirkwood (Flattened Device Tree), model: Buffalo Linkstation 
LS-CHLv2
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS0,115200 root=/dev/sda2 earlyprintk
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 55828k/55828k available, 9708k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc04e2660   (4970 kB)
      .init : 0xc04e3000 - 0xc0506ca0   ( 144 kB)
      .data : 0xc0508000 - 0xc0540280   ( 225 kB)
       .bss : 0xc05402a4 - 0xc05d7a3c   ( 606 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:114
sched_clock: 32 bits at 166MHz, resolution 5ns, wraps every 25769ms
Console: colour dummy device 80x30
Calibrating delay loop... 597.60 BogoMIPS (lpj=2988032)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x3baaa8 - 0x3baae4
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 1024 KiB pool for atomic coherent allocations
Kirkwood: MV88F6281-A1, TCLK=166666667.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
bio: create slab <bio-0> at 0
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
jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 109
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
kirkwood-pinctrl f1010000.pinctrl: registered pinctrl driver
mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
loop: module loaded
sata_mv sata_mv.0: cannot get optional clkdev
sata_mv sata_mv.0: slots 32 ports 1
scsi0 : sata_mv
ata1: SATA max UDMA/133 irq 21
m25p80 spi0.0: m25p40 (512 Kbytes)
3 ofpart partitions found on MTD device spi0.0
Creating 3 MTD partitions on "spi0.0":
0x000000000000-0x000000060000 : "uboot"
0x000000060000-0x000000070000 : "dtb"
0x000000070000-0x000000080000 : "uboot_env"
mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
libphy: mv643xx_eth smi: probed
mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 
00:00:00:00:00:00
mv643xx_eth_port mv643xx_eth_port.1 eth1: port 0 with MAC address 
4c:e6:76:61:b9:f7
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
orion-ehci orion-ehci.0: Marvell Orion EHCI
orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
orion-ehci orion-ehci.0: irq 19, io mem 0xf1050000
orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver ums-datafab
usbcore: registered new interface driver ums-freecom
usbcore: registered new interface driver ums-jumpshot
usbcore: registered new interface driver ums-sddr09
usbcore: registered new interface driver ums-sddr55
mousedev: PS/2 mouse device common for all mice
rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
i2c /dev entries driver



v3.7rc2 tag:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.7.0-rc2 (mw at thanatos) (gcc version 4.4.5 (Debian 4.4.5-8) ) 
#11 PREEMPT Wed Oct 24 22:42:25 CEST 2012
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Marvell Kirkwood (Flattened Device Tree), model: Buffalo Linkstation 
LS-CHLv2
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS0,115200 root=/dev/sda2 earlyprintk
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 55884k/55884k available, 9652k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc04d82e4   (4929 kB)
      .init : 0xc04d9000 - 0xc04fcda0   ( 144 kB)
      .data : 0xc04fe000 - 0xc0533fa0   ( 216 kB)
       .bss : 0xc0533fc4 - 0xc05cb59c   ( 606 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:114
sched_clock: 32 bits at 166MHz, resolution 5ns, wraps every 25769ms
Console: colour dummy device 80x30
Calibrating delay loop... 597.60 BogoMIPS (lpj=2988032)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x3b41c8 - 0x3b4204
NET: Registered protocol family 16
DMA: preallocated 1024 KiB pool for atomic coherent allocations
Kirkwood: MV88F6281-A1, TCLK=166666667.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
bio: create slab <bio-0> at 0
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
jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 109
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
console [ttyS0] enabled
loop: module loaded
sata_mv sata_mv.0: cannot get optional clkdev
sata_mv sata_mv.0: slots 32 ports 1
scsi0 : sata_mv
ata1: SATA max UDMA/133 irq 21
m25p80 spi0.0: m25p40 (512 Kbytes)
3 ofpart partitions found on MTD device spi0.0
Creating 3 MTD partitions on "spi0.0":
0x000000000000-0x000000060000 : "uboot"
0x000000060000-0x000000070000 : "dtb"
0x000000070000-0x000000080000 : "uboot_env"
mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
libphy: mv643xx_eth smi: probed
mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 
00:00:00:00:00:00
mv643xx_eth_port mv643xx_eth_port.1 eth1: port 0 with MAC address 
4c:e6:76:61:b9:f7
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
orion-ehci orion-ehci.0: Marvell Orion EHCI
orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
orion-ehci orion-ehci.0: irq 19, io mem 0xf1050000
orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver ums-datafab
usbcore: registered new interface driver ums-freecom
usbcore: registered new interface driver ums-jumpshot
usbcore: registered new interface driver ums-sddr09
usbcore: registered new interface driver ums-sddr55
mousedev: PS/2 mouse device common for all mice
rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
i2c /dev entries driver
orion_wdt: Initial timeout 25 sec
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: no performance counters
oprofile: using timer interrupt.
TCP: cubic registered
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
input: gpio_keys.1 as /devices/gpio_keys.1/input/input0
rtc-mv f1010300.rtc: setting system clock to 2000-01-01 00:00:00 UTC 
(946684800)
ata1: SATA link down (SStatus 0 SControl F300)
VFS: Cannot open root device "sda2" or unknown-block(0,0): error -6


--
michael
