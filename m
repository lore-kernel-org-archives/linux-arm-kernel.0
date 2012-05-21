From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 21 May 2012 10:20:09 -0300
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <20120518085922.GQ30400@pengutronix.de>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <CAOMZO5BUBAcx9ESLau9b4osE3jQNnh1CXW7FgkmbQ1aS57bOCg@mail.gmail.com>
 <20120518085922.GQ30400@pengutronix.de>
Message-ID: <CAOMZO5DNSRCknE2Z-rmUjBsJWaiZdRb=8hrNw2N=u4OsqyX1AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, May 18, 2012 at 5:59 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Looks familiar. Check the pinctrl support. The i.MX UART driver (and
> also the FEC driver) do a devm_pinctrl_get_select_default which does
> not seem to be complete. Either the pinctrl dummy providers did not make
> it to -next yet or they are simply not activated.

You are right. After applying this patch:
http://marc.info/?l=linux-arm-kernel&m=133753393231876&w=2

, I am able to see the console messages without having to add 'earlyprintk'.

Now my boot hangs in another point:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.4.0-next-20120521+ (fabio at fabio-Latitude-E6410) (gcc
version 4.4.4 (4.4.4_09.06.2010) ) #713 SMP Mon May 21 10:03:41 BRT
2012
CPU: ARMv6-compatible processor [4107b364] revision 4 (ARMv6TEJ), cr=00c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Freescale MX31PDK (3DS)
cma: CMA: reserved 16 MiB at 86800000
Memory policy: ECC disabled, Data cache writeback
PERCPU: Embedded 7 pages/cpu @80737000 s5440 r8192 d15040 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 30464
Kernel command line: console=ttymxc0,115200 root=/dev/nfs ip=dhcp
nfsroot=10.29.240.143:/tftpboot/ltib root=/dev/nfs ip=dhcp
nfsroot=10.29.240.143:/tftpboot/b
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 120MB = 120MB total
Memory: 98944k/98944k available, 32128k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0x88800000 - 0xff000000   (1896 MB)
    lowmem  : 0x80000000 - 0x88000000   ( 128 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x80543000   (5356 kB)
      .init : 0x80543000 - 0x8058a540   ( 286 kB)
      .data : 0x8058c000 - 0x805de4e0   ( 330 kB)
       .bss : 0x805de504 - 0x80633f3c   ( 343 kB)
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
Setting up static identity map for 0x8041dab0 - 0x8041db20
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
3-Stack Debug board detected, rev = 0x0200
initlevel:4=subsys, 36 registered initcalls
bio: create slab <bio-0> at 0
fixed-dummy:
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
initlevel:5=fs, 15 registered initcalls
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
initlevel:6=device, 250 registered initcalls
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
fuse init (API version 7.19)
msgmni has been set to 225
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
mx3_sdc_fb mx3_sdc_fb: registered, using mode Epson-VGA
Console: switching to colour frame buffer device 60x40
imx-sdma imx31-sdma: initialized
Serial: IMX driver
imx21-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
console [ttymxc0] enabled
brd: module loaded
loop: module loaded
spi_imx imx31-cspi.1: master is unqueued, this is deprecated

,if I remove the spi driver then the boots complete.

I am debugging this now, but any suggestions are welcome.

Thanks,

Fabio Estevam
