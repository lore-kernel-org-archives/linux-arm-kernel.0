From: yujinzhi123@gmail.com (=?GB2312?B?0+C999bH?=)
Date: Thu, 17 Feb 2011 22:12:40 +0800
Subject: ep93xx: Failed to open eth0
Message-ID: <AANLkTi=uVZnFqpXDWTgxq4M95CZbzmWkkM2jXJUtJCFi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, everyone. I am a newbie here. I come from China.
I have a board based on ep9315. I am trying to port embeded linux to that
board.
I used 'make zImage' to generate a zImage, and u-boot command 'dhcp' to
download zImage into board sdram at address 0x1000000, then 'go 0x1000000'.
Thank God! The kernel ran!
But I get this message in my minicom:

 Uncompressing Linux... done, booting the kernel.
Linux version 2.6.37 (root at myhost) (gcc version 4.1.2) #4 Wed Feb 16
20:23:04 CST 2011
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: Cirrus Logic EDB9315 Evaluation Board
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=ttyAM0,115200 root=/dev/nfs ip=dhcp
PID hash table entries: 64 (order: -4, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 16MB = 16MB total
Memory: 12584k/12584k available, 3800k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc1800000 - 0xfe800000   ( 976 MB)
    lowmem  : 0xc0000000 - 0xc1000000   (  16 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0023000   ( 108 kB)
      .text : 0xc0023000 - 0xc0352090   (3261 kB)
      .data : 0xc0354000 - 0xc0374400   ( 129 kB)
NR_IRQS:120
VIC @fefb0000: id 0x00041190, vendor 0x41
VIC @fefc0000: id 0x00041190, vendor 0x41
Calibrating delay loop... 99.73 BogoMIPS (lpj=498688)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
ep93xx clock: PLL1 running at 199 MHz, PLL2 at 192 MHz
ep93xx clock: FCLK 199 MHz, HCLK 99 MHz, PCLK 49 MHz
ep93xx dma_m2p: M2P DMA subsystem initialized
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: 1, 10240 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
UDP hash table entries: 128 (order: 0, 6144 bytes)
UDP-Lite hash table entries: 128 (order: 0, 6144 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (extended precision)
JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
msgmni has been set to 24
io scheduler noop registered
io scheduler deadline registered (default)
Serial: AMBA driver
apb:uart1: ttyAM0 at MMIO 0x808c0000 (irq = 52) is a AMBA
console [ttyAM0] enabled
apb:uart2: ttyAM1 at MMIO 0x808d0000 (irq = 54) is a AMBA
apb:uart3: ttyAM2 at MMIO 0x808e0000 (irq = 55) is a AMBA
nbd: registered device at major 43
physmap platform flash device: 02000000 at 60000000
physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID
0x000089 Chip ID 0x000018
Intel/Sharp Extended Query Table at 0x0031
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Searching for RedBoot partition table in physmap-flash.0 at offset 0x1fc0000
No RedBoot partition table detected in physmap-flash.0
ep93xx-eth version 0.1 loading
eth0: ep93xx on-chip ethernet, IRQ 39, 01:02:93:12:15:07
rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet driver
usbcore: registered new interface driver rtl8150
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ep93xx-ohci ep93xx-ohci: EP93xx OHCI
ep93xx-ohci ep93xx-ohci: new USB bus registered, assigned bus number 1
ep93xx-ohci ep93xx-ohci: irq 56, io mem 0x80020000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EP93xx OHCI
usb usb1: Manufacturer: Linux 2.6.37 ohci_hcd
usb usb1: SerialNumber: ep93xx
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
usbserial: USB Serial Driver core
USB Serial support registered for pl2303
usbcore: registered new interface driver pl2303
pl2303: Prolific PL2303 USB to serial adaptor driver
ep93xx-rtc ep93xx-rtc: rtc core: registered ep93xx-rtc as rtc0
i2c /dev entries driver
ep93xx_wdt: EP93XX watchdog, driver version 0.3
TCP cubic registered
NET: Registered protocol family 10
NET: Registered protocol family 17
NET: Registered protocol family 15
ep93xx-rtc ep93xx-rtc: setting system clock to 1970-01-01 00:57:09 UTC
(3429)
IP-Config: Failed to open eth0
IP-Config: No network devices available.
Root-NFS: no NFS server address
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option; here are the available
partitions:
1f00           32768 mtdblock0  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)

After analyzing, I think the main problem is IP-Config: Failed to open eth0,
so that the kernel can not mount the nfs root.
Is there some problem in the network driver ep93xx-eth or in some code
generate "IP-Config: Failed to open eth"

Any reply will be appreciated!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110217/2d3b23fb/attachment-0001.html>
