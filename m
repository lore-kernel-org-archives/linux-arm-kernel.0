From: ecc@cmu.edu (Eric Cooper)
Date: Sat, 29 Jan 2011 17:48:31 -0500
Subject: kexec on kirkwood kernels?
In-Reply-To: <AANLkTintXocCNKz+XkbnJB9EPxqRvWpVQFBWVHcrxmQK@mail.gmail.com>
Message-ID: <20110129224831.GA1953@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What is the output of the failed bootup?

# kexec -e
[   57.233847] Starting new kernel
Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.38-rc1+ (ecc at stratocaster) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-188) ) #5 Sat Jan 29 14:52:49 EST 2011
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Seagate FreeAgent DockStar
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: earlyprintk console=ttyS0,115200
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 126836k/126836k available, 4236k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xfe800000   ( 864 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0023000   ( 108 kB)
[    0.000000]       .text : 0xc0023000 - 0xc02b4518   (2630 kB)
[    0.000000]       .data : 0xc02b6000 - 0xc02d32e0   ( 117 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:114

This output is identical to a correctly booting system as far as it
goes, but the system is hanging in a read to the Kirkwood register
virtual address space in "kirkwood_pcie_id".  If I comment this
operation out, the system hangs the next time it reads another
Kirkwood register, and so on.

Clearly something isn't in the same state after kexec that it was
after a hardware reset.  I'll try looking into the L2 cache issue,
thanks.

-- 
Eric Cooper             e c c @ c m u . e d u
