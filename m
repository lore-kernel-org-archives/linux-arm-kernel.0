From: paul.s.schilling@gmail.com (Paul Schilling)
Date: Thu, 1 Dec 2011 08:09:44 -0600
Subject: s3c2440 / s3c2416 broken
In-Reply-To: <046101ccaffb$22a23690$67e6a3b0$%kim@samsung.com>
References: <CAC=G6syKMJk+L+-_k+T37qHKzfpNz_TrYi-HTaufczLxJKEtkQ@mail.gmail.com>
 <CAC=G6swbDHZJ7fqu9LoYRiri6bg+M+VDZnG_-=ZfP9r=6YtVeg@mail.gmail.com>
 <CAJuYYwTQ-eCN1pTkgrthhUEdk5gr9oGGcO6MCKCWQAovsQVqcg@mail.gmail.com>
 <201111100859.02647.heiko@sntech.de>
 <CAC=G6szTvMLTPqzoVJ0LUe7xPV1gJmz4icBSvC868MJNY7B-Uw@mail.gmail.com>
 <CAJuYYwTriz5yhCCLxs+s4cJ-tqP3s8PE0fV3VhGvPYHvC3Bmvg@mail.gmail.com>
 <046101ccaffb$22a23690$67e6a3b0$%kim@samsung.com>
Message-ID: <CAC=G6swWsucRcrQTpGyFc4nZSwNpS-J38cuEUq3hZiOVM29jLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found the problem it was a merging error when I rebased my patch for
my RS485 addition to the UART driver.

I am however still having issues with the frame buffer displaying
horizontal doted lines that shift the next pixels?down by a number of
pixels when certain colors are displayed.

Thanks,
Paul

