From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 10:08:54 +0100
Subject: not coming prompt in 2.6.33.6 kernel
In-Reply-To: <AANLkTikgq_Fb0ZfT-b+9zOA5w2pDpNgwnUqe919hAsnd@mail.gmail.com>
References: <AANLkTikgB9OF6mRqZ2KgQYuCQ4JcF7N6oTJyUbrYq0t7@mail.gmail.com>
	<20100728094344.GA9142@trinity.fluff.org>
	<AANLkTikgq_Fb0ZfT-b+9zOA5w2pDpNgwnUqe919hAsnd@mail.gmail.com>
Message-ID: <20100729090854.GC14880@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 09:53:11AM +0800, Wan ZongShun wrote:
> >> Console: colour dummy device 80x30
> >> console [ttySAC3] enabled

Okay, so the kernel console driver appears...

> >> Calibrating delay loop... 398.95 BogoMIPS (lpj=997376)
> >> Mount-cache hash table entries: 512
> >> CPU: Testing write buffer coherency: ok
> >> NET: Registered protocol family 16
> >> whats up blady
> >> hello
> >> entered machine init
> >> S3C Power Management, Copyright 2004 Simtec Electronics
> >> S3C2450: Initialising architecture
> >> SPA s3c2450_init
> >> S3C2450: IRQ Support
> >> bio: create slab <bio-0> at 0
> >> SCSI subsystem initialized
> >> NET: Registered protocol family 2
> >> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> >> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> >> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> >> TCP: Hash tables configured (established 2048 bind 2048)
> >> TCP reno registered
> >> UDP hash table entries: 256 (order: 0, 4096 bytes)
> >> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> >> NET: Registered protocol family 1
> >> Trying to unpack rootfs image as initramfs...
> >> rootfs image is not initramfs (no cpio magic); looks like an initrd
> >> Freeing initrd memory: 16384K
> >> NetWinder Floating Point Emulator V0.97 (double precision)
> >> JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
> >> ROMFS MTD (C) 2007 Red Hat, Inc.
> >> msgmni has been set to 120
> >> alg: No test for stdrng (krng)
> >> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> >> io scheduler noop registered
> >> io scheduler deadline registered
> >> io scheduler cfq registered (default)
> >> brd: module loaded
> >> loop: module loaded
> >> Uniform Multi-Platform E-IDE driver
> >> ide-gd driver 1.18
> >> ide-cd driver 5.00
> >> PPP generic driver version 2.4.2
> >> PPP Deflate Compression module registered
> >> PPP BSD Compression module registered
> >> PPP MPPE Compression module registered
> >> NET: Registered protocol family 24
> >> SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
> >> CSLIP: code copyright 1989 Regents of the University of California.
> >> mice: PS/2 mouse device common for all mice
> >> TCP cubic registered
> >> RAMDISK: gzip image found at block 0
> >> EXT2-fs (ram0): warning: maximal mount count reached, running e2fsck is
> >> recommended
> >> VFS: Mounted root (ext2 filesystem) on device 1:0.
> >> Freeing init memory: 116K
> >> Warning: unable to open an initial console.

But nowhere in these messages do I see the user-level tty drivers for the
serial ports - which means that you don't have a userland console driver.
