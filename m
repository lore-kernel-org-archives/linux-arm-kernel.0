From: cjb@laptop.org (Chris Ball)
Date: Thu, 31 May 2012 17:11:01 -0400
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <CAN1soZz2=NcadK1kD6d9t92G6Xdfn=TPGP5_ngwX_fGj+QhOVA@mail.gmail.com>
 (Haojian Zhuang's message of "Thu, 31 May 2012 11:07:52 +0800")
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <1335515957-1798-4-git-send-email-haojian.zhuang@gmail.com>
 <87ehq1tq5w.fsf@laptop.org>
 <CAN1soZz2=NcadK1kD6d9t92G6Xdfn=TPGP5_ngwX_fGj+QhOVA@mail.gmail.com>
Message-ID: <87396gm4yi.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, May 30 2012, Haojian Zhuang wrote:
> I tested non-DT boot on my brownstone board on TTC dkb board.
>
> It seems that you meet issue in icu_mux_irq_demux(). Could you give me
> the detail which interrupt is running while you meet the error?
>
> By the way, do you have the boot log?

Here's the boot log -- you can see I added some more info to the
"Spurious IRQ" message.

Thanks,

- Chris.

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0e5c8...
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.4.0-44790-g83931a4-dirty (cjb at hydro) (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #27 PREEMPT Wed May 30 15:06:55 EDT 2012
[    0.000000] CPU: ARMv7 Processor [560f5815] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine: OLPC XO-1.75, model: 1B1
[    0.000000] cma: CMA: reserved 64 MiB at 1c000000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OLPC board revision 1B1 (EC api 4)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: ttyS2  no_console_suspend console=ttyS2,115200 console=tty0 fbcon=font:SUN12x22
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 444016k/444016k available, 80272k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0498f98   (4676 kB)
[    0.000000]       .init : 0xc0499000 - 0xc04bd000   ( 144 kB)
[    0.000000]       .data : 0xc04be000 - 0xc04ed4b8   ( 190 kB)
[    0.000000]        .bss : 0xc04ed4dc - 0xc055eecc   ( 455 kB)
[    0.000000] NR_IRQS:16 nr_irqs:368 368
[    0.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, wraps every 660764ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.040075] Calibrating delay loop... 795.44 BogoMIPS (lpj=3977216)
[    0.040135] pid_max: default: 32768 minimum: 301
[    0.040164] Mount-cache hash table entries: 512
[    0.042210] CPU: Testing write buffer coherency: ok
[    0.042372] Setting up static identity map for 0x3625a0 - 0x3625f8
[    0.044035] devtmpfs: initialized
[    0.044989] initlevel:0=early, 3 registered initcalls
[    0.044989] initlevel:1=core, 19 registered initcalls
[    0.050514] NET: Registered protocol family 16
[    0.050514] initlevel:2=postcore, 13 registered initcalls
[    0.058323] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.058323] Tauros2: Disabling L2 prefetch.
[    0.058384] Tauros2: L2 cache support initialised in ARMv7 mode.
[    0.058407] initlevel:3=arch, 3 registered initcalls
[    0.059230] pxa-gpio pxa-gpio: Failed to find gpio controller
[    0.060754] initlevel:4=subsys, 40 registered initcalls
[    0.063786] bio: create slab <bio-0> at 0
[    0.064405] SCSI subsystem initialized
[    0.064405] usbcore: registered new interface driver usbfs
[    0.064537] usbcore: registered new interface driver hub
[    0.064746] usbcore: registered new device driver usb
[    0.065034] i2c-gpio i2c-gpio.6: using pins 110 (SDA) and 161 (SCL)
[    0.065034] i2c-gpio i2c-gpio.7: using pins 109 (SDA) and 108 (SCL)
[    0.065486] I2C: i2c-3: PXA I2C adapter
[    0.065763] I2C: i2c-1: PXA I2C adapter
[    0.066026] I2C: i2c-0: PXA I2C adapter
[    0.066075] Linux video capture interface: v2.00
[    0.066075] Advanced Linux Sound Architecture Driver Version 1.0.25.
[    0.066928] cfg80211: Calling CRDA to update world regulatory domain
[    0.067233] initlevel:5=fs, 15 registered initcalls
[    0.067381] Switching to clocksource clocksource
[    0.074416] NET: Registered protocol family 2
[    0.074862] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.074862] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.075290] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.075541] TCP: Hash tables configured (established 16384 bind 16384)
[    0.075694] TCP: reno registered
[    0.075721] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.075743] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.075778] NET: Registered protocol family 1
[    0.075990] Trying to unpack rootfs image as initramfs...
[    0.126224] Freeing initrd memory: 4548K
[    0.126224] initlevel:6=device, 150 registered initcalls
[    0.128223] VFS: Disk quotas dquot_6.5.2
[    0.128351] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.129006] msgmni has been set to 1004
[    0.129679] io scheduler noop registered
[    0.129704] io scheduler deadline registered
[    0.129735] io scheduler cfq registered (default)
[    0.147410] Console: switching to colour frame buffer device 100x40
[    0.165729] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq = 24) is a UART3
[    0.604763] console [ttyS2] enabled
[    0.613511] brd: module loaded
[    0.613712] OLPC XO-1.75 Embedded Controller driver probed
[    0.622654] input: Power Button as /devices/platform/olpc-ec-1.75.0/input/input0
[    0.647411] input: OLPC OLS notify as /devices/platform/olpc-ols.0/input/input1
[    0.660453] OLPC Outdoor Light Sensor driver probed
[    0.670807] OLPC XO-1.75 lid and ebook switches
[    0.680812] input: OLPC lid switch as /devices/virtual/input/input2
[    0.692890] input: OLPC ebook switch as /devices/virtual/input/input3
[    0.705720] usbcore: registered new interface driver ipheth
[    0.717368] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.729787] pxau2o-ehci pxau2o-ehci.0: pxa9xx ehci
[    0.740594] pxau2o-ehci pxau2o-ehci.0: new USB bus registered, assigned bus number 1
[    0.756209] pxau2o-ehci pxau2o-ehci.0: irq 44, io mem 0xd4208000
[    0.787420] pxau2o-ehci pxau2o-ehci.0: USB 2.0 started, EHCI 1.00
[    0.799530] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.812178] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.825201] usb usb1: Product: pxa9xx ehci
[    0.834973] usb usb1: Manufacturer: Linux 3.4.0-44790-g83931a4-dirty ehci_hcd
[    0.847854] usb usb1: SerialNumber: pxau2o-ehci.0
[    0.858798] hub 1-0:1.0: USB hub found
[    0.868222] hub 1-0:1.0: 1 port detected
[    0.877770] Initializing USB Mass Storage driver...
[    0.888467] usbcore: registered new interface driver usb-storage
[    0.900160] USB Mass Storage support registered.
[    0.910406] usbcore: registered new interface driver libusual
[    0.921801] usbcore: registered new interface driver mdc800
[    0.932865] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
[    0.946314] usbcore: registered new interface driver usbserial
[    0.957782] usbcore: registered new interface driver usbserial_generic
[    0.969927] USB Serial support registered for generic
[    0.980620] usbserial: USB Serial Driver core
[    0.990928] OLPC SP keyboard/touchpad driver probed
[    1.052001] Spurious irq 17, i 8, max_icu_nr is 8, in MMP INTC
[    1.111662] Spurious irq 17, i 8, max_icu_nr is 8, in MMP INTC
[    1.162916] Spurious irq 17, i 8, max_icu_nr is 8, in MMP INTC
[repeat forever]

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
