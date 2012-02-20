From: joancarles@fqingenieria.es (joancarles)
Date: Mon, 20 Feb 2012 14:42:14 +0100
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <20120220101157.GB9921@sapphire.tkos.co.il>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220094013.GA9921@sapphire.tkos.co.il>
 <70cdf2c4b729fb7dfa1d641c4609c6f5@mail.fqingenieria.es>
 <20120220101157.GB9921@sapphire.tkos.co.il>
Message-ID: <9741ebebcbc88e7e82a70d619e6c1d51@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> We are also trying a stock 3.3-rc kernel and can't get
>> our i.MX25 to boot ... yet.
>
> This is on-topic here. Can you share more details?

Right now, the only tree we have to test here is a 3.2.0-rc2, but I 
will try a 3.3-rc kernel soon (slow Internet connection and an even 
slower computer to cross-compile kernels inhibits us perform work 
quicker). In case there is interest, this is the output of where it 
hangs.

I believe it might have something to do with the way of how MTD works, 
or doesn't in our case, with regard to 2.6.x kernels. It can't find a 
list of partitions.

Uncompressing Linux... done, booting the kernel.
Linux version 3.2.0-rc2-ga9098b3 (develop at pc-develop) (gcc version 
4.5.2 20101105 (prerelease) (GCC) ) #2 PREEMPT Mon Feb 20 14:24:16 CET 
2012
CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Freescale MX25PDK (3DS)
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
16256
Kernel command line: console=ttymxc0,115200 root=/dev/mtdblock2 
rootfstype=jffs2 
mtdparts=physmap-flash.0:0x100000(u-boot),0x300000(kernel),0x3C00000(jffs2) 
bootcmd=tftpboot 0x81000000 /v2.1.8-rc/uImage
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 60380k/60380k available, 5156k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xc4800000 - 0xf4000000   ( 760 MB)
     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc041c3c0   (4177 kB)
       .init : 0xc041d000 - 0xc043c000   ( 124 kB)
       .data : 0xc043c000 - 0xc045fd80   ( 144 kB)
        .bss : 0xc045fda4 - 0xc0472e84   (  77 kB)
NR_IRQS:336
MXC IRQ initialized
CPU identified as i.MX25, unknown revision
sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 64585ms
Console: colour dummy device 80x30
Calibrating delay loop... 199.06 BogoMIPS (lpj=995328)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
devtmpfs: initialized
print_constraints: dummy:
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.24.
Switching to clocksource mxc_timer1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (extended precision)
NTFS driver 2.1.30 [Flags: R/W].
JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
fuse init (API version 7.17)
msgmni has been set to 117
io scheduler noop registered (default)
imx-fb imx-fb.0: i.MX Framebuffer driver
Console: switching to colour frame buffer device 80x60
imx-sdma imx35-sdma: initialized
Serial: IMX driver
imx21-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
console [ttymxc0] enabled
loop: module loaded
FEC Ethernet Driver
fec_enet_mii_bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
mxc-ehci mxc-ehci.1: irq 35, io mem 0x53ff4400
mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
imxdi_rtc imxdi_rtc.0: rtc core: registered imxdi_rtc as rtc0
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
imx2-wdt imx2-wdt.0: IMX2+ Watchdog Timer enabled. timeout=60s 
(nowayout=0)
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
ALSA device list:
   No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
imxdi_rtc imxdi_rtc.0: setting system clock to 1970-01-01 00:00:00 UTC 
(0)
List of all partitions:
No filesystem could mount root, tried:  jffs2
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)
[<c00181d0>] (unwind_backtrace+0x0/0xf0) from [<c0325f58>] 
(panic+0x60/0x198)
[<c0325f58>] (panic+0x60/0x198) from [<c041db7c>] 
(mount_block_root+0x244/0x294)
[<c041db7c>] (mount_block_root+0x244/0x294) from [<c041dd4c>] 
(prepare_namespace+0x11c/0x180)
[<c041dd4c>] (prepare_namespace+0x11c/0x180) from [<c041d800>] 
(kernel_init+0xe8/0x11c)
[<c041d800>] (kernel_init+0xe8/0x11c) from [<c0013cf4>] 
(kernel_thread_exit+0x0/0x8)

Cheers
-- 
Joan C. Abelaira
  FQ Ingenier?a Electr?nica, S.A.
Pol?gon Industrial Vilanoveta
Av. de les Roquetes, 9
E-08812 Sant Pere de Ribes (Barcelona)
SPAIN
Telf: +34 932 080 258
Fax: +34 934 592 893
M?vil: +34 638 331 745

http://www.fqingenieria.es/
email: joancarles at fqingenieria.es
