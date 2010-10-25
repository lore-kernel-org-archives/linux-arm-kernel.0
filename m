From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Mon, 25 Oct 2010 23:12:39 +0200
Subject: hda interrupt timeouts on sa1110 + sa1111 board
Message-ID: <20101025211239.GD879@boggieman.bredbandsbolaget.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

First off I havent bisected this yet, but sounds more than likely
that it comes with the sa1111.c changes. It works fine in v2.6.34 also.

As you can see it progresses a bit but keeps loosing interrupts.

Best wishes
Kristoffer

HP Jornada# boot
## Booting kernel from Legacy Image at c0000000 ...
   Image Name:   Linux-2.6.36-hpc+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2185384 Bytes = 2.1 MiB
   Load Address: c0208000
   Entry Point:  c0208000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.36-hpc+ (kristoffer at boggieman) (gcc version 4.2.2) #5 Mon Oct 25 22:35:50 CEST 2010
[    0.000000] CPU: StrongARM-1110 [6901b118] revision 8 (ARMv4), cr=c020717f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: HP Jornada 720
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/hda1 console=ttySA0,19200n8 console=tty1
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 64MB 64MB = 128MB total
[    0.000000] Memory: 125568k/125568k available, 5504k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xe8000000   ( 504 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0208000 - 0xc0222000   ( 104 kB)
[    0.000000]       .text : 0xc0222000 - 0xc060b000   (4004 kB)
[    0.000000]       .data : 0xc060c000 - 0xc062c180   ( 129 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:120
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty1] enabled
[    0.000000] console [ttySA0] enabled
[   35.764397] Calibrating delay loop... 137.21 BogoMIPS (lpj=686080)
[   36.012168] pid_max: default: 32768 minimum: 301
[   36.041014] Mount-cache hash table entries: 512
[   36.070726] CPU: Testing write buffer coherency: ok
[   36.109241] NET: Registered protocol family 16
[   36.571019] SA1111 Microprocessor Companion Chip: silicon revision 1, metal revision 1
[   36.620753] sa1111-rab 0400: dmabounce: registered device
[   36.655131] sa1111-rab 0600: dmabounce: registered device
[   36.689427] sa1111-rab 0800: dmabounce: registered device
[   36.723702] sa1111-rab 0a00: dmabounce: registered device
[   36.758041] sa1111-rab 1800: dmabounce: registered device
[   36.876845] bio: create slab <bio-0> at 0
[   36.914978] NET: Registered protocol family 23
[   36.945301] cfg80211: Calling CRDA to update world regulatory domain
[   36.985597] Switching to clocksource oscr
[   37.136325] setting trigger mode 3 for irq 51 failed (sa1111_type_highirq+0x0/0x90)
[   37.182938] setting trigger mode 3 for irq 53 failed (sa1111_type_highirq+0x0/0x90)
[   37.229286] jornada720_pcmcia_configure_socket(): config socket 0 vcc 0 vpp 0
[   37.275407] setting trigger mode 3 for irq 52 failed (sa1111_type_highirq+0x0/0x90)
[   37.321979] setting trigger mode 3 for irq 54 failed (sa1111_type_highirq+0x0/0x90)
[   37.368329] jornada720_pcmcia_configure_socket(): config socket 1 vcc 0 vpp 0
[   37.415209] NET: Registered protocol family 2
[   37.442527] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[   37.486373] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[   37.530504] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[   37.570239] TCP: Hash tables configured (established 4096 bind 4096)
[   37.608734] TCP reno registered
[   37.627990] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   37.663606] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   37.702723] NET: Registered protocol family 1
[   37.731009] RPC: Registered udp transport module.
[   37.759616] RPC: Registered tcp transport module.
[   37.788218] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   37.833065] NetWinder Floating Point Emulator V0.97 (double precision)
[   37.883605] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   37.922102] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[   37.962784] JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[   38.001582] msgmni has been set to 245
[   38.025283] io scheduler noop registered
[   38.049163] io scheduler deadline registered
[   38.075491] io scheduler cfq registered (default)
[   38.104754] jornada720_pcmcia_configure_socket(): config socket 1 vcc 33 vpp 33
[   38.363534] HP Jornada 700 series backlight driver
[   38.394112] Epson S1D13XXX FB Driver
[   38.416551] s1d13xxxfb: chip production id 4 = S1D13506
[   38.448228] s1d13xxxfb: chip revision 1
[   38.471602] s1d13xxxfb: regs mapped at 0xc8a00000, fb 512 KiB mapped at 0xc8900000
[   38.519420] jornada720_pcmcia_configure_socket(): config socket 1 vcc 33 vpp 33
[   38.563830] jornada720_pcmcia_configure_socket(): config socket 1 vcc 33 vpp 33
[   38.690487] Console: switching to colour frame buffer device 80x30
[   38.819934] fb0: S1D13xxx frame buffer device
[   38.881851] pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1
[   39.003855] pcmcia 1.0: pcmcia: registering new device pcmcia1.0 (IRQ: 49)
[   39.142892] Serial: SA11x0 driver
[   39.201346] sa11x0-uart.1: ttySA1 at MMIO 0x80010000 (irq = 15) is a SA1100
[   39.285795] sa11x0-uart.3: ttySA0 at MMIO 0x80050000 (irq = 17) is a SA1100
[   39.400914] loop: module loaded
[   39.459181] nbd: registered device at major 43
[   39.585156] Uniform Multi-Platform E-IDE driver
[   39.652332] ide-gd driver 1.18
[   39.741358] mice: PS/2 mouse device common for all mice
[   39.812717] input: HP Jornada 720 keyboard as /class/input/input0
[   39.891238] input: HP Jornada 7xx Touchscreen as /class/input/input1
[   39.970397] sa1100-rtc sa1100-rtc: warning: initializing default clock divider/trim value
[   40.093835] sa1100-rtc sa1100-rtc: rtc core: registered sa1100-rtc as rtc0
[   40.174572] IPv4 over IPv4 tunneling driver
[   40.238903] GRE over IPv4 tunneling driver
[   40.302103] TCP cubic registered
[   40.355806] NET: Registered protocol family 17
[   40.416527] NET: Registered protocol family 15
[   40.478279] IrCOMM protocol (Dag Brattli)
[   40.589404] lib80211: common routines for IEEE802.11 drivers
[   40.662432] jornada720_pcmcia_configure_socket(): config socket 1 vcc 33 vpp 0
[   40.767874] jornada720_pcmcia_configure_socket(): config socket 1 vcc 33 vpp 0
[   41.220300] hda: SanDisk SDCFX3-8192, CFA DISK drive
[   42.002086] ide0 at 0xc8840000-0xc8840007,0xc884000e on irq 49
[   42.071940] isa bounce pool size: 16 pages
[   42.133597] hda: max request size: 128KiB
[   42.191639] hda: 16007040 sectors (8195 MB) w/1KiB Cache, CHS=15880/16/63
[   72.340242] hda: lost interrupt
[  102.500136] hda: lost interrupt
[  132.580134] hda: lost interrupt
[  162.660132] hda: lost interrupt
[  192.740138] hda: lost interrupt
[  192.786589]  hda: hda1 hda2
[  192.837397] ide-cs 1.0: ide-cs: hda: Vpp = 0.0
[  192.892128] sa1100-rtc sa1100-rtc: setting system clock to 1970-01-01 00:02:32 UTC (152)
[  223.060133] hda: lost interrupt
[  253.140164] hda: lost interrupt
[  283.220131] hda: lost interrupt
[  313.300134] hda: lost interrupt
[  343.380134] hda: lost interrupt
[  373.460134] hda: lost interrupt
[  403.540134] hda: lost interrupt
[  433.620132] hda: lost interrupt
[  463.700134] hda: lost interrupt
