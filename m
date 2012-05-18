From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 May 2012 10:33:21 +0800
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <CAOMZO5Aj0cfpJwMEQwOvM9cM52=W5Rtr5kKxqgw1JG_5AQ5t+g@mail.gmail.com>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
 <CAOMZO5D679an+-iaUBXZy+PmHB2tAHhYHUAFWY+4rxSOYiBkyw@mail.gmail.com>
 <CAAQ0ZWRB1=pFqtL_2y-D-f4_VM21o9U1G9F3PMwNgM4ewKmkWQ@mail.gmail.com>
 <CAOMZO5Aj0cfpJwMEQwOvM9cM52=W5Rtr5kKxqgw1JG_5AQ5t+g@mail.gmail.com>
Message-ID: <20120518023318.GB5427@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 11:00:07PM -0300, Fabio Estevam wrote:
> On Thu, May 17, 2012 at 10:58 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On 18 May 2012 09:50, Fabio Estevam <festevam@gmail.com> wrote:
> >> Could you please confirm next-20120517 also boots?
> >>
> >> I am not getting nothing on console.
> >>
> >> This is my U-boot setup:
> >>
> >> run netargs; tftpboot 42000000 uImage; tftpboot 42800000
> >> imx28-evk.dtb; bootm 0x4000000 - 0x42000000
> >>
> > The addresses in bootm mismatch the ones in tftpboot?
> 
> Sorry, my typo. The line I use is:
> 
> run netargs; tftpboot 42000000 uImage; tftpboot 42800000
> imx28-evk.dtb; bootm 0x42000000 - 0x42800000
> 
> This is what I see:
> 
The next-20120517 seems working for me too.

You can turn on low-level debug option to see where it goes wrong
at your end.

Regards,
Shawn

U-Boot 2011.12-00225-g8753994-dirty (Jan 28 2012 - 22:22:20)

Freescale i.MX28 family
DRAM:  128 MiB
WARNING: Caches not enabled
MMC:   MXS MMC: 0
In:    serial
Out:   serial
Err:   serial
Net:   FEC0, FEC1
Warning: failed to set MAC address

Hit any key to stop autoboot:  0
MX28EVK U-Boot > set bootargs console=ttyAMA0,115200 root=/dev/mmcblk0p2 rw root
wait ip=:::::eth0:dhcp
MX28EVK U-Boot > boot
Using FEC0 device
TFTP from server 192.168.1.3; our IP address is 192.168.1.7
Filename 'uImage'.
Load address: 0x42000000
Loading: #################################################################
         #################################################################
         ##########################
done
Bytes transferred = 2283144 (22d688 hex)
Using FEC0 device
TFTP from server 192.168.1.3; our IP address is 192.168.1.7
Filename 'imx28-evk.dtb'.
Load address: 0x42800000
Loading: #
done
Bytes transferred = 9340 (247c hex)
## Booting kernel from Legacy Image at 42000000 ...
   Image Name:   Linux-3.4.0-rc7-next-20120517-di
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2283080 Bytes = 2.2 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 42800000
   Booting using the fdt blob at 0x42800000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 47b92000, end 47b9747b ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc7-next-20120517-dirty (r65073 at S2101-09) (gc
c version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #10 Fri May 18 10:22:22 CST 201
2
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Freescale i.MX28 (Device Tree), model: Freescale i.MX28
Evaluation Kit
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pag
es: 32512
[    0.000000] Kernel command line: console=ttyAMA0,115200 root=/dev/mmcblk0p2 r
w rootwait ip=:::::eth0:dhcp
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 119908k/119908k available, 11164k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc040d800   (4118 kB)
[    0.000000]       .init : 0xc040e000 - 0xc042e000   ( 128 kB)
[    0.000000]       .data : 0xc042e000 - 0xc046b4b8   ( 246 kB)
[    0.000000]        .bss : 0xc046b4dc - 0xc09b77a0   (5425 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, N
odes=1
[    0.000000] NR_IRQS:304
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps ever
y 4294967286ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo
 Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.070000] Calibrating delay loop... 226.09 BogoMIPS (lpj=1130496)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.070000] Mount-cache hash table entries: 512
