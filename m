From: jphilippe.francois@gmail.com (jean-philippe francois)
Date: Fri, 26 Jun 2015 10:53:10 +0200
Subject: DT transition help :
Message-ID: <CAGGh5h1fvbDwih_BgV+7hupV9LrJGbhoDfBH-U4P6Y5u4w9D9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am in the process of transitioning a machine boardfile based kernel
(3.10.65) to a DT kernel, using a 4.1 kernel.

I have enabled a printascii hack in printk.c to get some output.

DTB is appended to zImage, and zImage contains an initramfs. The board
oops while unpacking initramfs, can you help me debug this ?

Attached is the dts file and the bootlog.

Regards,
Jean-Philippe Fran?ois
-------------- next part --------------
6Booting Linux on physical CPU 0x0
5Linux version 4.1.0-ly.1 (jp at pc24.home) (gcc version 4.6.3 (Sourcery CodeBench Lite 2012.03-57) ) #13 PREEMPT Fri Jun 26 10:20:29 CEST 2015
6CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
6CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
6Machine model: Cynove DSPCAM HDR
6Memory policy: Data cache writeback
7On node 0 totalpages: 13824
7free_area_init_node: node 0, pgdat c09c0d68, node_mem_map c358a000
7  Normal zone: 108 pages used for memmap
7  Normal zone: 0 pages reserved
7  Normal zone: 13824 pages, LIFO batch:3
6CPU: All CPU(s) started in SVC mode.
6OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
7pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
7pcpu-alloc: [0] 0 
6Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 13716
5Kernel command line: console=ttyO2,115200n8 mtdparts=omap2-nand.0:256k(xl),768k(uboot),6144k(boot1),6144k(boot2),6144k(boot3),-(usr) ubi.mtd=5,2048 mem=55M at 0x80000000 mem=128M at 0x88000000 nohlt imgaddr=0x700000
6PID hash table entries: 256 (order: -2, 1024 bytes)
6Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
6Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
6Memory: 44360K/55296K available (5175K kernel code, 370K rwdata, 1736K rodata, 2724K init, 119K bss, 10936K reserved, 0K cma-reserved)
5Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc06c8070   (6913 kB)
      .init : 0xc06c9000 - 0xc0972000   (2724 kB)
      .data : 0xc0972000 - 0xc09ceb94   ( 371 kB)
       .bss : 0xc09ceb94 - 0xc09ec8d8   ( 120 kB)
