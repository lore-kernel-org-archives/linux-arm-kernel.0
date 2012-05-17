From: snijsure@grid-net.com (Subodh Nijsure)
Date: Thu, 17 May 2012 16:03:43 -0700
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
Message-ID: <4FB583CF.2080801@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Should one be able to run top of the linux-next on MX28 EVK hardware 
with DT support enabled?
I have attached boot log I see when I try to do that.

Further if one enables, CONFIG_MTD_NAND_GPMI_NAND=y 
CONFIG_MTD_NAND_PLATFORM=y code in 
drivers/mtd/nand/gpmi-nand/gpmi-nand.c doesn't compile because of this code:

         pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
         if (IS_ERR(pinctrl)) {
                 ret = PTR_ERR(pinctrl);
                 goto exit_pin;
         }

-Subodh

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc7-next-20120516-dirty 
(snijsure at subodh-desktop) (gcc version 4.3.3 (Sour
cery G++ Lite 2009q1-203) ) #3 Thu May 17 15:40:42 PDT 2012
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Freescale i.MX28 (Device Tree), model: Freescale 
i.MX28 Evaluation Kit
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 16256
[    0.000000] Kernel command line: -e console=ttyAMA0,115200 
ip=192.168.137.2::192.168.137.254:255
.255.255.0::eth0: root=/dev/nfs 
nfsroot=192.168.137.254:/tftpboot/,v3,tcp noinitrd
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 64MB = 64MB total
[    0.000000] Memory: 55792k/55792k available, 9744k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0446220   (4345 kB)
[    0.000000]       .init : 0xc0447000 - 0xc046a000   ( 140 kB)
[    0.000000]       .data : 0xc046a000 - 0xc04a9f38   ( 256 kB)
[    0.000000]        .bss : 0xc04a9f5c - 0xc08e3c30   (4328 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, 
CPUs=1, Nodes=1
[    0.000000] NR_IRQS:304
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, 
wraps every 4294967286ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, 
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3679 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.080000] Calibrating delay loop... 226.09 BogoMIPS (lpj=1130496)
[    0.080000] pid_max: default: 32768 minimum: 301
[    0.080000] Mount-cache hash table entries: 512
[    0.090000] CPU: Testing write buffer coherency: ok
[    0.090000] Setting up static identity map for 0x4031baf8 - 0x4031bb50
[    0.100000] devtmpfs: initialized
[    0.100000] initlevel:0=early, 4 registered initcalls
[    0.100000] initlevel:1=core, 19 registered initcalls
[    0.100000] pinctrl core: initialized pinctrl subsystem
[    0.110000] dummy:
[    0.110000] NET: Registered protocol family 16
[    0.110000] initlevel:2=postcore, 12 registered initcalls
[    0.110000] initlevel:3=arch, 9 registered initcalls
[    0.120000] gpiochip_add: registered GPIOs 0 to 31 on device: gpio.0
[    0.120000] gpiochip_add: registered GPIOs 32 to 63 on device: gpio.1
[    0.120000] gpiochip_add: registered GPIOs 64 to 95 on device: gpio.2
[    0.120000] gpiochip_add: registered GPIOs 96 to 127 on device: gpio.3
[    0.120000] gpiochip_add: registered GPIOs 128 to 159 on device: gpio.4
[    0.130000] No ATAGs?
[    0.130000] Serial: AMBA PL011 UART driver
[    0.130000] 80074000.serial: ttyAMA0 at MMIO 0x80074000 (irq = 47) is 
a PL011 rev2
[    0.350000] console [ttyAMA0] enabled
[    0.360000] initlevel:4=subsys, 27 registered initcalls
[    0.380000] bio: create slab <bio-0> at 0
[    0.390000] mxs-dma 80004000.dma-apbh: initialized
[    0.400000] mxs-dma 80024000.dma-apbx: initialized
[    0.410000] 3P3V: 3300 mV
[    0.410000] Advanced Linux Sound Architecture Driver Version 1.0.25.
[    0.420000] initlevel:5=fs, 18 registered initcalls
[    0.420000] Switching to clocksource mxs_timer
[    0.550000] NET: Registered protocol family 2
[    0.550000] IP route cache hash table entries: 1024 (order: 0, 4096 
bytes)
[    0.560000] TCP established hash table entries: 2048 (order: 2, 16384 
bytes)
[    0.570000] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    0.580000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.580000] TCP: reno registered
[    0.590000] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    0.590000] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    0.600000] NET: Registered protocol family 1
[    0.610000] RPC: Registered named UNIX socket transport module.
[    0.610000] RPC: Registered udp transport module.
[    0.620000] RPC: Registered tcp transport module.
[    0.620000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.630000] initlevel:6=device, 110 registered initcalls
[    0.640000] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.680000] NFS: Registering the id_resolver key type
[    0.690000] Key type id_resolver registered
[    0.700000] msgmni has been set to 108
[    0.700000] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 253)
[    0.710000] io scheduler noop registered (default)
[    0.720000] uart-pl011 80074000.serial: no DMA platform data
[    0.790000] fec_enet_mii_bus: probed
[    0.800000] mousedev: PS/2 mouse device common for all mice
[    0.810000] i2c /dev entries driver
[    0.820000] stmp_reset_block(f5010000): module reset timeout
[    0.820000] INFO: trying to register non-static key.
[    0.820000] the code is fine but needs lockdep annotation.
[    0.820000] turning off the locking correctness validator.
[    0.820000] [<c0015134>] (unwind_backtrace+0x0/0xf8) from 
[<c005a154>] (__lock_acquire+0xb94/0xc1c)
[    0.820000] [<c005a154>] (__lock_acquire+0xb94/0xc1c) from 
[<c005a2c0>] (lock_acquire+0xe4/0xfc)
[    0.820000] [<c005a2c0>] (lock_acquire+0xe4/0xfc) from [<c031b3b0>] 
(_raw_spin_lock+0x2c/0x3c)
[    0.820000] [<c031b3b0>] (_raw_spin_lock+0x2c/0x3c) from [<c0243a24>] 
(mxs_mmc_irq_handler+0x1c/0x108)
[    0.820000] [<c0243a24>] (mxs_mmc_irq_handler+0x1c/0x108) from 
[<c0067a94>] (handle_irq_event_percpu+0x70/
0x250)
[    0.820000] [<c0067a94>] (handle_irq_event_percpu+0x70/0x250) from 
[<c0067cb0>] (handle_irq_event+0x3c/0x5
c)
[    0.820000] [<c0067cb0>] (handle_irq_event+0x3c/0x5c) from 
[<c006a3a0>] (handle_level_irq+0x8c/0x118)
[    0.820000] [<c006a3a0>] (handle_level_irq+0x8c/0x118) from 
[<c006763c>] (generic_handle_irq+0x34/0x40)
[    0.820000] [<c006763c>] (generic_handle_irq+0x34/0x40) from 
[<c00103dc>] (handle_IRQ+0x30/0x84)
[    0.820000] [<c00103dc>] (handle_IRQ+0x30/0x84) from [<c000f174>] 
(__irq_svc+0x34/0x60)
[    0.820000] [<c000f174>] (__irq_svc+0x34/0x60) from [<c031b8c8>] 
(_raw_spin_unlock_irqrestore+0x28/0x2c)
[    0.820000] [<c031b8c8>] (_raw_spin_unlock_irqrestore+0x28/0x2c) from 
[<c0068a08>] (__setup_irq+0x160/0x3f
c)
[    0.820000] [<c0068a08>] (__setup_irq+0x160/0x3fc) from [<c0068ec4>] 
(request_threaded_irq+0xc8/0x130)
[    0.820000] [<c0068ec4>] (request_threaded_irq+0xc8/0x130) from 
[<c006ab9c>] (devm_request_threaded_irq+0x
58/0x8c)
[    0.820000] [<c006ab9c>] (devm_request_threaded_irq+0x58/0x8c) from 
[<c0243840>] (mxs_mmc_probe+0x378/0x54
0)
[    0.820000] [<c0243840>] (mxs_mmc_probe+0x378/0x540) from 
[<c01ecf60>] (platform_drv_probe+0x18/0x1c)
[    0.820000] [<c01ecf60>] (platform_drv_probe+0x18/0x1c) from 
[<c01ebbc0>] (driver_probe_device+0x80/0x214)
[    0.820000] [<c01ebbc0>] (driver_probe_device+0x80/0x214) from 
[<c01ebde8>] (__driver_attach+0x94/0x98)
[    0.820000] [<c01ebde8>] (__driver_attach+0x94/0x98) from 
[<c01ea450>] (bus_for_each_dev+0x60/0x8c)
[    0.820000] [<c01ea450>] (bus_for_each_dev+0x60/0x8c) from 
[<c01eac30>] (bus_add_driver+0xb0/0x268)
[    0.820000] [<c01eac30>] (bus_add_driver+0xb0/0x268) from 
[<c01ec3b8>] (driver_register+0x58/0x12c)
[    0.820000] [<c01ec3b8>] (driver_register+0x58/0x12c) from 
[<c000879c>] (do_one_initcall+0x30/0x16c)
[    0.820000] [<c000879c>] (do_one_initcall+0x30/0x16c) from 
[<c0447328>] (kernel_init+0x110/0x1e4)
[    0.820000] [<c0447328>] (kernel_init+0x110/0x1e4) from [<c00104a8>] 
(kernel_thread_exit+0x0/0x8)
[    0.820000] BUG: spinlock lockup on CPU#0, swapper/1
[    0.820000]  lock: 0xc3992f24, .magic: 00000000, .owner: <none>/-1, 
.owner_cpu: 0
[    0.820000] [<c0015134>] (unwind_backtrace+0x0/0xf8) from 
[<c01b44fc>] (do_raw_spin_lock+0xec/0x140)
[    0.820000] [<c01b44fc>] (do_raw_spin_lock+0xec/0x140) from 
[<c0243a24>] (mxs_mmc_irq_handler+0x1c/0x108)
[    0.820000] [<c0243a24>] (mxs_mmc_irq_handler+0x1c/0x108) from 
[<c0067a94>] (handle_irq_event_percpu+0x70/
0x250)
[    0.820000] [<c0067a94>] (handle_irq_event_percpu+0x70/0x250) from 
[<c0067cb0>] (handle_irq_event+0x3c/0x5
c)
[    0.820000] [<c0067cb0>] (handle_irq_event+0x3c/0x5c) from 
[<c006a3a0>] (handle_level_irq+0x8c/0x118)
[    0.820000] [<c006a3a0>] (handle_level_irq+0x8c/0x118) from 
[<c006763c>] (generic_handle_irq+0x34/0x40)
[    0.820000] [<c006763c>] (generic_handle_irq+0x34/0x40) from 
[<c00103dc>] (handle_IRQ+0x30/0x84)
[    0.820000] [<c00103dc>] (handle_IRQ+0x30/0x84) from [<c000f174>] 
(__irq_svc+0x34/0x60)
[    0.820000] [<c000f174>] (__irq_svc+0x34/0x60) from [<c031b8c8>] 
(_raw_spin_unlock_irqrestore+0x28/0x2c)
[    0.820000] [<c031b8c8>] (_raw_spin_unlock_irqrestore+0x28/0x2c) from 
[<c0068a08>] (__setup_irq+0x160/0x3f
c)
[    0.820000] [<c0068a08>] (__setup_irq+0x160/0x3fc) from [<c0068ec4>] 
(request_threaded_irq+0xc8/0x130)
[    0.820000] [<c0068ec4>] (request_threaded_irq+0xc8/0x130) from 
[<c006ab9c>] (devm_request_threaded_irq+0x
58/0x8c)
[    0.820000] [<c006ab9c>] (devm_request_threaded_irq+0x58/0x8c) from 
[<c0243840>] (mxs_mmc_probe+0x378/0x54
0)
[    0.820000] [<c0243840>] (mxs_mmc_probe+0x378/0x540) from 
[<c01ecf60>] (platform_drv_probe+0x18/0x1c)
[    0.820000] [<c01ecf60>] (platform_drv_probe+0x18/0x1c) from 
[<c01ebbc0>] (driver_probe_device+0x80/0x214)
[    0.820000] [<c01ebbc0>] (driver_probe_device+0x80/0x214) from 
[<c01ebde8>] (__driver_attach+0x94/0x98)
[    0.820000] [<c01ebde8>] (__driver_attach+0x94/0x98) from 
[<c01ea450>] (bus_for_each_dev+0x60/0x8c)
[    0.820000] [<c01ea450>] (bus_for_each_dev+0x60/0x8c) from 
[<c01eac30>] (bus_add_driver+0xb0/0x268)
[    0.820000] [<c01eac30>] (bus_add_driver+0xb0/0x268) from 
[<c01ec3b8>] (driver_register+0x58/0x12c)
[    0.820000] [<c01ec3b8>] (driver_register+0x58/0x12c) from 
[<c000879c>] (do_one_initcall+0x30/0x16c)
[    0.820000] [<c000879c>] (do_one_initcall+0x30/0x16c) from 
[<c0447328>] (kernel_init+0x110/0x1e4)
[    0.820000] [<c0447328>] (kernel_init+0x110/0x1e4) from [<c00104a8>] 
(kernel_thread_exit+0x0/0x8
