From: nareshgbhat@gmail.com (Naresh Bhat)
Date: Wed, 21 Nov 2012 13:51:21 +0530
Subject: KEXEC on ARM cortex-a15
In-Reply-To: <20121120160219.GF26475@mudshark.cambridge.arm.com>
References: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
 <20121119144417.GH3290@n2100.arm.linux.org.uk>
 <20121119151327.GG3205@mudshark.cambridge.arm.com>
 <CAJXQGf+BQ18GhR3emhK-ejTivqx_o=gtaO3-FjTiE3BMGydgsw@mail.gmail.com>
 <CAJXQGf+wfXGZ=PWN585dJDMX1nH+sRexf6UZujyjKM6rJeDiXQ@mail.gmail.com>
 <20121120160219.GF26475@mudshark.cambridge.arm.com>
Message-ID: <CAJXQGfL4PRW9=MQO1XbogA40sHUzXorbFMe1WkiJ751Ej-h7=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I have disabled the SMP on host kernel.  But still I am facing the
issue as below

bash-4.2# ls
uImage  vexpress.dtb
bash-4.2#
bash-4.2# kexec -f uImage --dtb=vexpress.dtb --command-line="console=ttyS0"
Starting new kernel
Bye!
Uncompressing Linux...


I am not able to see anything after "Uncompressing Linux...".  I have
tested with different kernel versions after disabling the SMP feature,
 I have also tested with the /dev/tty devices as command line
parameter.  But no luck.

I have the following questions:

1.  Probably is it doing something and nothing printed on console ??
2.  Is it a problem with DTB file  or console issue ??

Any idea's will be helpful.  I really appreciate your help to overcome
from above issue.

Kernel bootup logs:
=============

Starting kernel ...

Booting Linux on physical CPU 0
Initializing cgroup subsys cpuset
Linux version 3.7.0-rc6+ (nareshbhat at Lenovo) (gcc version 4.7.0) #2
Thu Nov 22 13:28:13 IST 2012
CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine: ARM-Versatile Express, model: V2P-CA15_CA7
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/nfs rw ip=dhcp
nfsroot=<Host-IP>:/mnt/sda3/nfs/cortexa15/core-image -serial stdio
console=ttyAMA0 init=/bi
n/bash
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024MB = 1024MB total
Memory: 1034848k/1034848k available, 13728k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x8041ea04   (4187 kB)
      .init : 0x8041f000 - 0x80445b24   ( 155 kB)
      .data : 0x80446000 - 0x8046cb80   ( 155 kB)
       .bss : 0x8046cba4 - 0x8048cae8   ( 128 kB)
SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
Console: colour dummy device 80x30
Calibrating delay loop... 1987.37 BogoMIPS (lpj=9936896)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x80312a00 - 0x80312a58
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
Serial: AMBA PL011 UART driver
1c090000.uart: ttyAMA0 at MMIO 0x1c090000 (irq = 37) is a PL011 rev2
console [ttyAMA0] enabled
1c0a0000.uart: ttyAMA1 at MMIO 0x1c0a0000 (irq = 38) is a PL011 rev2
1c0b0000.uart: ttyAMA2 at MMIO 0x1c0b0000 (irq = 39) is a PL011 rev2
1c0c0000.uart: ttyAMA3 at MMIO 0x1c0c0000 (irq = 40) is a PL011 rev2
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Initialized.
Switching to clocksource v2m-timer1
NET: Registered protocol family 2
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP: reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
hw perfevents: enabled with ARMv7 Cortex-A15 PMU driver, 7 counters available
jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 2021
io scheduler noop registered (default)
clcd-pl11x: probe of 1c1f0000.clcd failed with error -22
smsc911x: Driver version 2008-10-21
libphy: smsc911x-mdio: probed
smsc911x 1a000000.ethernet eth0: attached PHY driver [Generic PHY]
(mii_bus:phy_addr=1a000000.etherne:01, irq=-1)
smsc911x 1a000000.ethernet eth0: MAC Address: <MAC>
nxp-isp1760 1b000000.usb: NXP ISP1760 USB Host Controller
nxp-isp1760 1b000000.usb: new USB bus registered, assigned bus number 1
nxp-isp1760 1b000000.usb: bus width: 32, oc: digital
nxp-isp1760 1b000000.usb: irq 48, io mem 0x1b000000
nxp-isp1760 1b000000.usb: USB ISP 1761 HW rev. 1 started
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: NXP ISP1760 USB Host Controller
usb usb1: Manufacturer: Linux 3.7.0-rc6+ isp1760-hcd
usb usb1: SerialNumber: 1b000000.usb
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
rtc-pl031 1c170000.rtc: rtc core: registered pl031 as rtc0
/motherboard/iofpga at 3,00000000/mmci at 050000 has no 'max-frequency' property
mmci-pl18x mb:mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 41,42 (pio)
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
aaci-pl041 1c040000.aaci: ARM AC'97 Interface PL041 rev0 at 0x1c040000, irq 43
aaci-pl041 1c040000.aaci: FIFO 512 entries
oprofile: using timer interrupt.
TCP: cubic registered
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
rtc-pl031 1c170000.rtc: setting system clock to 2012-11-22 08:00:36
UTC (1353571236)
smsc911x 1a000000.ethernet eth0: SMSC911x/921x identified at 0xc08c0000, IRQ: 47
nxp-isp1760 1b000000.usb: port 1 high speed
IP-Config: Complete:
ALSA device list:
  #0: ARM AC'97 Interface PL041 rev0 at 0x1c040000, irq 43
usb 1-1: new high-speed USB device number 2 using nxp-isp1760
nxp-isp1760 1b000000.usb: port 1 high speed
usb 1-1: New USB device found, idVendor=0471, idProduct=3526
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: ISP1520
usb 1-1: Manufacturer: Philips Semiconductors
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
atkbd serio0: keyboard reset failed on 1c060000.kmi
atkbd serio1: keyboard reset failed on 1c070000.kmi
VFS: Mounted root (nfs filesystem) on device 0:10.
Freeing init memory: 152K
bash: cannot set terminal process group (-1): Inappropriate ioctl for device
bash: no job control in this shell
bash-4.2#


Thanks and Regards
-Naresh Bhat

On Tue, Nov 20, 2012 at 9:32 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Nov 20, 2012 at 03:02:17PM +0000, Naresh Bhat wrote:
>> Hi All,
>>
>> I downloaded, compiled and installed bleeding edge GIT repository
>> http://horms.net/projects/kexec/ on my Cortex-a15 target.
>> After execution of below command the target hangs.
>>
>> bash-4.2# kexec -f uImage --dtb=vexpress.dtb
>> --command-line="root=/dev/nfs rw ip=dhcp -serial stdio
>> console=ttyAMA0"
>> Starting new kernel
>> Bye!
>> Uncompressing Linux...
>>
>> Any idea why it is happening ?
>>
>> i appreciate your help/any comments.
>>
>> My kernel version is v3.4 from kernel.org
>> vexpress.dtb - Is generated from vexpress-v2p-ca15_a7.dts
>
> Your platform probably doesn't park the secondary CPUs correctly. Try
> booting the kexec host kernel with 'nosmp' on the command line.
>
> Will



-- 
"For things to change, we must change"
-Naresh Bhat