6Preemptible hierarchical RCU implementation.
6	Additional per-CPU info printed with stalls.
6NR_IRQS:16 nr_irqs:16 16
6IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
6Clocking rate (Crystal/Core/MPU): 19.2/400/600 MHz
6OMAP clockevent source: timer1 at 32768 Hz
6clocksource 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
6sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
6OMAP clocksource: 32k_counter at 32768 Hz
6Console: colour dummy device 80x30
6Calibrating delay loop... 594.73 BogoMIPS (lpj=2973696)
6pid_max: default: 32768 minimum: 301
6Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
6Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
6CPU: Testing write buffer coherency: ok
6ftrace: allocating 20237 entries in 60 pages
6Setting up static identity map for 0x800082c0 - 0x80008318
6devtmpfs: initialized
6VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
4omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
4omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
6clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
6pinctrl core: initialized pinctrl subsystem
6NET: Registered protocol family 16
6DMA: preallocated 256 KiB pool for atomic coherent allocations
6Reprogramming SDRC clock to 400000000 Hz
6OMAP GPIO hardware version 2.5
omap-gpmc 6e000000.gpmc: GPMC revision 5.0
platform 48058000.ssi-controller: Cannot lookup hwmod 'ssi'
6OMAP DMA hardware revision 5.0
omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
omap-iommu 480bd400.mmu: 480bd400.mmu registered
omap_i2c 48070000.i2c: bus 0 rev4.4 at 100 kHz
omap_i2c 48072000.i2c: bus 1 rev4.4 at 100 kHz
omap_i2c 48060000.i2c: bus 2 rev4.4 at 100 kHz
6media: Linux media interface: v0.10
6Linux video capture interface: v2.00
6cfg80211: Calling CRDA to update world regulatory domain
6Switched to clocksource 32k_counter
6NET: Registered protocol family 2
6TCP established hash table entries: 1024 (order: 0, 4096 bytes)
6TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
6TCP: Hash tables configured (established 1024 bind 1024)
6UDP hash table entries: 256 (order: 0, 4096 bytes)
6UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
6NET: Registered protocol family 1
1Unable to handle kernel NULL pointer dereference at virtual address 00000000
1pgd = c0004000
1[00000000] *pgd=00000000
0Internal error: Oops: 5 [#1] PREEMPT ARM
dModules linked in:
dCPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-ly.1 #13
dHardware name: Generic OMAP36xx (Flattened Device Tree)
dtask: c309ec00 ti: c30de000 task.ti: c30de000
PC is at __wake_up_common+0x30/0x88
LR is at __wake_up+0x54/0xac
pc : [<c005eee0>]    lr : [<c005f780>]    psr: 600001d3
sp : c30dfb10  ip : c30dfb40  fp : c30dfb3c
r10: 00000000  r9 : c30dfb74  r8 : 00000003
r7 : 00000001  r6 : 00000001  r5 : c35fcc88  r4 : c35fcc88
r3 : 00000000  r2 : 00000001  r1 : 00000003  r0 : fffffff4
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000015
0Process swapper (pid: 1, stack limit = 0xc30de208)
0Stack: (0xc30dfb10 to 0xc30e0000)
0fb00:                                     00000000 00000153 c35fcc88 00000001
0fb20: 00000003 c30dfb74 c32cfe80 00000000 c30dfb6c c30dfb40 c005f780 c005eebc
0fb40: c30dfb74 00000003 c30dfb6c c35fcc88 00000000 c35f5f80 00000000 0000007d
0fb60: c30dfb9c c30dfb70 c005f834 c005f738 c30dfc10 c35f5f80 00000000 00000000
0fb80: c00d2278 c35f5f80 c35fc000 c35f5f80 c30dfbb4 c30dfba0 c00be484 c005f7e4
0fba0: 00080005 0000007d c30dfbe4 c30dfbb8 c00d22d4 c00be450 00000000 00000000
0fbc0: c30dfbe4 c30dfd0c 0000007d c32b448c c04a2f80 c00d2178 c30dfc44 c30dfbe8
0fbe0: c00bdcb0 c00d2184 0000007d 0000007d c35f5f80 c00746a0 c30dfc1c 00000001
0fc00: 00001000 00000000 00000000 00000000 c35f5f80 c00746a0 00000000 c32cfe80
0fc20: c30dfd0c c30dfce8 c309ec00 c32cfe80 00000000 c32b448c c30dfc8c c30dfc48
0fc40: c00c0640 c00bdbac 00000002 c32b43d8 c30dfc74 c30dfc60 c00574f0 c00b01bc
0fc60: 00000000 0000007d 00000000 c30dfd0c c30dfce8 c32cfe80 c32b43d8 c32cfe80
0fc80: c30dfcdc c30dfc90 c00c08a8 c00c0538 00000000 00000000 00000000 00000000
0fca0: 00000000 c32b4434 00000000 00000000 c00746d0 c32cfe80 c30dfd90 0000007d
0fcc0: 00000000 c06cb4e0 00008000 c33612c0 c30dfd44 c30dfce0 c00f4b24 c00c06c0
0fce0: 0000007d 00000000 c32cfe80 00000000 00000000 00000000 00000000 00000000
0fd00: 00000000 00000000 c00574f0 00000003 00000000 0000007d c30dfd20 00000001
0fd20: c33a9040 0000007d 00000000 0000007d c33a9040 c30dfd90 c30dfd5c c30dfd48
0fd40: c00f4b84 c00f4aa4 c30dfd90 c32cfe80 c30dfd8c c30dfd60 c00f594c c00f4b54
0fd60: c0110e2c c0110d9c c32cfe80 c32cfe80 0000007d c33a9040 c06cb4e0 c33612c0
0fd80: c30dfdb4 c30dfd90 c00f5bb0 c00f5898 00000000 00000000 00000000 0000007d
0fda0: c33a9040 00000000 c30dfdd4 c30dfdb8 c06cc174 c00f5b6c c070d480 0000703c
0fdc0: 00008000 c072d474 c30dfdec c30dfdd8 c06cc1e0 c06cc150 00006fce c070d480
0fde0: c30dfe04 c30dfdf0 c06cb4c8 c06cc1c0 0000703c c33a8fc4 c30dfe24 c30dfe08
0fe00: c06cb554 c06cb4a4 00000000 c33a8000 c06cb298 00000000 c30dfe64 c30dfe28
0fe20: c06f2058 c06cb4ec 00000000 c06f1dd8 00008000 c072d474 c30dfe64 c06f1dec
0fe40: c09e162c 00243a90 c072d474 00000000 00000000 00000000 c30dfea4 c30dfe68
0fe60: c06cba4c c06f1df8 00000000 c09cec14 c06cb298 c3551274 a0000153 c05f199a
0fe80: c09cebc0 c06cc368 c0970f08 00000000 00000000 00000000 c30dfec4 c30dfea8
0fea0: c06cc384 c06cb8e0 c09cebc0 c06cc368 c3559b40 00000000 c30dff2c c30dfec8
0fec0: c00097a4 c06cc374 0000004c 00000005 c30dff00 c30dfee0 c0050ad4 c0050898
0fee0: 0000004c 00000005 00000005 c06c9650 c005f7a4 c064da88 c3559bec c3559bf4
0ff00: c30dff24 00000005 c070cbdc c3559b40 00000005 c072d240 c3559b40 00000000
0ff20: c30dff5c c30dff30 c06c9df4 c0009754 00000005 00000005 c06c9650 00000000
0ff40: 00000000 00000006 c0484b34 00000000 c30dff74 c30dff60 c06c9e40 c06c9d90
0ff60: c09e76dc c09cebc0 c30dff84 c30dff78 c06c9e74 c06c9e30 c30dff94 c30dff88
0ff80: c06c9ee4 c06c9e58 c30dffac c30dff98 c0484b50 c06c9e9c c30de000 00000000
0ffa0: 00000000 c30dffb0 c000fd58 c0484b40 00000000 00000000 00000000 00000000
0ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 87000281 58000100
[<c005eee0>] (__wake_up_common) from [<c005f780>] (__wake_up+0x54/0xac)
[<c005f780>] (__wake_up) from [<c005f834>] (__wake_up_bit+0x5c/0x64)
[<c005f834>] (__wake_up_bit) from [<c00be484>] (unlock_page+0x40/0x44)
[<c00be484>] (unlock_page) from [<c00d22d4>] (shmem_write_end+0x15c/0x178)
[<c00d22d4>] (shmem_write_end) from [<c00bdcb0>] (generic_perform_write+0x110/0x1c0)
[<c00bdcb0>] (generic_perform_write) from [<c00c0640>] (__generic_file_write_iter+0x114/0x188)
[<c00c0640>] (__generic_file_write_iter) from [<c00c08a8>] (generic_file_write_iter+0x1f4/0x28c)
[<c00c08a8>] (generic_file_write_iter) from [<c00f4b24>] (new_sync_write+0x8c/0xb0)
[<c00f4b24>] (new_sync_write) from [<c00f4b84>] (__vfs_write+0x3c/0x48)
[<c00f4b84>] (__vfs_write) from [<c00f594c>] (vfs_write+0xc0/0x148)
[<c00f594c>] (vfs_write) from [<c00f5bb0>] (SyS_write+0x50/0x8c)
[<c00f5bb0>] (SyS_write) from [<c06cc174>] (xwrite+0x30/0x70)
[<c06cc174>] (xwrite) from [<c06cc1e0>] (do_copy+0x2c/0xfc)
[<c06cc1e0>] (do_copy) from [<c06cb4c8>] (write_buffer+0x30/0x48)
[<c06cb4c8>] (write_buffer) from [<c06cb554>] (flush_buffer+0x74/0xa4)
[<c06cb554>] (flush_buffer) from [<c06f2058>] (gunzip+0x26c/0x334)
[<c06f2058>] (gunzip) from [<c06cba4c>] (unpack_to_rootfs+0x178/0x270)
[<c06cba4c>] (unpack_to_rootfs) from [<c06cc384>] (populate_rootfs+0x1c/0x100)
[<c06cc384>] (populate_rootfs) from [<c00097a4>] (do_one_initcall+0x5c/0xfc)
[<c00097a4>] (do_one_initcall) from [<c06c9df4>] (do_initcall_level+0x70/0xa0)
[<c06c9df4>] (do_initcall_level) from [<c06c9e40>] (do_initcalls+0x1c/0x28)
[<c06c9e40>] (do_initcalls) from [<c06c9e74>] (do_basic_setup+0x28/0x30)
[<c06c9e74>] (do_basic_setup) from [<c06c9ee4>] (kernel_init_freeable+0x54/0xe4)
[<c06c9ee4>] (kernel_init_freeable) from [<c0484b50>] (kernel_init+0x1c/0xf4)
[<c0484b50>] (kernel_init) from [<c000fd58>] (ret_from_fork+0x14/0x3c)
0Code: e1a08001 e1a07002 e59b9004 e243000c (e5936000) 
4---[ end trace a74022ea9af4f4a9 ]---
6note: swapper[1] exited with preempt_count 1
0Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

0---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

5random: nonblocking pool is initialized
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap3-cydm3730.dts
Type: application/octet-stream
Size: 1738 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150626/0f773e47/attachment.obj>
