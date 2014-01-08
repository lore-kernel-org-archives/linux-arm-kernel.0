From: simon@horms.net (Simon Horman)
Date: Wed, 8 Jan 2014 13:00:21 +0900
Subject: Possible regression of Mackerel/ASoC Simple Card in next-20130107
Message-ID: <20140108040017.GA11231@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san, Hi all,

I noticed that next-20130107 does not boot on the Mackerel board does not
boot using its defconfig. The boot log is as follows.

I have not investigated any further as typically when I investigate
problems in next they turn out to be known problems.


Linux version 3.13.0-rc7-next-20140107-00005-gad2dc8a (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.7.2 (Debian 4.7.2-4) ) #771 Wed Jan 8 12:16:31 JST 2014
CPU: ARMv7 Processor [413fc081] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Mackerel (AP4 EVM 2nd)
Memory policy: Data cache writeback
CPU: All CPU(s) started in SVC mode.
bootconsole [early_ttySC0] enabled
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 60960
Kernel command line: console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp mem=240m rw
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 238412K/245760K available (3419K kernel code, 200K rwdata, 1072K rodata, 148K init, 174K bss, 7348K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xcf800000 - 0xff000000   ( 760 MB)
    lowmem  : 0xc0000000 - 0xcf000000   ( 240 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc046bf6c   (4496 kB)
      .init : 0xc046c000 - 0xc04910d0   ( 149 kB)
      .data : 0xc0492000 - 0xc04c41a0   ( 201 kB)
       .bss : 0xc04c41a0 - 0xc04efb08   ( 175 kB)
NR_IRQS:16 nr_irqs:16 16
intc: Registered controller 'sh7372-intca' with 108 IRQs
intc: Registered controller 'sh7372-intca-irq-lo' with 16 IRQs
intc: Registered controller 'sh7372-intca-irq-hi' with 16 IRQs
intc: Registered controller 'sh7372-intcs' with 61 IRQs
sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 16777216000000000ns
Console: colour dummy device 80x30
console [tty0] enabled
 sh_tmu.0: used for clock events
 sh_tmu.0: used for periodic clock events
 sh_tmu.1: used as clock source
Calibrating delay loop... 805.59 BogoMIPS (lpj=3145728)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x4035d778 - 0x4035d7d0
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh-pfc pfc-sh7372: sh7372_pfc handling gpio 0 -> 190
sh-pfc pfc-sh7372: sh7372_pfc support registered
No ATAGs?
bio: create slab <bio-0> at 0
fixed-1.8V: at 1800 mV 
fixed-3.3V: at 3300 mV 
fixed-dummy: no parameters
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz (L/H=f0/ce)
i2c-sh_mobile i2c-sh_mobile.1: I2C adapter 1 with bus speed 100000 Hz (L/H=f0/ce)
sh_cmt sh_cmt.2: used for clock events
sh_cmt sh_cmt.2: used as clock source
sh_tmu sh_tmu.0: kept as earlytimer
sh_tmu sh_tmu.1: kept as earlytimer
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource sh_tmu.1
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
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
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
msgmni has been set to 465
io scheduler noop registered (default)
sh-mobile-hdmi sh-mobile-hdmi: Detected HDMI controller 0x0:0x0
Console: switching to colour frame buffer device 100x30
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: registered sh_mobile_lcdc_fb.0/mainlcd as 800x480 16bpp.
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: registered sh_mobile_lcdc_fb.1/mainlcd as 1280x720 16bpp.
SuperH (H)SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80, base_baud = 0) is a scifa
console [ttySC0] enabled
console [ttySC0] enabled
bootconsole [early_ttySC0] disabled
bootconsole [early_ttySC0] disabled
sh-sci.1: ttySC1 at MMIO 0xe6c50000 (irq = 81, base_baud = 0) is a scifa
sh-sci.2: ttySC2 at MMIO 0xe6c60000 (irq = 82, base_baud = 0) is a scifa
sh-sci.3: ttySC3 at MMIO 0xe6c70000 (irq = 83, base_baud = 0) is a scifa
sh-sci.4: ttySC4 at MMIO 0xe6c80000 (irq = 89, base_baud = 0) is a scifa
sh-sci.5: ttySC5 at MMIO 0xe6cb0000 (irq = 90, base_baud = 0) is a scifa
sh-sci.6: ttySC6 at MMIO 0xe6c30000 (irq = 91, base_baud = 0) is a scifb
physmap platform flash device: 08000000 at 20000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000089 Chip ID 0x0088b1
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
Creating 5 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000080000 : "loader"
0x000000080000-0x000000100000 : "bootenv"
0x000000100000-0x000000900000 : "kernel_ro"
0x000000900000-0x000001100000 : "kernel"
0x000001100000-0x000008000000 : "data"
smsc911x: Driver version 2008-10-21
smsc911x smsc911x (unregistered net_device): couldn't get clock -2
libphy: smsc911x-mdio: probed
smsc911x smsc911x eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=smsc911x-fffffff:01, irq=-1)
smsc911x smsc911x eth0: MAC Address: 74:90:50:00:00:ac
usbcore: registered new interface driver usb-storage
renesas_usbhs renesas_usbhs.0: host probed
renesas_usbhs renesas_usbhs.0: gadget probed
renesas_usbhs renesas_usbhs.0: probed
renesas_usbhs renesas_usbhs.1: host probed
renesas_usbhs renesas_usbhs.1: gadget probed
renesas_usbhs renesas_usbhs.1: probed
renesas_usbhs renesas_usbhs.1: USB Host Controller
renesas_usbhs renesas_usbhs.1: new USB bus registered, assigned bus number 1
mousedev: PS/2 mouse device common for all mice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0xe6850000 clock rate 99 MHz
sh_mobile_sdhi sh_mobile_sdhi.2: mmc1 base at 0xe6870000 clock rate 99 MHz
sh_mmcif sh_mmcif.0: driver version 2010-04-28
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
Unable to handle kernel NULL pointer dereference at virtual address 0000008c
pgd = c0004000
[0000008c] *pgd=00000000
Internal error: Oops: 805 [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.0-rc7-next-20140107-00005-gad2dc8a #771
task: c8041bc0 ti: c8042000 task.ti: c8042000
PC is at asoc_simple_card_probe+0x44/0x2a4
LR is at platform_drv_probe+0x20/0x50
pc : [<c02b1648>]    lr : [<c01f33b0>]    psr: 60000113
sp : c8043da0  ip : c8043dd0  fp : c8043dcc
r10: c048a278  r9 : c8042000  r8 : 00000000
r7 : 00000000  r6 : c04a5a50  r5 : c04bf58c  r4 : c04a5a40
r3 : c02b1604  r2 : 00000000  r1 : 00000000  r0 : c04a5a40
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 40004019  DAC: 00000015
Process swapper (pid: 1, stack limit = 0xc8042238)
Stack: (0xc8043da0 to 0xc8044000)
3da0: 00000000 00000000 c04a5a50 c04bf58c 00000000 c04bf58c c0482c2c c048a278
3dc0: c8043de4 c8043dd0 c01f33b0 c02b1610 c04e4af0 c04a5a50 c8043e04 c8043de8
3de0: c01f1e28 c01f339c c04a5a50 c04bf58c c04a5a84 00000000 c8043e24 c8043e08
3e00: c01f1fd4 c01f1d20 c807f5bc 00000000 c04bf58c c01f1f40 c8043e4c c8043e28
3e20: c01f057c c01f1f4c c8030e4c c807f5b0 c839b6b4 c04bf58c c839b680 c04b6f30
3e40: c8043e5c c8043e50 c01f1934 c01f052c c8043e84 c8043e60 c01f1538 c01f191c
3e60: c0412b28 c8043e70 c04bf58c 00000006 c04c41c0 00000070 c8043e9c c8043e88
3e80: c01f265c c01f1468 c0491070 00000006 c8043eac c8043ea0 c01f3304 c01f25e8
3ea0: c8043ebc c8043eb0 c0482c44 c01f32c0 c8043f4c c8043ec0 c00094e8 c0482c38
3ec0: 00000264 c046ab4c 00000000 00000000 c8043efc c8043ee0 c8043f04 c8043ee8
3ee0: c8043f00 c8043ef0 c046c4d0 c06f0daf c0386f80 00000070 c8043f4c c8043f08
3f00: c00348bc c046c4dc c048a250 00000006 00000006 c046a44c 00000000 c043536c
3f20: c8043f4c c0491070 00000006 c04c41c0 00000070 c046c4d0 c048a26c c048a278
3f40: c8043f94 c8043f50 c046cb50 c0009400 00000006 00000006 c046c4d0 16a3cbde
3f60: a0080220 6244bd2d 21509030 00000000 c035765c 00000000 00000000 00000000
3f80: 00000000 00000000 c8043fac c8043f98 c035766c c046ca6c 00000000 00000000
3fa0: 00000000 c8043fb0 c000f478 c0357668 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000002 54f1c041
Backtrace: 
[<c02b1604>] (asoc_simple_card_probe) from [<c01f33b0>] (platform_drv_probe+0x20/0x50)
 r10:c048a278 r8:c0482c2c r7:c04bf58c r6:00000000 r5:c04bf58c r4:c04a5a50
[<c01f3390>] (platform_drv_probe) from [<c01f1e28>] (driver_probe_device+0x114/0x22c)
 r5:c04a5a50 r4:c04e4af0
[<c01f1d14>] (driver_probe_device) from [<c01f1fd4>] (__driver_attach+0x94/0x98)
 r7:00000000 r6:c04a5a84 r5:c04bf58c r4:c04a5a50
[<c01f1f40>] (__driver_attach) from [<c01f057c>] (bus_for_each_dev+0x5c/0x90)
 r6:c01f1f40 r5:c04bf58c r4:00000000 r3:c807f5bc
[<c01f0520>] (bus_for_each_dev) from [<c01f1934>] (driver_attach+0x24/0x28)
 r6:c04b6f30 r5:c839b680 r4:c04bf58c
[<c01f1910>] (driver_attach) from [<c01f1538>] (bus_add_driver+0xdc/0x1d8)
[<c01f145c>] (bus_add_driver) from [<c01f265c>] (driver_register+0x80/0xfc)
 r7:00000070 r6:c04c41c0 r5:00000006 r4:c04bf58c
[<c01f25dc>] (driver_register) from [<c01f3304>] (__platform_driver_register+0x50/0x64)
 r5:00000006 r4:c0491070
[<c01f32b4>] (__platform_driver_register) from [<c0482c44>] (asoc_simple_card_init+0x18/0x20)
[<c0482c2c>] (asoc_simple_card_init) from [<c00094e8>] (do_one_initcall+0xf4/0x150)
[<c00093f4>] (do_one_initcall) from [<c046cb50>] (kernel_init_freeable+0xf0/0x1b8)
 r10:c048a278 r9:c048a26c r8:c046c4d0 r7:00000070 r6:c04c41c0 r5:00000006
 r4:c0491070
[<c046ca60>] (kernel_init_freeable) from [<c035766c>] (kernel_init+0x10/0x118)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c035765c
 r4:00000000
[<c035765c>] (kernel_init) from [<c000f478>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:00000000
Code: ebff5df2 e1500007 1a000031 e3a07000 (e587608c) 
---[ end trace fa979cfc03b9a020 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