[    0.080000] CPU: Testing write buffer coherency: ok
[    0.080000] Setting up static identity map for 0x402e7b10 - 0x402e7b68
[    0.090000] devtmpfs: initialized
[    0.100000] initlevel:0=early, 4 registered initcalls
[    0.100000] initlevel:1=core, 19 registered initcalls
[    0.100000] pinctrl core: initialized pinctrl subsystem
[    0.100000] dummy:
[    0.110000] NET: Registered protocol family 16
[    0.110000] initlevel:2=postcore, 12 registered initcalls
[    0.110000] initlevel:3=arch, 8 registered initcalls
[    0.120000] gpiochip_add: registered GPIOs 0 to 31 on device: gpio.0
[    0.120000] gpiochip_add: registered GPIOs 32 to 63 on device: gpio.1
[    0.120000] gpiochip_add: registered GPIOs 64 to 95 on device: gpio.2
[    0.120000] gpiochip_add: registered GPIOs 96 to 127 on device: gpio.3
[    0.130000] gpiochip_add: registered GPIOs 128 to 159 on device: gpio.4
[    0.140000] Serial: AMBA PL011 UART driver
[    0.140000] 80074000.serial: ttyAMA0 at MMIO 0x80074000 (irq = 47) is a PL011
 rev2
[    0.350000] console [ttyAMA0] enabled
[    0.360000] initlevel:4=subsys, 27 registered initcalls
[    0.380000] bio: create slab <bio-0> at 0
[    0.400000] mxs-dma 80004000.dma-apbh: initialized
[    0.410000] mxs-dma 80024000.dma-apbx: initialized
[    0.410000] 3P3V: 3300 mV
[    0.420000] Advanced Linux Sound Architecture Driver Version 1.0.25.
[    0.430000] initlevel:5=fs, 18 registered initcalls
[    0.440000] Switching to clocksource mxs_timer
[    0.590000] NET: Registered protocol family 2
[    0.600000] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.610000] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.620000] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.630000] TCP: Hash tables configured (established 4096 bind 4096)
[    0.640000] TCP: reno registered
[    0.640000] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    0.640000] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    0.650000] NET: Registered protocol family 1
[    0.660000] RPC: Registered named UNIX socket transport module.
[    0.670000] RPC: Registered udp transport module.
[    0.670000] RPC: Registered tcp transport module.
[    0.680000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.680000] initlevel:6=device, 100 registered initcalls
[    0.690000] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.750000] NFS: Registering the id_resolver key type
[    0.760000] Key type id_resolver registered
[    0.770000] msgmni has been set to 234
[    0.780000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 2
53)
[    0.780000] io scheduler noop registered (default)
[    0.790000] uart-pl011 80074000.serial: no DMA platform data
[    0.800000] GPMI NAND driver registered. (IMX)
[    0.820000] fec_enet_mii_bus: probed
[    0.830000] mousedev: PS/2 mouse device common for all mice
[    0.840000] i2c /dev entries driver
[    0.890000] mxs-mmc 80010000.ssp: initialized
[    0.910000] sgtl5000 0-000a: Failed to get supply 'VDDD': -517
[    0.920000] 0-000a: 1200 mV normal
[    0.930000] sgtl5000 0-000a: Using internal LDO instead of VDDD
[    0.940000] sgtl5000 0-000a: sgtl5000 revision 0x11
[    0.960000] asoc: sgtl5000 <-> 80042000.saif mapping ok
[    0.970000] asoc: sgtl5000 <-> 80046000.saif mapping ok
[    0.990000] TCP: cubic registered
[    0.990000] NET: Registered protocol family 17
[    1.000000] Key type dns_resolver registered
[    1.000000] initlevel:7=late, 20 registered initcalls
[    1.010000] registered taskstats version 1
[    1.020000] /home/r65073/repos/shawnguo/linux-2.6/drivers/rtc/hctosys.c: unab
le to open rtc device (rtc0)
[    1.030000] mmc0: new high speed SDHC card at address e624
[    1.040000] eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=80
0f0000.etherne:00, irq=-1)
[    1.050000] mmcblk0: mmc0:e624 SD08G 7.40 GiB
[    1.070000]  mmcblk0: p1 p2
[    3.040000] PHY: 800f0000.etherne:00 - Link is Up - 100/Full
[    5.200000] Sending DHCP requests ., OK
[    5.200000] IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.1.
7
[    5.210000] IP-Config: Complete:
[    5.210000]      device=eth0, addr=192.168.1.7, mask=255.255.255.0, gw=192.16
8.1.1
[    5.220000]      host=192.168.1.7, domain=, nis-domain=(none)
[    5.220000]      bootserver=0.0.0.0, rootserver=0.0.0.0, rootpath=
[    5.230000] ALSA device list:
[    5.230000]   #0: mxs_sgtl5000
[    6.260000] kjournald starting.  Commit interval 5 seconds
[    6.270000] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, runnin
g e2fsck is recommended
[    6.280000] EXT3-fs (mmcblk0p2): using internal journal
[    6.290000] EXT3-fs (mmcblk0p2): recovery complete
[    6.300000] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
[    6.300000] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    6.310000] Freeing init memory: 128K
init started: BusyBox v1.15.0 ()
...
