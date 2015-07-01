From: jp.francois@cynove.com (jean-philippe francois)
Date: Wed, 1 Jul 2015 16:15:33 +0200
Subject: Oops at boot after commit 965278dcb8ab... when using split memory
 region
Message-ID: <CAGGh5h061qpus=RK-iDyzbc9xG+dJXy8AosuN=aryEVZCPPhtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

commit 965278dcb8ab0b1f666cc47937933c4be4aea48d, (ARM: 8356/1: mm:
handle non-pmd-aligned end of RAM) causes my dm3730 based board to
oops at boot when using a split memory description.

The kernel command line parameter is :
mem=55M at 0x80000000 mem=128M at 0x88000000

If the same board is booted without the mem argument, it boots to userspace.

Below is the bootlog.

Regards,
Jean-Philippe Fran?ois

6Booting Linux on physical CPU 0x0
5Linux version 4.1.0-rc1-ly-dtb.1+ (jp at pc24.home) (gcc version 4.6.3
(Sourcery CodeBench Lite 2012.03-57) ) #23 PREEMPT Wed Jul 1 16:07:56
CEST 2015
6CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
6CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
6Machine model: Cynove DSPCAM HDR
6Memory policy: Data cache writeback
7On node 0 totalpages: 13824
7free_area_init_node: node 0, pgdat c09751b0, node_mem_map c358a000
7  Normal zone: 108 pages used for memmap
7  Normal zone: 0 pages reserved
7  Normal zone: 13824 pages, LIFO batch:3
6CPU: All CPU(s) started in SVC mode.
6OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
7pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
7pcpu-alloc: [0] 0
6Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 13716
5Kernel command line: console=ttyO2,115200n8
mtdparts=omap2-nand.0:256k(xl),768k(uboot),6144k(boot1),6144k(boot2),6144k(boot3),-(usr)
ubi.mtd=5,2048 mem=55M at 0x80000000 mem=128M at 0x88000000 nohlt
imgaddr=0x100000
6PID hash table entries: 256 (order: -2, 1024 bytes)
6Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
6Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
6Memory: 44664K/55296K available (4939K kernel code, 370K rwdata,
1664K rodata, 2732K init, 119K bss, 10632K reserved, 0K cma-reserved)
5Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc067af34   (6604 kB)
      .init : 0xc067b000 - 0xc0926000   (2732 kB)
      .data : 0xc0926000 - 0xc0982b0c   ( 371 kB)
       .bss : 0xc0982b0c - 0xc09a0820   ( 120 kB)
