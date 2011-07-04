From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 4 Jul 2011 21:58:05 +0300
Subject: Ooops with 2.6.39.2 on pxa270
Message-ID: <201107042158.05767.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there, I'm getting following oops on my device (Zipit Z2 with PXA270) with 
2.6.39.2. And I have no idea what can be wrong :( Ooops is not 100% 
reproducible, it happens in 50% of cases.

Regards
Vasily
-------------- next part --------------
[    0.000000] Linux version 2.6.39.2+ (anarsoul at anarsoul-laptop) (gcc version 4.5.2 (Gentoo 4.5.2 p1.0, pie-0.4.5) ) #73 PREEMPT Mon Jul 4 12:50:41 EEST 2011
[    0.000000] CPU: XScale-PXA270 [69054117] revision 7 (ARMv5TE), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Zipit Z2
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Run Mode clock: 208.00MHz (*16)
[    0.000000] Turbo Mode clock: 312.00MHz (*1.5, inactive)
[    0.000000] Memory clock: 104.00MHz (/2)
[    0.000000] System bus clock: 104.00MHz 
[    0.000000] On node 0 totalpages: 8192
[    0.000000] free_area_init_node: node 0, pgdat c04bfc34, node_mem_map c04f4000
[    0.000000]   Normal zone: 64 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 8128 pages, LIFO batch:0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
[    0.000000] Kernel command line: console=tty0 fbcon=rotate:3 root=/dev/mmcblk0p1 rootdelay=2
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Memory: 32MB = 32MB total
[    0.000000] Memory: 27376k/27376k available, 5392k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc2800000 - 0xe8000000   ( 600 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc002a000   ( 136 kB)
[    0.000000]       .text : 0xc002a000 - 0xc049e028   (4561 kB)
[    0.000000]       .data : 0xc04a0000 - 0xc04c02e0   ( 129 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:288 nr_irqs:288 288
[    0.000000] sched_clock: 32 bits at 3250kHz, resolution 307ns, wraps every 1321528ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.002652] Calibrating delay loop... 207.25 BogoMIPS (lpj=1036288)
[    0.070507] pid_max: default: 32768 minimum: 301
[    0.071345] Mount-cache hash table entries: 512
[    0.072917] CPU: Testing write buffer coherency: ok
[    0.076058] devtmpfs: initialized
[    0.088984] NET: Registered protocol family 16
[    0.263610] bio: create slab <bio-0> at 0
[    0.286132] I2C: i2c-0: PXA I2C adapter
[    0.295090] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    0.302873] cfg80211: Calling CRDA to update world regulatory domain
[    0.307520] Switching to clocksource oscr0
[    0.313948] Switched to NOHz mode on CPU #0
[    0.447281] NET: Registered protocol family 2
[    0.448619] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.450049] TCP established hash table entries: 1024 (order: 1, 8192 bytes)
[    0.450336] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.450519] TCP: Hash tables configured (established 1024 bind 1024)
[    0.450645] TCP reno registered
[    0.450749] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.450923] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.452176] NET: Registered protocol family 1
[    0.453881] RPC: Registered udp transport module.
[    0.454080] RPC: Registered tcp transport module.
[    0.454184] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.457478] PMU: registered new PMU device of type 0
[    0.459441] PXA CPU 27x max frequency not defined (pxa27x_maxfreq), assuming pxa271 with 416000kHz maxfreq
[    0.459724] PXA CPU frequency change support initialized
[    0.585525] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.585796] JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    0.594028] msgmni has been set to 53
[    0.600614] io scheduler noop registered (default)
[    1.072676] Console: switching to colour frame buffer device 80x40
[    1.089318] PXA Overlay driver loaded successfully!
[    1.094747] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 22) is a FFUART
[    1.098932] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 21) is a BTUART
[    1.102671] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 20) is a STUART
[    1.185400] brd: module loaded
[    1.224270] loop: module loaded
[    1.232923] physmap platform flash device: 00800000 at 00000000
[    1.234227] physmap-flash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000089 Chip ID 0x008865
[    1.234855] Intel/Sharp Extended Query Table at 0x0039
[    1.241059] Intel/Sharp Extended Query Table at 0x0039
[    1.246117] Intel/Sharp Extended Query Table at 0x0039
[    1.251603] Intel/Sharp Extended Query Table at 0x0039
[    1.256536] Intel/Sharp Extended Query Table at 0x0039
[    1.262040] Using auto-unlock on power-up/resume
[    1.266774] cfi_cmdset_0001: Erase suspend on write enabled
[    1.271723] erase region 0: offset=0x0,size=0x2000,blocks=8
[    1.271791] erase region 1: offset=0x10000,size=0x10000,blocks=127
[    1.271934] physmap-flash: 1 set(s) of 1 interleaved chips --> 16 partitions of 512 KiB
[    1.273517] RedBoot partition parsing not available
[    1.279154] Using physmap partition information
[    1.283872] Creating 4 MTD partitions on "physmap-flash":
[    1.288898] 0x000000000000-0x000000040000 : "U-Boot Bootloader"
[    1.304039] 0x000000040000-0x000000060000 : "U-Boot Environment"
[    1.320532] 0x000000060000-0x0000007e0000 : "Flash"
[    1.336999] 0x0000007e0000-0x000000800000 : "U-Boot Logo"
[    1.357709] pxa27x_udc: version 2008-04-18
[    1.366379] g_ether gadget: using random self ethernet address
[    1.372298] g_ether gadget: using random host ethernet address
[    1.380490] usb0: MAC 1e:e4:45:b6:1c:f8
[    1.385291] usb0: HOST MAC 1a:d9:ff:bc:cd:ee
[    1.390423] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    1.395066] g_ether gadget: g_ether ready
[    1.510344] mousedev: PS/2 mouse device common for all mice
[    1.520606] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    1.533647] input: pxa27x-keypad as /devices/platform/pxa27x-keypad/input/input1
[    1.555714] pxa-rtc pxa-rtc: rtc core: registered pxa-rtc as rtc0
[    1.563033] i2c /dev entries driver
[    1.574025] APM Battery Driver
[    1.585675] i2c-core: driver [z2-battery] using legacy suspend method
[    1.592798] i2c-core: driver [z2-battery] using legacy resume method
[    1.599346] cpuidle: using governor ladder
[    1.604072] cpuidle: using governor menu
[    1.618547] Registered led device: z2:green:wifi
[    1.620303] Registered led device: z2:green:charged
[    1.622026] Registered led device: z2:amber:charging
[    1.688236] mmc0: host does not support reading read-only switch. assuming write-enable.
[    1.697643] mmc0: new SD card at address b368
[    1.705471] mmcblk0: mmc0:b368 SDM   1.85 GiB 
[    1.716083]  mmcblk0: p1 p2
[    2.662940] asoc: wm8750-hifi <-> pxa2xx-i2s mapping ok
[    2.682478] input: Z2 Headset Jack as /devices/platform/soc-audio/sound/card0/input2
[    2.707261] ALSA device list:
[    2.712955]   #0: Z2
[    2.721013] TCP cubic registered
[    2.736445] NET: Registered protocol family 10
[    2.747227] IPv6 over IPv4 tunneling driver
[    2.757104] NET: Registered protocol family 17
[    2.763126] NET: Registered protocol family 15
[    2.768582] lib80211: common routines for IEEE802.11 drivers
[    2.773254] lib80211_crypt: registered algorithm 'NULL'
[    2.773301] Registering the dns_resolver key type
[    2.778269] XScale iWMMXt coprocessor detected.
[    2.790402] pxa-rtc pxa-rtc: setting system clock to 2000-01-01 00:00:23 UTC (946684823)
[    2.801899] Waiting 2sec before mounting root device...
[    4.825670] EXT2-fs (mmcblk0p1): warning: mounting unchecked fs, running e2fsck is recommended
[    4.849119] VFS: Mounted root (ext2 filesystem) on device 179:1.
[    4.864734] devtmpfs: mounted
[    4.876413] Freeing init memory: 136K
[    6.228984] EXT2-fs (mmcblk0p2): warning: mounting unchecked fs, running e2fsck is recommended
[    8.924225] ADDRCONF(NETDEV_UP): usb0: link is not ready
[   12.184781] libertas_spi: Libertas SPI driver
[   13.538495] libertas: 00:50:43:02:fe:01, fw 9.70.10p0, cap 0x0000030b
[   13.574865] libertas: wlan0: Marvell WLAN 802.11 adapter
[   13.923173] input: mouse-emul as /devices/virtual/input/input3
[   13.996957] Unable to handle kernel paging request at virtual address ffffffff
[   14.001638] pgd = c1b80000
[   14.003589] [ffffffff] *pgd=a1ffe821, *pte=00000000, *ppte=00000000
[   14.007694] Internal error: Oops: f3 [#1] PREEMPT
[   14.009804] last sysfs file: /sys/devices/platform/leds-gpio/leds/z2:green:charged/trigger
[   14.013988] Modules linked in: libertas_spi libertas
[   14.016165] CPU: 0    Not tainted  (2.6.39.2+ #73)
[   14.018394] PC is at get_task_pid+0x48/0x88
[   14.020613] LR is at proc_pid_make_inode+0x5c/0xe8
[   14.022788] pc : [<c0055158>]    lr : [<c00f3ecc>]    psr: a0000093
[   14.022803] sp : c1b37e68  ip : 29209082  fp : c1b37f80
[   14.029128] r10: c1430a80  r9 : c00bb468  r8 : c1402180
[   14.031292] r7 : c1ada3a0  r6 : c1b37ecc  r5 : c185e000  r4 : c1563d38
[   14.035608] r3 : c1b36000  r2 : a0000013  r1 : a0000093  r0 : ffffffff
[   14.040141] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   14.044834] Control: 0000397f  Table: a1b80000  DAC: 00000015
[   14.047243] Process start-stop-daem (pid: 602, stack limit = 0xc1b36278)
[   14.051937] Stack: (0xc1b37e68 to 0xc1b38000)
[   14.054339] 7e60:                   c185e000 c1563d38 c1563d38 c00f3ecc 386d43a2 29209082
[   14.059112] 7e80: c1430a80 c1b37f20 c1b37ecc c00f60bc 00000000 00000003 c1b37f20 c00f68a8
[   14.063890] 7ea0: 00000109 00000000 c1b37f20 0000000d 00000000 00000009 ff0a0210 ffffffff
[   14.068719] 7ec0: c00bb468 c1ada380 c185e000 0011ad15 00000003 c1b37f20 c1b37f20 c1ada380
[   14.073622] 7ee0: c185e000 00000094 c00bb468 c1b37f80 c1b37f20 c1ada3a0 00000000 c00f7ba8
[   14.078575] 7f00: c1b37f20 00000003 c00f60a8 c185e000 00000000 c1404018 c04aad8c c182c000
[   14.083564] 7f20: 00383431 c1ada380 c00bb468 c1ada380 00000094 c185e000 c1b36000 c1ada380
[   14.088641] 7f40: c00bb468 c1404030 00000000 c1404018 c1b36000 00020000 00000000 c00bb788
[   14.093832] 7f60: c04a21f8 c1b37f80 00000000 002dc038 00008000 c1ada380 c002b1c4 c00bb8c8
[   14.099061] 7f80: 002dc720 002dc708 00007918 ffffffea beea3c4c 002dc038 00000000 002dc020
[   14.104386] 7fa0: 000000d9 c002b040 002dc038 00000000 00000003 002dc038 00008000 00000000
[   14.109734] 7fc0: 002dc038 00000000 002dc020 000000d9 002dc020 00000000 00000006 00000000
[   14.115080] 7fe0: 401fa9b4 beea3c50 401faa54 401fa978 60000010 00000003 00000000 00000000
[   14.120482] [<c0055158>] (get_task_pid+0x48/0x88) from [<c00f3ecc>] (proc_pid_make_inode+0x5c/0xe8)
[   14.125923] [<c00f3ecc>] (proc_pid_make_inode+0x5c/0xe8) from [<c00f60bc>] (proc_pid_instantiate+0x14/0xc0)
[   14.131415] [<c00f60bc>] (proc_pid_instantiate+0x14/0xc0) from [<c00f68a8>] (proc_fill_cache.clone.8+0x140/0x160)
[   14.136930] [<c00f68a8>] (proc_fill_cache.clone.8+0x140/0x160) from [<c00f7ba8>] (proc_pid_readdir+0x184/0x238)
[   14.142434] [<c00f7ba8>] (proc_pid_readdir+0x184/0x238) from [<c00bb788>] (vfs_readdir+0x90/0xb0)
[   14.147915] [<c00bb788>] (vfs_readdir+0x90/0xb0) from [<c00bb8c8>] (sys_getdents64+0x6c/0xbc)
[   14.153397] [<c00bb8c8>] (sys_getdents64+0x6c/0xbc) from [<c002b040>] (ret_fast_syscall+0x0/0x2c)
[   14.158910] Code: 0a000006 e10f2000 e3821080 e121f001 (e5901000) 
[   14.164724] ---[ end trace 29a82aad57cab755 ]---
[   14.167761] note: start-stop-daem[602] exited with preempt_count 1
[   14.173645] BUG: scheduling while atomic: start-stop-daem/602/0x40000002
[   14.179836] Modules linked in: libertas_spi libertas
[   14.182706] [<c002f150>] (unwind_backtrace+0x0/0xf0) from [<c0395470>] (schedule+0x3a8/0x418)
[   14.188059] [<c0395470>] (schedule+0x3a8/0x418) from [<c0037404>] (__cond_resched+0x24/0x34)
[   14.193365] [<c0037404>] (__cond_resched+0x24/0x34) from [<c0395618>] (_cond_resched+0x3c/0x44)
[   14.198718] [<c0395618>] (_cond_resched+0x3c/0x44) from [<c00925c0>] (unmap_vmas+0x794/0x7f4)
[   14.203971] [<c00925c0>] (unmap_vmas+0x794/0x7f4) from [<c0098148>] (exit_mmap+0xf0/0x27c)
[   14.209323] [<c0098148>] (exit_mmap+0xf0/0x27c) from [<c003b52c>] (mmput+0x3c/0x11c)
[   14.214620] [<c003b52c>] (mmput+0x3c/0x11c) from [<c003f82c>] (exit_mm+0x144/0x194)
[   14.219916] [<c003f82c>] (exit_mm+0x144/0x194) from [<c004150c>] (do_exit+0x590/0x740)
[   14.225212] [<c004150c>] (do_exit+0x590/0x740) from [<c002df18>] (die+0x2bc/0x330)
[   14.230553] [<c002df18>] (die+0x2bc/0x330) from [<c0030308>] (__do_kernel_fault+0x68/0x88)
[   14.235878] [<c0030308>] (__do_kernel_fault+0x68/0x88) from [<c003215c>] (do_alignment+0x148/0x7c8)
[   14.241336] [<c003215c>] (do_alignment+0x148/0x7c8) from [<c002a254>] (do_DataAbort+0x30/0x9c)
[   14.246730] [<c002a254>] (do_DataAbort+0x30/0x9c) from [<c002ab4c>] (__dabt_svc+0x4c/0x60)
[   14.252054] Exception stack(0xc1b37e20 to 0xc1b37e68)
[   14.254748] 7e20: ffffffff a0000093 a0000013 c1b36000 c1563d38 c185e000 c1b37ecc c1ada3a0
[   14.260058] 7e40: c1402180 c00bb468 c1430a80 c1b37f80 29209082 c1b37e68 c00f3ecc c0055158
[   14.265322] 7e60: a0000093 ffffffff
[   14.268058] [<c002ab4c>] (__dabt_svc+0x4c/0x60) from [<c0055158>] (get_task_pid+0x48/0x88)
[   14.273474] [<c0055158>] (get_task_pid+0x48/0x88) from [<c00f3ecc>] (proc_pid_make_inode+0x5c/0xe8)
[   14.278896] [<c00f3ecc>] (proc_pid_make_inode+0x5c/0xe8) from [<c00f60bc>] (proc_pid_instantiate+0x14/0xc0)
[   14.284213] [<c00f60bc>] (proc_pid_instantiate+0x14/0xc0) from [<c00f68a8>] (proc_fill_cache.clone.8+0x140/0x160)
[   14.289573] [<c00f68a8>] (proc_fill_cache.clone.8+0x140/0x160) from [<c00f7ba8>] (proc_pid_readdir+0x184/0x238)
[   14.294870] [<c00f7ba8>] (proc_pid_readdir+0x184/0x238) from [<c00bb788>] (vfs_readdir+0x90/0xb0)
[   14.300187] [<c00bb788>] (vfs_readdir+0x90/0xb0) from [<c00bb8c8>] (sys_getdents64+0x6c/0xbc)
[   14.305460] [<c00bb8c8>] (sys_getdents64+0x6c/0xbc) from [<c002b040>] (ret_fast_syscall+0x0/0x2c)
