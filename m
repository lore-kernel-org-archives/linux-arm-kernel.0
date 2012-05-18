From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 18 May 2012 01:07:07 -0300
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
Message-ID: <CAOMZO5BUBAcx9ESLau9b4osE3jQNnh1CXW7FgkmbQ1aS57bOCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 12:48 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Sascha,
>
> Are you able to boot any mx31 system on linux-next-20120517?
>
> Just wanted to check with you first before start debugging this issue.

Adding earlyprintk shows me the following:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.4.0-rc7-next-20120517 (fabio at fabio-Latitude-E6410)
(gcc version 4.4.4 (4.4.4_09.06.2010) ) #701 SMP Fri May 18 00:58:51
BRT 2012
CPU: ARMv6-compatible processor [4107b364] revision 4 (ARMv6TEJ), cr=00c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Freescale MX31PDK (3DS)
bootconsole [earlycon0] enabled
cma: CMA: reserved 16 MiB at 86800000
Memory policy: ECC disabled, Data cache writeback
PERCPU: Embedded 7 pages/cpu @80759000 s5440 r8192 d15040 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 30464
Kernel command line: console=ttymxc0,115200 root=/dev/nfs ip=dhcp
nfsroot=192.168.1.105:/tftpboot/ltib earlyprintk
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 120MB = 120MB total
Memory: 98808k/98808k available, 32264k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0x88800000 - 0xff000000   (1896 MB)
    lowmem  : 0x80000000 - 0x88000000   ( 128 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x8055f000   (5468 kB)
      .init : 0x8055f000 - 0x805a7540   ( 290 kB)
      .data : 0x805a8000 - 0x805ff958   ( 351 kB)
       .bss : 0x805ff97c - 0x8065537c   ( 343 kB)
SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:436
MXC IRQ initialized
CPU identified as i.MX31, silicon rev 2.0
sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 64585ms
Console: colour dummy device 80x30
Calibrating delay loop... 531.66 BogoMIPS (lpj=2658304)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket -1, mpidr 4107b364
Setting up static identity map for 0x8042d550 - 0x8042d5c0
Brought up 1 CPUs
SMP: Total of 1 processors activated (531.66 BogoMIPS).
devtmpfs: initialized
initlevel:0=early, 4 registered initcalls
initlevel:1=core, 23 registered initcalls
pinctrl core: initialized pinctrl subsystem
dummy:
NET: Registered protocol family 16
initlevel:2=postcore, 14 registered initcalls
DMA: preallocated 256 KiB pool for atomic coherent allocations
initlevel:3=arch, 8 registered initcalls
L210 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x41000040, AUX_CTRL 0x00030024, Cache size: 131072 B
gpiochip_add: registered GPIOs 0 to 31 on device: imx31-gpio.0
gpiochip_add: registered GPIOs 32 to 63 on device: imx31-gpio.1
gpiochip_add: registered GPIOs 64 to 95 on device: imx31-gpio.2
3-Stack Debug board detected, rev = 0x0200
initlevel:4=subsys, 36 registered initcalls
bio: create slab <bio-0> at 0
fixed-dummy:
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
initlevel:5=fs, 16 registered initcalls
Switching to clocksource mxc_timer1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 128 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initlevel:6=device, 248 registered initcalls
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
fuse init (API version 7.19)
msgmni has been set to 224
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
mx3_sdc_fb mx3_sdc_fb: registered, using mode Epson-VGA
Console: switching to colour frame buffer device 60x40
imx-sdma imx31-sdma: initialized
Serial: IMX driver
brd: module loaded
loop: module loaded
smsc911x: Driver version 2008-10-21
smsc911x-mdio: probed
smsc911x smsc911x: eth0: attached PHY driver [Generic PHY]
(mii_bus:phy_addr=smsc911x-fffffff:01, irq=-1)
smsc911x smsc911x: eth0: MAC Address: 00:04:9f:00:94:e3
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
lirc_dev: IR Remote Control driver registered, major 253
IR NEC protocol handler initialized
IR RC5(x) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR RC5 (streamzap) protocol handler initialized
IR SANYO protocol handler initialized
IR MCE Keyboard/mouse protocol handler initialized
IR LIRC bridge handler initialized
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
soc-camera-pdrv soc-camera-pdrv.0: Failed to get supply 'cmos_vcore': -517
dmaengine_get: failed to get dma1chan0: (-22)
dmaengine_get: failed to get dma1chan1: (-22)
dmaengine_get: failed to get dma1chan2: (-22)
dmaengine_get: failed to get dma1chan3: (-22)
dmaengine_get: failed to get dma1chan4: (-22)
dmaengine_get: failed to get dma1chan5: (-22)
dmaengine_get: failed to get dma1chan6: (-22)
dmaengine_get: failed to get dma1chan7: (-22)
dmaengine_get: failed to get dma1chan8: (-22)
dmaengine_get: failed to get dma1chan9: (-22)
dmaengine_get: failed to get dma1chan10: (-22)
dmaengine_get: failed to get dma1chan11: (-22)
dmaengine_get: failed to get dma1chan12: (-22)
dmaengine_get: failed to get dma1chan13: (-22)
dmaengine_get: failed to get dma1chan14: (-22)
dmaengine_get: failed to get dma1chan15: (-22)
dmaengine_get: failed to get dma1chan16: (-22)
dmaengine_get: failed to get dma1chan17: (-22)
dmaengine_get: failed to get dma1chan18: (-22)
dmaengine_get: failed to get dma1chan19: (-22)
dmaengine_get: failed to get dma1chan20: (-22)
dmaengine_get: failed to get dma1chan21: (-22)
dmaengine_get: failed to get dma1chan22: (-22)
dmaengine_get: failed to get dma1chan23: (-22)
dmaengine_get: failed to get dma1chan24: (-22)
dmaengine_get: failed to get dma1chan25: (-22)
dmaengine_get: failed to get dma1chan26: (-22)
dmaengine_get: failed to get dma1chan27: (-22)
dmaengine_get: failed to get dma1chan28: (-22)
dmaengine_get: failed to get dma1chan29: (-22)
dmaengine_get: failed to get dma1chan30: (-22)
imx2-wdt imx2-wdt.0: IMX2+ Watchdog Timer enabled. timeout=60s (nowayout=0)
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
initlevel:7=late, 20 registered initcalls
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
turn off boot console earlycon

How can we prevent the "turn off boot console earlycon" to happen?

Thanks,

Fabio Estevam