On Thu, Dec 1, 2011 at 1:30 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>
> Thomas Abraham wrote:
> >
> > Hi Paul,
> >
> > On 10 November 2011 21:27, Paul Schilling <paul.s.schilling@gmail.com>
> > wrote:
> > > Here is my boot log including some u-boot stuff. ?The trace in my boot
> > > log is concerning a
> > > still broken GPIO bank M access that appears broken.
> >
> > Thanks for the log. But I could find out the cause of this issue. I
> > will check again tomorrow with linux-3.2.0-rc1 on smdk2416. Any luck
> > when using ramdisk or any clue with git bisect?
> >
>
> Hi Paul,
>
> The problem still happens on your board now?
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> > >
> > > Thanks,
> > > Paul Schilling
> > >
> > > dm9000 i/o: 0x20000300, id: 0x90000a46
> > >
> > > DM9000: running in 16 bit mode
> > >
> > > MAC: 12:23:34:88:99:00
> > >
> > > BOOTP broadcast 1
> > >
> > > BOOTP broadcast 2
> > >
> > > BOOTP broadcast 3
> > >
> > > DHCP client bound to address 10.5.16.68
> > >
> > > TFTP from server 10.5.16.63; our IP address is 10.5.16.68
> > >
> > > Filename 'schilpa/uImage-dev.bin'.
> > >
> > > Load address: 0xc0008000
> > >
> > > Loading: *
> > #################################################################
> > >
> > >
> #################################################################
> > >
> > >
> #################################################################
> > >
> > >
> #################################################################
> > >
> > >
> #################################################################
> > >
> > >
> #################################################################
> > >
> > >
> #################################################################
> > >
> > > ? ? ? ? ##################################
> > >
> > > done
> > >
> > > Bytes transferred = 2501760 (0x262c80)
> > >
> > > get_format
> > >
> > > -------- 1 --------
> > >
> > > ## Booting kernel from Legacy Image at c0008000 ...
> > >
> > > ? Image Name: ? Linux-3.2.0-rc1+
> > >
> > > ? Created: ? ? ?2011-11-09 ?23:23:05 UTC
> > >
> > > ? Image Type: ? ARM Linux Kernel Image (uncompressed)
> > >
> > > ? Data Size: ? ?2501696 Bytes = ?2.4 MB
> > >
> > > ? Load Address: 30008000
> > >
> > > ? Entry Point: ?30008000
> > >
> > > ? Verifying Checksum ... OK
> > >
> > > get_format
> > >
> > > -------- 1 --------
> > >
> > > ? Loading Kernel Image ... OK
> > >
> > > OK
> > >
> > >
> > >
> > > Starting kernel ...
> > >
> > >
> > >
> > > Uncompressing Linux... done, booting the kernel.
> > >
> > > Linux version 3.2.0-rc1+ (####) (gcc version 4.3.3 (GCC) ) #53 PREEMPT
> > > Wed Nov 9 17:23:00 CST 2011
> > >
> > > CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> > >
> > > CPU: VIVT data cache, VIVT instruction cache
> > >
> > > Machine: CONDOR2416
> > >
> > > Memory policy: ECC disabled, Data cache writeback
> > >
> > > CPU S3C2416/S3C2450 (id 0x32450003)
> > >
> > > S3C24XX Clocks, Copyright 2004 Simtec Electronics
> > >
> > > CPU: MPLL on 800.000 MHz, cpu 400.000 MHz, mem 133.333 MHz, pclk 66.666
> > MHz
> > >
> > > CPU: EPLL on 96.000 MHz, usb-bus 48.000 MHz
> > >
> > > On node 0 totalpages: 32768
> > >
> > > free_area_init_node: node 0, pgdat c050955c, node_mem_map c053e000
> > >
> > > ?Normal zone: 384 pages used for memmap
> > >
> > > ?Normal zone: 0 pages reserved
> > >
> > > ?Normal zone: 32384 pages, LIFO batch:7
> > >
> > > pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> > >
> > > pcpu-alloc: [0] 0
> > >
> > > Built 1 zonelists in Zone order, mobility grouping on. ?Total pages:
> > 32384
> > >
> > > Kernel command line: console=ttySAC0,115200 loglevel=8
> > >
> > s3cfb=dev:0,depth:16,xres:480,yres:272,vslen:60,hslen:17,left:41,right:68,
> > upper:26,lower:6,pixclock:0
> > > root=/dev/mtdblock4 rw rootfstype=jffs2 ethaddr=12:23:34:88:99:00
> > >
> > > PID hash table entries: 512 (order: -1, 2048 bytes)
> > >
> > > Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> > >
> > > Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> > >
> > > Memory: 64MB 64MB = 128MB total
> > >
> > > Memory: 124544k/124544k available, 6528k reserved, 0K highmem
> > >
> > > Virtual kernel memory layout:
> > >
> > > ? ?vector ?: 0xffff0000 - 0xffff1000 ? ( ? 4 kB)
> > >
> > > ? ?fixmap ?: 0xfff00000 - 0xfffe0000 ? ( 896 kB)
> > >
> > > ? ?vmalloc : 0xcc800000 - 0xf6000000 ? ( 664 MB)
> > >
> > > ? ?lowmem ?: 0xc0000000 - 0xcc000000 ? ( 192 MB)
> > >
> > > ? ?modules : 0xbf000000 - 0xc0000000 ? ( ?16 MB)
> > >
> > > ? ? ?.text : 0xc0008000 - 0xc04992b8 ? (4677 kB)
> > >
> > > ? ? ?.init : 0xc049a000 - 0xc04dd000 ? ( 268 kB)
> > >
> > > ? ? ?.data : 0xc04de000 - 0xc0509c00 ? ( 175 kB)
> > >
> > > ? ? ? .bss : 0xc0509c24 - 0xc053d764 ? ( 207 kB)
> > >
> > > SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> > >
> > > NR_IRQS:99
> > >
> > > irq: clearing subpending status 00000003
> > >
> > > irq: clearing subpending status 00000002
> > >
> > > timer tcon=00500000, tcnt 2b66, tcfg 00000200,00000000, usec 0000170a
> > >
> > > Console: colour dummy device 80x30
> > >
> > > Calibrating delay loop... 197.88 BogoMIPS (lpj=98944)
> > >
> > > pid_max: default: 32768 minimum: 301
> > >
> > > Mount-cache hash table entries: 512
> > >
> > > CPU: Testing write buffer coherency: ok
> > >
> > > pinctrl core: initialized pinctrl subsystem
> > >
> > > NET: Registered protocol family 16
> > >
> > > ------------[ cut here ]------------
> > >
> > > WARNING: at arch/arm/mach-s3c2416/mach-condor2416.c:875
> > > condor2416_machine_init+0xbc/0x700()
> > >
> > > Modules linked in:
> > >
> > > [<c000de08>] (unwind_backtrace+0x0/0xec) from [<c001f6e0>]
> > > (warn_slowpath_common+0x48/0x60)
> > >
> > > [<c001f6e0>] (warn_slowpath_common+0x48/0x60) from [<c001f714>]
> > > (warn_slowpath_null+0x1c/0x24)
> > >
> > > [<c001f714>] (warn_slowpath_null+0x1c/0x24) from [<c049ea9c>]
> > > (condor2416_machine_init+0xbc/0x700)
> > >
> > > [<c049ea9c>] (condor2416_machine_init+0xbc/0x700) from [<c049bd64>]
> > > (customize_machine+0x20/0x30)
> > >
> > > [<c049bd64>] (customize_machine+0x20/0x30) from [<c00087c0>]
> > > (do_one_initcall+0xa4/0x16c)
> > >
> > > [<c00087c0>] (do_one_initcall+0xa4/0x16c) from [<c049a21c>]
> > > (kernel_init+0x7c/0x11c)
> > >
> > > [<c049a21c>] (kernel_init+0x7c/0x11c) from [<c0009d94>]
> > > (kernel_thread_exit+0x0/0x8)
> > >
> > > ---[ end trace 1b75b31a2719ed1c ]---
> > >
> > > s3c_fb_setup: option dev:0
> > >
> > > s3c_fb_setup: option depth:16
> > >
> > > s3c_fb_setup: option xres:480
> > >
> > > s3c_fb_setup: option yres:272
> > >
> > > s3c_fb_setup: option vslen:60
> > >
> > > s3c_fb_setup: option hslen:17
> > >
> > > s3c_fb_setup: option left:41
> > >
> > > s3c_fb_setup: option right:68
> > >
> > > s3c_fb_setup: option upper:26
> > >
> > > s3c_fb_setup: option lower:6
> > >
> > > s3c_fb_setup: option pixclock:0
> > >
> > > Condor2416: ?Start Set DM9K
> > >
> > > S3C Power Management, Copyright 2004 Simtec Electronics
> > >
> > > S3C2416: Initializing architecture
> > >
> > > S3C2416: IRQ Support
> > >
> > > S3C24XX DMA Driver, Copyright 2003-2006 Simtec Electronics
> > >
> > > DMA channel 0 at cc804000, irq 88
> > >
> > > DMA channel 1 at cc804100, irq 89
> > >
> > > DMA channel 2 at cc804200, irq 90
> > >
> > > DMA channel 3 at cc804300, irq 91
> > >
> > > DMA channel 4 at cc804400, irq 92
> > >
> > > DMA channel 5 at cc804500, irq 93
> > >
> > > s3c24xx-pwm s3c24xx-pwm.0: tin at 33333333, tdiv at 33333333,
> tin=divclk,
> > base 0
> > >
> > > bio: create slab <bio-0> at 0
> > >
> > > usbcore: registered new interface driver usbfs
> > >
> > > usbcore: registered new interface driver hub
> > >
> > > usbcore: registered new device driver usb
> > >
> > > s3c-i2c s3c2410-i2c: slave address 0x10
> > >
> > > s3c-i2c s3c2410-i2c: bus frequency set to 65 KHz
> > >
> > > s3c-i2c s3c2410-i2c: i2c-0: S3C I2C adapter
> > >
> > > Advanced Linux Sound Architecture Driver Version 1.0.24.
> > >
> > > NET: Registered protocol family 2
> > >
> > > IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> > >
> > > TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> > >
> > > TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> > >
> > > TCP: Hash tables configured (established 4096 bind 4096)
> > >
> > > TCP reno registered
> > >
> > > UDP hash table entries: 256 (order: 0, 4096 bytes)
> > >
> > > UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> > >
> > > NET: Registered protocol family 1
> > >
> > > RPC: Registered named UNIX socket transport module.
> > >
> > > RPC: Registered udp transport module.
> > >
> > > RPC: Registered tcp transport module.
> > >
> > > RPC: Registered tcp NFSv4.1 backchannel transport module.
> > >
> > > s3c-adc s3c24xx-adc: attached adc driver
> > >
> > > VFS: Disk quotas dquot_6.5.2
> > >
> > > Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> > >
> > > JFFS2 version 2.2. (NAND) (SUMMARY) ?? 2001-2006 Red Hat, Inc.
> > >
> > > msgmni has been set to 243
> > >
> > > io scheduler noop registered
> > >
> > > io scheduler deadline registered (default)
> > >
> > > io scheduler cfq registered
> > >
> > > Console: switching to colour frame buffer device 60x34
> > >
> > > s3c-fb s3c-fb: window 0: fb
> > >
> > > s3c2440-uart s3c2440-uart.0: port TX GPIO (-1)
> > >
> > > s3c2440-uart s3c2440-uart.0: port TX GPIO (-1)
> > >
> > > s3c2440-uart.0: ttySAC0 at MMIO 0x50000000 (irq = 70) is a S3C2440
> > >
> > > console [ttySAC0] enabled
> > >
> > > s3c2440-uart s3c2440-uart.1: port TX GPIO (13)
> > >
> > > s3c2440-uart s3c2440-uart.1: port TX GPIO (12)
> > >
> > > s3c2440-uart s3c2440-uart.1: Enable Hi Res Timer
> > >
> > > s3c2440-uart s3c2440-uart.1: Port (1) 485 Enabled
> > >
> > > s3c2440-uart.1: ttySAC1 at MMIO 0x50004000 (irq = 73) is a S3C2440
> > >
> > > s3c2440-uart s3c2440-uart.1: Initialize TX(1) GPIO
> > >
> > > s3c2440-uart s3c2440-uart.1: Initialize RX(1) GPIO
> > >
> > > s3c2440-uart s3c2440-uart.2: port TX GPIO (42)
> > >
> > > s3c2440-uart s3c2440-uart.2: port TX GPIO (41)
> > >
> > > s3c2440-uart s3c2440-uart.2: Enable Hi Res Timer
> > >
> > > s3c2440-uart s3c2440-uart.2: Port (2) 485 Enabled
> > >
> > > s3c2440-uart.2: ttySAC2 at MMIO 0x50008000 (irq = 76) is a S3C2440
> > >
> > > s3c2440-uart s3c2440-uart.2: Initialize TX(2) GPIO
> > >
> > > s3c2440-uart s3c2440-uart.2: Initialize RX(2) GPIO
> > >
> > > s3c2440-uart s3c2440-uart.3: port TX GPIO (-1)
> > >
> > > s3c2440-uart s3c2440-uart.3: port TX GPIO (-1)
> > >
> > > s3c2440-uart.3: ttySAC3 at MMIO 0x5000c000 (irq = 94) is a S3C2440
> > >
> > > brd: module loaded
> > >
> > > at24 0-0050: 512 byte 24c04 EEPROM, writable, 16 bytes/write
> > >
> > > mtdoops: mtd device (mtddev=name/number) must be supplied
> > >
> > > S3C24XX NAND Driver, (c) 2004 Simtec Electronics
> > >
> > > s3c24xx-nand s3c2412-nand: Tacls=3, 22ns Twrph0=8 60ns, Twrph1=3 22ns
> > >
> > > s3c24xx-nand s3c2412-nand: System booted from NAND
> > >
> > > s3c24xx-nand s3c2412-nand: NAND soft ECC
> > >
> > > NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB
> > > 3,3V 8-bit)
> > >
> > > Scanning device for bad blocks
> > >
> > > Bad eraseblock 0 at 0x000000000000
> > >
> > > Bad eraseblock 1 at 0x000000020000
> > >
> > > Bad eraseblock 864 at 0x000006c00000
> > >
> > > Bad eraseblock 1304 at 0x00000a300000
> > >
> > > Bad eraseblock 1336 at 0x00000a700000
> > >
> > > Creating 5 MTD partitions on "NAND":
> > >
> > > 0x000000000000-0x000000040000 : "u-boot"
> > >
> > > 0x000000040000-0x000000060000 : "u-boot-env"
> > >
> > > 0x000000060000-0x000000560000 : "kernel"
> > >
> > > 0x000000560000-0x000000660000 : "log"
> > >
> > > 0x000000660000-0x000010000000 : "root"
> > >
> > > dm9000 Ethernet Driver, V1.31
> > >
> > > eth0: dm9000a at cc85e300,cc860308 IRQ 53 MAC: 12:23:34:88:99:00
> > (platform data)
> > >
> > > ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > >
> > > s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
> > >
> > > s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
> > >
> > > s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000
> > >
> > > hub 1-0:1.0: USB hub found
> > >
> > > hub 1-0:1.0: 2 ports detected
> > >
> > > usbcore: registered new interface driver libusual
> > >
> > > mousedev: PS/2 mouse device common for all mice
> > >
> > > input: matrix-keypad as /devices/platform/matrix-keypad/input/input0
> > >
> > > S3C24XX RTC, (c) 2004,2006 Simtec Electronics
> > >
> > > s3c-rtc s3c2410-rtc: rtc disabled, re-enabling
> > >
> > > s3c-rtc s3c2410-rtc: rtc core: registered s3c as rtc0
> > >
> > > i2c /dev entries driver
> > >
> > > S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics
> > >
> > > s3c2410-wdt s3c2410-wdt: watchdog inactive, reset disabled, irq enabled
> > >
> > > cpuidle: using governor ladder
> > >
> > > sdhci: Secure Digital Host Controller Interface driver
> > >
> > > sdhci: Copyright(c) Pierre Ossman
> > >
> > > s3c-sdhci s3c-sdhci.1: clock source 0: hsmmc (133333333 Hz)
> > >
> > > s3c-sdhci s3c-sdhci.1: clock source 1: hsmmc (133333333 Hz)
> > >
> > > s3c-sdhci s3c-sdhci.1: clock source 2: hsmmc-if (96000000 Hz)
> > >
> > > Registered led device: mmc0::
> > >
> > > mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.1] using ADMA
> > >
> > > sdhci-pltfm: SDHCI platform and OF driver helper
> > >
> > > Registered led device: led1
> > >
> > > usbcore: registered new interface driver usbhid
> > >
> > > usbhid: USB HID core driver
> > >
> > > samsung_UDA134X SoC Audio driver
> > >
> > > UDA134X SoC Audio Codec
> > >
> > > asoc: uda134x-hifi <-> samsung-i2s.0 mapping ok
> > >
> > > ALSA device list:
> > >
> > > ?#0: SAMSUNG_UDA134X
> > >
> > > TCP cubic registered
> > >
> > > NET: Registered protocol family 17
> > >
> > > Registering the dns_resolver key type
> > >
> > > s3c-rtc s3c2410-rtc: setting system clock to 2011-11-04 19:30:44 UTC
> > > (1320435044)
> > >
> > > usb 1-1: new full-speed USB device number 2 using s3c2410-ohci
> > >
> > > VFS: Mounted root (jffs2 filesystem) on device 31:4.
> > >
> > > Freeing init memory: 268K
> > >
> > > On Thu, Nov 10, 2011 at 1:59 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > >> Hi Paul,
> > >>
> > >> Am Donnerstag, 10. November 2011, 01:14:59 schrieb Thomas Abraham:
> > >>> On 10 November 2011 05:00, Paul Schilling <paul.s.schilling@gmail.com>
> > >> wrote:
> > >>> > Boot past init slow - stalled when using jffs2 also.
> > >>> >
> > >>> > On Wed, Nov 9, 2011 at 4:12 PM, Paul Schilling
> > >>> >
> > >>> > <paul.s.schilling@gmail.com> wrote:
> > >>> >> Latest kernel 3.2.0-rc1 appears to break the following processors
> > >>> >> s3c2440 and s3c2416
> > >>> >>
> > >>> >> both appear to stall when init is executed on NFS. ?Also I ?lost
> > HSMMC
> > >>> >> on the s3c2416.
> > >>>
> > >>> Could you post a boot log of the kernel on the s3c2440 and s3c2416
> > boards?
> > >>
> > >> Also, is your out-of-tree kernel code available somewhere? [1]
> > >>
> > >> As my S3C2416 based platform didn't show any problems and has working
> > hsmmc
> > >> with 3.2-rc1 it would be cool to be able to compare both and see if we
> > differ
> > >> somehow.
> > >>
> > >>
> > >> Heiko
> > >>
> > >>
> > >> [1] Mine's at https://gitorious.org/oyo-
> > hack/kernel/commits/topic/board/sg060
> > >>
> > >
>
