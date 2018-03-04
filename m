From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 4 Mar 2018 18:20:18 +0100
Subject: TS-x09 fails to boot when obtaining MAC
Message-ID: <20180304172018.c56ocfomqka4dzra@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several Debian users reported that Debian 9 (4.9 kernel) fails to boot
on their QNAP TS-x09 wheras Debian 8 (3.16) works fine.  One user
provided the following kernel log with earlyprintk.  I suspect the
issue was introduced in 4904dbda41c860fd117b20f3c48adb2780eee37e.

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-4-marvell (debian-kernel at lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 Debian 4.9.65-3 (2017-12-03)
[    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: QNAP TS-109/TS-209
[    0.000000] Clearing invalid memory bank 0KB at 0x00000000
[    0.000000] Clearing invalid memory bank 0KB at 0x00000000
[    0.000000] Clearing invalid memory bank 0KB at 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200n8 earlyprintk root=/dev/ram rw initrd=0x800000,0x3fffff
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 119792K/131072K available (3778K kernel code, 395K rwdata, 1128K rodata, 296K init, 249K bss, 11280K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03b8b98   (3779 kB)
[    0.000000]       .init : 0xc04f4000 - 0xc053e000   ( 296 kB)
[    0.000000]       .data : 0xc053e000 - 0xc05a0d78   ( 396 kB)
[    0.000000]        .bss : 0xc05a0d78 - 0xc05df35c   ( 250 kB)
[    0.000000] NR_IRQS:16 nr_irqs:65 65
[    0.000000] Switching to timer-based delay loop, resolution 6ns
[    0.000023] sched_clock: 32 bits at 166MHz, resolution 6ns, wraps every 12884901885ns
[   13.004006] clocksource: orion_clocksource: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 11467562657 ns
[   13.015612] Console: colour dummy device 80x30
[   13.020264] Calibrating delay loop (skipped), value calculated using timer frequency.. 333.33 BogoMIPS (lpj=666666)
[   13.030865] pid_max: default: 32768 minimum: 301
[   13.036032] Security Framework initialized
[   13.040280] Yama: disabled by default; enable with sysctl kernel.yama.*
[   13.047387] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[   13.054151] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[   13.063776] CPU: Testing write buffer coherency: ok
[   13.069101] ftrace: allocating 16964 entries in 34 pages
[   13.162371] Setting up static identity map for 0x8200 - 0x823c
[   13.175052] devtmpfs: initialized
[   13.181423] VFP support v0.3: not present
[   13.186057] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   13.195942] futex hash table entries: 256 (order: -1, 3072 bytes)
[   13.202738] pinctrl core: initialized pinctrl subsystem
[   13.211090] NET: Registered protocol family 16
[   13.216980] DMA: preallocated 256 KiB pool for atomic coherent allocations
[   13.232956] cpuidle: using governor ladder
[   13.237224] cpuidle: using governor menu
[   13.241425] Orion ID: MV88F5182-A2. TCLK=166666667.
[   13.246864]  00000003
 55550000[   13.250024]  03ff0000
[   13.252440]
[   13.254041]  00000003
 55550000[   13.257238]  03ff0500
[   13.259637]
[   13.266814] Unable to handle kernel paging request at virtual address c8886000
[   13.274195] pgd = c0004000
[   13.277037] [c8886000] *pgd=07833811, *pte=00000000, *ppte=00000000
[   13.283508] Internal error: Oops: 7 [#1] ARM
[   13.287859] Modules linked in:
[   13.291011] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-4-marvell #1 Debian 4.9.65-3
[   13.298998] Hardware name: QNAP TS-109/TS-209
[   13.303436] task: c78a0020 task.stack: c78a2000
[   13.308066] PC is at strlen+0x4/0x24
[   13.311732] LR is at mac_pton+0x10/0xb0
[   13.315660] pc : [<c01f7554>]    lr : [<c0215bec>]    psr: 20000053
[   13.315660] sp : c78a3eb0  ip : 00000000  fp : 00000000
[   13.327282] r10: c0523838  r9 : c053c628  r8 : c8885c00
[   13.332589] r7 : ffffffff  r6 : c78a3eca  r5 : c8885c00  r4 : f4707c00
[   13.339189] r3 : c8886000  r2 : 00000030  r1 : c8886000  r0 : c8885c00
[   13.345790] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
[   13.353082] Control: a005317f  Table: 00004000  DAC: 00000053
[   13.358905] Process swapper (pid: 1, stack limit = 0xc78a2190)
[   13.364814] Stack: (0xc78a3eb0 to 0xc78a4000)
[   13.369262] 3ea0:                                     f4707c00 ffffffff f4760000 ffffffff
[   13.377520] 3ec0: c8885c00 c04fbee8 f4700000 00060000 c052748c c0546620 ffffe000 00000000
[   13.385781] 3ee0: c05a0d80 c04fbd68 c04f6758 c054082c ffffe000 c04f6774 c04f6758 c000986c
[   13.394039] 3f00: 00000000 c78cad00 c03bb2cc c054082c 00000040 c05a0d00 00000000 c003ac1c
[   13.402300] 3f20: c7ffce94 c7ffce9b 0000003e c003ad34 c05c7554 c0049160 c04d2498 0000003e
[   13.410557] 3f40: 00000003 00000003 c04d2970 c04d2970 00000000 a4ae9beb 0000003e 00000004
[   13.418810] 3f60: 0000003e c05a0d80 c0523824 c05a0d80 c053c628 c04f4e64 00000003 00000003
[   13.427068] 3f80: 00000000 c04f459c 00000000 c03b4ed4 00000000 00000000 00000000 00000000
[   13.435319] 3fa0: 00000000 c03b4ee4 00000000 c000f610 00000000 00000000 00000000 00000000
[   13.443569] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   13.451820] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   13.460097] [<c01f7554>] (strlen) from [<c0215bec>] (mac_pton+0x10/0xb0)
[   13.466906] [<c0215bec>] (mac_pton) from [<c04fbee8>] (qnap_tsx09_find_mac_addr+0x3c/0x98)
[   13.475264] [<c04fbee8>] (qnap_tsx09_find_mac_addr) from [<c04fbd68>] (qnap_ts209_init+0x4c/0x10c)
[   13.484312] [<c04fbd68>] (qnap_ts209_init) from [<c04f6774>] (customize_machine+0x1c/0x30)
[   13.492666] [<c04f6774>] (customize_machine) from [<c000986c>] (do_one_initcall+0x150/0x188)
[   13.501192] [<c000986c>] (do_one_initcall) from [<c04f4e64>] (kernel_init_freeable+0x1c0/0x204)
[   13.509986] [<c04f4e64>] (kernel_init_freeable) from [<c03b4ee4>] (kernel_init+0x10/0xf0)
[   13.518253] [<c03b4ee4>] (kernel_init) from [<c000f610>] (ret_from_fork+0x14/0x24)
[   13.525901] Code: 1afffff9 e12fff1e c03e0a78 e1a03000 (e5d32000)
[   13.532147] ---[ end trace f0cd4d4c1f83d298 ]---
[   13.536952] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   13.536952]
[   13.546250] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   13.546250]
[   14.370296] random: fast init done
[   66.850433] random: crng init done

-- 
Martin Michlmayr
http://www.cyrius.com/
