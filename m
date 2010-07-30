From: nitvishnoi@gmail.com (nitin vishnoi)
Date: Fri, 30 Jul 2010 09:25:39 +0530
Subject: not coming prompt in 2.6.33.6 kernel
In-Reply-To: <20100729090854.GC14880@n2100.arm.linux.org.uk>
References: <AANLkTikgB9OF6mRqZ2KgQYuCQ4JcF7N6oTJyUbrYq0t7@mail.gmail.com>
	<20100728094344.GA9142@trinity.fluff.org>
	<AANLkTikgq_Fb0ZfT-b+9zOA5w2pDpNgwnUqe919hAsnd@mail.gmail.com>
	<20100729090854.GC14880@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimUqNU_QMJ_-BoahtnJ=9kzzUkYnP=W4c_9vDs-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i am gettting the following error while porting 2.6.31.4 kernel on s3c2451
board.

Starting kernel ...


Uncompressing
Linux.......................................................................
done, booting the kernel.
Linux version 2.6.31.14 (root at ubntu-desktop) (gcc version 4.1.2) #19 Fri Jul
30 09:14:47 IST 2010
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: SMDK2450
Ignoring unrecognised tag 0x00000000
Memory policy: ECC disabled, Data cache writeback
CPU S3C2450 EVT3 (id 0x32450003)
SPA   epll  80200102  Mpll  80640061   clkdiv0 557
S3C24XX Clocks, (c) 2004 Simtec Electronics
S3C2450: mpll on 800.000 MHz, cpu 400.000 MHz, mem 133.333 MHz, pclk 66.666
MHz
S3C2450: epll on 96.000 MHz, usb-bus 48.000 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: root=/dev/ram0 initrd=0x30800000,8M ramdisk=24576
init=/bin/sh  console=ttySAC3,115200 mem=64M
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 54392KB available (1888K code, 245K data, 92K init, 0K highmem)
Hierarchical RCU implementation.
NR_IRQS:109
irq: clearing subpending status 02000006
irq: clearing subpending status 02000002
timer tcon=00000000, tcnt 28af, tcfg 00000f00,00000000, usec 00007ae2
Console: colour dummy device 80x30
s3c24xx_serial_init_ports: initialising ports...
console [ttySAC3] enabled
Calibrating delay loop... 398.95 BogoMIPS (lpj=997376)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
entered machine init
S3C Power Management, Copyright 2004 Simtec Electronics
S3C2450: Initialising architecture
SPA s3c2450_init
S3C2450: IRQ Support
bio: create slab <bio-0> at 0
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 8192K
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
ROMFS MTD (C) 2007 Red Hat, Inc.
msgmni has been set to 122
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
brd: module loaded
loop: module loaded
RAMDISK: gzip image found at block 0
uncompression error
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing init memory: 92K
Warning: unable to open an initial console.
Kernel panic - not syncing: Attempted to kill init!

what may be the reason.

On Thu, Jul 29, 2010 at 2:38 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Thu, Jul 29, 2010 at 09:53:11AM +0800, Wan ZongShun wrote:
> > >> Console: colour dummy device 80x30
> > >> console [ttySAC3] enabled
>
> Okay, so the kernel console driver appears...
>
> > >> Calibrating delay loop... 398.95 BogoMIPS (lpj=997376)
> > >> Mount-cache hash table entries: 512
> > >> CPU: Testing write buffer coherency: ok
> > >> NET: Registered protocol family 16
> > >> whats up blady
> > >> hello
> > >> entered machine init
> > >> S3C Power Management, Copyright 2004 Simtec Electronics
> > >> S3C2450: Initialising architecture
> > >> SPA s3c2450_init
> > >> S3C2450: IRQ Support
> > >> bio: create slab <bio-0> at 0
> > >> SCSI subsystem initialized
> > >> NET: Registered protocol family 2
> > >> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> > >> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> > >> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> > >> TCP: Hash tables configured (established 2048 bind 2048)
> > >> TCP reno registered
> > >> UDP hash table entries: 256 (order: 0, 4096 bytes)
> > >> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> > >> NET: Registered protocol family 1
> > >> Trying to unpack rootfs image as initramfs...
> > >> rootfs image is not initramfs (no cpio magic); looks like an initrd
> > >> Freeing initrd memory: 16384K
> > >> NetWinder Floating Point Emulator V0.97 (double precision)
> > >> JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
> > >> ROMFS MTD (C) 2007 Red Hat, Inc.
> > >> msgmni has been set to 120
> > >> alg: No test for stdrng (krng)
> > >> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> > >> io scheduler noop registered
> > >> io scheduler deadline registered
> > >> io scheduler cfq registered (default)
> > >> brd: module loaded
> > >> loop: module loaded
> > >> Uniform Multi-Platform E-IDE driver
> > >> ide-gd driver 1.18
> > >> ide-cd driver 5.00
> > >> PPP generic driver version 2.4.2
> > >> PPP Deflate Compression module registered
> > >> PPP BSD Compression module registered
> > >> PPP MPPE Compression module registered
> > >> NET: Registered protocol family 24
> > >> SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
> > >> CSLIP: code copyright 1989 Regents of the University of California.
> > >> mice: PS/2 mouse device common for all mice
> > >> TCP cubic registered
> > >> RAMDISK: gzip image found at block 0
> > >> EXT2-fs (ram0): warning: maximal mount count reached, running e2fsck
> is
> > >> recommended
> > >> VFS: Mounted root (ext2 filesystem) on device 1:0.
> > >> Freeing init memory: 116K
> > >> Warning: unable to open an initial console.
>
> But nowhere in these messages do I see the user-level tty drivers for the
> serial ports - which means that you don't have a userland console driver.
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100730/5c5aba6c/attachment-0001.html>
