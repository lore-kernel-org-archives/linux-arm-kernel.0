From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2012 13:18:22 -0300
Subject: [PATCH v6 00/14] add imx usb driver based on Greg next tree
In-Reply-To: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <CAOMZO5BEVrPrgZ7E5xUE-_3zXb317mzqoZXaxXw1SNACuRzOPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard/Shawn,

On Thu, Jun 21, 2012 at 3:41 AM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> The work is based on ?ci13xxx rework done by Alexander Shishkin.
>
> To let Greg pick up, I also added patches Alex queued that I depends on.
> Patch #1 - #9 : It can also be found at
> http://github.com/virtuoso/linux-ci.git ci
>
> This patch series can also be found at:
> https://github.com/riczhao/kernel-imx/commits/topics/usb-driver
>
> Status:
> ?- this version only support host
> ?- usbotg controler works at host role

I am testing this series on a mx23 board and I am getting:

LLLLLLLFCLJUncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.5.0-rc3-00370-g4c6d617-dirty (fabio at fabio-Latitu2
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Freescale i.MX23 (Device Tree), model: i.MX23 Olinuxinod
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pa6
[    0.000000] Kernel command line: noinitrd console=ttyAMA0,115200 root=/dev/me
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 64MB = 64MB total
[    0.000000] Memory: 54584k/54584k available, 10952k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc046506c   (4469 kB)
[    0.000000]       .init : 0xc0466000 - 0xc0487000   ( 132 kB)
[    0.000000]       .data : 0xc0488000 - 0xc04c85c0   ( 258 kB)
[    0.000000]        .bss : 0xc04c85e4 - 0xc0a149e0   (5425 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, 1
[    0.000000] NR_IRQS:304
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps eves
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingr
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
[    0.080000] Setting up static identity map for 0x4032adc8 - 0x4032ae20
[    0.090000] devtmpfs: initialized
[    0.110000] pinctrl core: initialized pinctrl subsystem
[    0.110000] dummy:
[    0.120000] NET: Registered protocol family 16
[    0.150000] Serial: AMBA PL011 UART driver
[    0.150000] 80070000.serial: ttyAMA0 at MMIO 0x80070000 (irq = 0) is a PL0112
[    0.320000] console [ttyAMA0] enabled
[    0.360000] bio: create slab <bio-0> at 0
[    0.370000] mxs-dma 80004000.dma-apbh: initialized
[    0.380000] mxs-dma 80024000.dma-apbx: initialized
[    0.390000] usb0_vbus: 5000 mV
[    0.390000] SCSI subsystem initialized
[    0.400000] usbcore: registered new interface driver usbfs
[    0.400000] usbcore: registered new interface driver hub
[    0.410000] usbcore: registered new device driver usb
[    0.410000] Advanced Linux Sound Architecture Driver Version 1.0.25.
[    0.420000] Switching to clocksource mxs_timer
[    0.630000] NET: Registered protocol family 2
[    0.640000] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.650000] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.660000] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    0.660000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.670000] TCP: reno registered
[    0.680000] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.680000] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.690000] NET: Registered protocol family 1
[    0.700000] RPC: Registered named UNIX socket transport module.
[    0.700000] RPC: Registered udp transport module.
[    0.710000] RPC: Registered tcp transport module.
[    0.710000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.720000] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.800000] NFS: Registering the id_resolver key type
[    0.810000] Key type id_resolver registered
[    0.820000] msgmni has been set to 106
[    0.820000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major )
[    0.830000] io scheduler noop registered (default)
[    0.840000] uart-pl011 80070000.serial: no DMA platform data
[    0.850000] Initializing USB Mass Storage driver...
[    0.850000] usbcore: registered new interface driver usb-storage
[    0.860000] USB Mass Storage support registered.
[    0.870000] ci_hdrc ci_hdrc.0: doesn't support gadget
[    0.870000] ci_hdrc ci_hdrc.0: ChipIdea HDRC EHCI
[    0.880000] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    0.940000] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    0.950000] hub 1-0:1.0: USB hub found
[    0.960000] hub 1-0:1.0: 1 port detected
[    0.970000] mousedev: PS/2 mouse device common for all mice
[    0.970000] i2c /dev entries driver
[    1.020000] mxs-mmc 80010000.ssp: initialized
[    1.030000] usbcore: registered new interface driver usbhid
[    1.040000] usbhid: USB HID core driver
[    1.050000] TCP: cubic registered
[    1.060000] NET: Registered protocol family 17
[    1.070000] Key type dns_resolver registered
[    1.080000] registered taskstats version 1
[    1.080000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.090000] ALSA device list:
[    1.090000]   No soundcards found.
[    1.100000] Waiting for root device /dev/mmcblk0p2...
[    1.120000] mmc0: host does not support reading read-only switch. assuming w.
[    1.130000] mmc0: new high speed SDHC card at address 1234
[    1.140000] mmcblk0: mmc0:1234 SA08G 7.41 GiB
[    1.160000]  mmcblk0: p1 p2
[    1.220000] hub 1-0:1.0: unable to enumerate USB device on port 1

.....

[    2.800000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    3.020000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    3.240000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    3.460000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    3.680000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    3.900000] hub 1-0:1.0: unable to enumerate USB device on port 1
[    4.120000] hub 1-0:1.0: unable to enumerate USB device on port 1
... (continues forever)

Any suggestions as to how to make the driver work on mx23?

Thanks,

Fabio Estevam