6Preemptible hierarchical RCU implementation.
6NR_IRQS:16 nr_irqs:16 16
6IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
6Clocking rate (Crystal/Core/MPU): 19.2/400/600 MHz
6OMAP clockevent source: timer1 at 32768 Hz
6clocksource 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 58327039986419 ns
6sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every
65535999984741ns
6OMAP clocksource: 32k_counter at 32768 Hz
6Console: colour dummy device 80x30
6Calibrating delay loop... 597.60 BogoMIPS (lpj=2988032)
6pid_max: default: 32768 minimum: 301
6Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
6Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
6CPU: Testing write buffer coherency: ok
6ftrace: allocating 16849 entries in 50 pages
6Setting up static identity map for 0x800082c0 - 0x80008318
6devtmpfs: initialized
6VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
4omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
4omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
6clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
6pinctrl core: initialized pinctrl subsystem
6NET: Registered protocol family 16
6DMA: preallocated 256 KiB pool for atomic coherent allocations
6cpuidle: using governor ladder
6cpuidle: using governor menu
6Reprogramming SDRC clock to 400000000 Hz
6OMAP GPIO hardware version 2.5
omap-gpmc 6e000000.gpmc: GPMC revision 5.0
platform 48058000.ssi-controller: Cannot lookup hwmod 'ssi'
3/ocp/isp at 480bc000: could not get #iommu-cells for /ocp/mmu at 480bd400
6No ATAGs?6OMAP DMA hardware revision 5.0
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
1Unable to handle kernel paging request at virtual address e5907004
1pgd = c0004000
1[e5907004] *pgd=00000000
0Internal error: Oops: 5 [#1] PREEMPT ARM
dModules linked in:
dCPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-ly-dtb.1+ #23
dHardware name: Generic OMAP36xx (Flattened Device Tree)
dtask: c309ec00 ti: c30d2000 task.ti: c30d2000
PC is at __wake_up_common+0x30/0x88
LR is at __wake_up+0x54/0xac
pc : [<c005c894>]    lr : [<c005d134>]    psr: 60000193
sp : c30d3af0  ip : c30d3b20  fp : c30d3b1c
r10: 00000000  r9 : c30d3b54  r8 : 00000003
r7 : 00000001  r6 : 00000001  r5 : c35fcc88  r4 : c35fcc88
r3 : e5907004  r2 : 00000001  r1 : 00000003  r0 : e5906ff8
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000015
0Process swapper (pid: 1, stack limit = 0xc30d2208)
0Stack: (0xc30d3af0 to 0xc30d4000)
03ae0:                                     00000000 20000113 c35fcc88 00000001
03b00: 00000003 c30d3b54 c32c9280 00005000 c30d3b4c c30d3b20 c005d134 c005c870
03b20: c30d3b54 00000003 c30d3b4c c35fcc88 00000000 c35f5f80 c334ec60 00001000
03b40: c30d3b7c c30d3b50 c005d1e8 c005d0ec 00005000 c35f5f80 00000000 00000000
03b60: c334ec40 c35f5f80 00000000 c35f5f80 c30d3b94 c30d3b80 c00b8e98 c005d198
03b80: 00080005 00006000 c30d3bc4 c30d3b98 c00cc978 c00b8e64 00005000 00000000
03ba0: c30d3bc4 c30d3cec 00001000 c334ed14 c047b040 c00cc81c c30d3c24 c30d3bc8
03bc0: c00b87d4 c00cc828 00001000 00001000 c35f5f80 c007130c c00f74ac 00000001
03be0: 00001000 00000000 00005000 00000000 c35f5f80 c007130c 00000000 c32c9280
03c00: c30d3cec c30d3cc8 c309ec00 c32c9280 00000000 c334ed14 c30d3c6c c30d3c28
03c20: c00ba9f4 c00b86d0 c012b1cc c006b458 c334ec60 c30d3c78 c30d3cf8 c334ec60
03c40: c30d3cac 00006cf0 00000000 c30d3cec c30d3cc8 c32c9280 c334ec60 c32c9280
03c60: c30d3cbc c30d3c70 c00bac5c c00ba8ec 00000002 00000002 00000000 00000000
03c80: c007133c c334ecbc 00000000 00000000 c334ec60 c32c9280 00000000 c30d3d60
03ca0: 00006cf0 c067d3e4 00008000 c32eec80 c30d3d2c c30d3cc0 c00edb80 c00baa74
03cc0: 00006cf0 00000001 c32c9280 00000000 00000000 00000000 00000000 00000000
03ce0: 00000000 00000000 c30d3d2c 00000003 00005000 00001cf0 c30d3d00 00000001
03d00: c3341310 00006cf0 c32c9280 c32c9280 00006cf0 c3341310 c30d3d60 c067d3e4
03d20: c30d3d5c c30d3d30 c00ee9ec c00edadc c01098cc c010983c c32c9280 c32c9280
03d40: 00006cf0 c3341310 c067d3e4 c32eec80 c30d3d84 c30d3d60 c00eec50 c00ee938
03d60: 00000000 00000000 00000000 00006cf0 c3341310 00000000 c30d3da4 c30d3d88
03d80: c067deac c00eec0c c06bec70 00006d74 00008000 c06dbda8 c30d3dbc c30d3da8
03da0: c067df90 c067de88 65706c65 c06bec70 c30d3dd4 c30d3dc0 c067d3cc c067def8
03dc0: 00006d74 c334128c c30d3df4 c30d3dd8 c067d458 c067d3a8 00000000 c3340000
03de0: c067d19c 00000000 c30d3e34 c30d3df8 c06a3c54 c067d3f0 00000000 c06a39d4
03e00: 00008000 c06dbda8 c30d3e34 c06a39e8 c067d19c 002489a2 c06dbda8 00000000
03e20: 00000000 00000000 c30d3e74 c30d3e38 c067d760 c06a39f4 00000000 c0982b94
03e40: c067d19c c30d3e50 c00eab38 c05b8358 c067e0a0 c328f040 00000000 00000000
03e60: c06dbb78 00000000 c30d3edc c30d3e78 c067e0c0 c067d5f0 c30d3eb4 c30d3e88
03e80: c026346c c02617c8 00000000 c30d3ed8 c30d3eb4 c067e0a0 05ed5e46 c328f040
03ea0: c328f040 c3551274 a0000113 c092a220 c30d3edc c30d3ec0 c067e0a0 c328f040
03ec0: 00000000 00000000 c06dbb78 00000000 c30d3f5c c30d3ee0 c00097d8 c067e0ac
03ee0: c3559c7c c05a2983 c30d3f0c c30d3ef8 c067b554 c025e200 c3559c6c 0000004e
03f00: c30d3f5c c30d3f10 c004f0a0 c067b544 00000000 c06bebc8 c30d3f34 00000005
03f20: 00000005 0000004e c0612e10 00000000 c30d3f5c 05ed5e46 00000005 c06bec00
03f40: c06bebe0 0000004e c06dbb78 00000000 c30d3f94 c30d3f60 c067be18 c00096b0
03f60: 00000005 00000005 c067b538 00000000 c30d3f94 c0982b40 c0469e70 00000000
03f80: 00000000 00000000 c30d3fac c30d3f98 c0469e8c c067bd30 c30d2000 00000000
03fa0: 00000000 c30d3fb0 c000fcd0 c0469e7c 00000000 00000000 00000000 00000000
03fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
03fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 c03f249c
[<c005c894>] (__wake_up_common) from [<c005d134>] (__wake_up+0x54/0xac)
[<c005d134>] (__wake_up) from [<c005d1e8>] (__wake_up_bit+0x5c/0x64)
[<c005d1e8>] (__wake_up_bit) from [<c00b8e98>] (unlock_page+0x40/0x44)
[<c00b8e98>] (unlock_page) from [<c00cc978>] (shmem_write_end+0x15c/0x178)
[<c00cc978>] (shmem_write_end) from [<c00b87d4>]
(generic_perform_write+0x110/0x1c0)
[<c00b87d4>] (generic_perform_write) from [<c00ba9f4>]
(__generic_file_write_iter+0x114/0x188)
[<c00ba9f4>] (__generic_file_write_iter) from [<c00bac5c>]
(generic_file_write_iter+0x1f4/0x28c)
[<c00bac5c>] (generic_file_write_iter) from [<c00edb80>] (__vfs_write+0xb0/0xdc)
[<c00edb80>] (__vfs_write) from [<c00ee9ec>] (vfs_write+0xc0/0x148)
[<c00ee9ec>] (vfs_write) from [<c00eec50>] (SyS_write+0x50/0x8c)
[<c00eec50>] (SyS_write) from [<c067deac>] (xwrite+0x30/0x70)
[<c067deac>] (xwrite) from [<c067df90>] (do_copy+0xa4/0xfc)
[<c067df90>] (do_copy) from [<c067d3cc>] (write_buffer+0x30/0x48)
[<c067d3cc>] (write_buffer) from [<c067d458>] (flush_buffer+0x74/0xa4)
[<c067d458>] (flush_buffer) from [<c06a3c54>] (gunzip+0x26c/0x334)
[<c06a3c54>] (gunzip) from [<c067d760>] (unpack_to_rootfs+0x17c/0x2d0)
[<c067d760>] (unpack_to_rootfs) from [<c067e0c0>] (populate_rootfs+0x20/0x230)
[<c067e0c0>] (populate_rootfs) from [<c00097d8>] (do_one_initcall+0x134/0x20c)
[<c00097d8>] (do_one_initcall) from [<c067be18>]
(kernel_init_freeable+0xf4/0x1bc)
[<c067be18>] (kernel_init_freeable) from [<c0469e8c>] (kernel_init+0x1c/0xf4)
[<c0469e8c>] (kernel_init) from [<c000fcd0>] (ret_from_fork+0x14/0x24)
0Code: e1a08001 e1a07002 e59b9004 e243000c (e5936000)
4---[ end trace dbef485dfbebe160 ]---
6note: swapper[1] exited with preempt_count 1
0Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

0---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
