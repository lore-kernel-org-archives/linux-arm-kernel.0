From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 28 Oct 2016 15:38:30 +0800
Subject: [PATCH v2 2/2] arm64: dts: hi6220: add resets property into
 dwmmc nodes
In-Reply-To: <d7993c1a-5e50-9a33-0900-5c1a79884d3c@samsung.com>
References: <1472094041-5357-1-git-send-email-guodong.xu@linaro.org>
 <1472094041-5357-2-git-send-email-guodong.xu@linaro.org>
 <CAKfTPtB0FtGbm4C5z+LJizrsHikKt_BGFti5XY+LN3w7zO1Vjw@mail.gmail.com>
 <CALAqxLXfb48h8hMQmAaJ+YjA5=pekkQ8Dg8ReL6VTTfmuFRPDw@mail.gmail.com>
 <CAKfTPtAXdkKcfpHmUmQNwuJxO0PORcCf49noST_CCkZPigPwgw@mail.gmail.com>
 <CGME20161028072654epcas4p13cbf983b3e22dd96039ed33a4ac792d5@epcas4p1.samsung.com>
 <20161028072640.GB17266@leoy-linaro>
 <d7993c1a-5e50-9a33-0900-5c1a79884d3c@samsung.com>
Message-ID: <20161028073830.GC17266@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 04:33:41PM +0900, Jaehoon Chung wrote:

[...]

> >>> Guodong: Is there any bootloader dependency on that change?
> >>
> >> FYI, I use firmwares available in AOSP
> > 
> > I tried latest firmware [1], still cannot boot up until revert the
> > patch "arm64: dts: hi6220: add resets property into dwmmc nodes".
> 
> Could you share the log? Is there any log about failure?

Sure, please see below log:

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc1-00251-g323792f (leoy at leoy-linaro) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) ) #589 SMP PREEMPT Fri Oct 28 15:35:15 CST 2016
[    0.000000] Boot CPU: AArch64 Processor [410fd033]
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.50 by hikey EFI Oct 26 2016 15:14:29
[    0.000000] efi:  PROP=0x3d8297d8 
[    0.000000] Reserved memory: created CMA memory pool at 0x000000002d000000, size 128 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] percpu: Embedded 21 pages/cpu @ffff80003df10000 s48000 r8192 d29824 u86016
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 249229
[    0.000000] Kernel command line: BOOT_IMAGE=(hd0,gpt6)/Image console=tty0 console=ttyAMA3,115200 root=/dev/disk/by-partlabel/system rootwait rw efi=noruntime
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 28672 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 65536 bytes
[    0.000000] early log buf free: 14468(88%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.000000] Memory: 841572K/1012788K available (8316K kernel code, 860K rwdata, 3668K rodata, 1024K init, 283K bss, 40144K reserved, 131072K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000088a0000   (  8320 KB)
[    0.000000]     .rodata : 0xffff0000088a0000 - 0xffff000008c40000   (  3712 KB)
[    0.000000]       .init : 0xffff000008c40000 - 0xffff000008d40000   (  1024 KB)
[    0.000000]       .data : 0xffff000008d40000 - 0xffff000008e17200   (   861 KB)
[    0.000000]        .bss : 0xffff000008e17200 - 0xffff000008e5e0c0   (   284 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0000f80000   (    15 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff80003e000000   (   992 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 1.20MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x11b661f8e, max_idle_ns: 1763180809113 ns
[    0.000004] sched_clock: 56 bits at 1200kHz, resolution 833ns, wraps every 4398046510838ns
[    0.000101] clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 99544814920 ns
[    0.000108] sched_clock: 32 bits at 19MHz, resolution 52ns, wraps every 111848106981ns
[    0.000495] Console: colour dummy device 80x25
[    0.001193] console [tty0] enabled
[    0.001224] Calibrating delay loop (skipped), value calculated using timer frequency.. 2.40 BogoMIPS (lpj=4800)
[    0.001253] pid_max: default: 32768 minimum: 301
[    0.001331] Security Framework initialized
[    0.001373] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.001392] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.002258] ASID allocator initialised with 65536 entries
[    0.032726] EFI runtime services will be disabled.
[    0.080274] Detected VIPT I-cache on CPU1
[    0.080323] CPU1: Booted secondary processor [410fd033]
[    0.112299] Detected VIPT I-cache on CPU2
[    0.112321] CPU2: Booted secondary processor [410fd033]
[    0.144348] Detected VIPT I-cache on CPU3
[    0.144369] CPU3: Booted secondary processor [410fd033]
[    0.176488] Detected VIPT I-cache on CPU4
[    0.176529] CPU4: Booted secondary processor [410fd033]
[    0.208479] Detected VIPT I-cache on CPU5
[    0.208501] CPU5: Booted secondary processor [410fd033]
[    0.240546] Detected VIPT I-cache on CPU6
[    0.240568] CPU6: Booted secondary processor [410fd033]
[    0.272610] Detected VIPT I-cache on CPU7
[    0.272632] CPU7: Booted secondary processor [410fd033]
[    0.272708] Brought up 8 CPUs
[    0.272887] SMP: Total of 8 processors activated.
[    0.272904] CPU features: detected feature: 32-bit EL0 Support
[    0.272975] CPU: All CPU(s) started at EL2
[    0.273028] alternatives: patching kernel code
[    0.273645] devtmpfs: initialized
[    0.278919] DMI not present or invalid.
[    0.279161] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.282522] pinctrl core: initialized pinctrl subsystem
[    0.283636] NET: Registered protocol family 16
[    0.300541] cpuidle: using governor menu
[    0.301073] vdso: 2 pages (1 code @ ffff0000088a7000, 1 data @ ffff000008d44000)
[    0.301106] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.301863] DMA: preallocated 256 KiB pool for atomic allocations
[    0.302088] Serial: AMBA PL011 UART driver
[    0.303683] f8015000.uart: ttyAMA0 at MMIO 0xf8015000 (irq = 7, base_baud = 0) is a PL011 rev2
[    0.304121] uart-pl011 f7111000.uart: could not find pctldev for node /soc/pinmux at f7010000/uart1_pmx_func, deferring probe
[    0.304340] uart-pl011 f7112000.uart: could not find pctldev for node /soc/pinmux at f7010000/uart2_pmx_func, deferring probe
[    0.304580] uart-pl011 f7113000.uart: could not find pctldev for node /soc/pinmux at f7010000/uart3_pmx_func, deferring probe
[    0.310373] hi6220-mbox f7510000.mailbox: Mailbox enabled
[    0.341400] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.342257] ACPI: Interpreter disabled.
[    0.342953] vgaarb: loaded
[    0.343177] SCSI subsystem initialized
[    0.343450] ssp-pl022 f7106000.spi: could not find pctldev for node /soc/pinmux at f7010000/spi0_pmx_func, deferring probe
[    0.343955] usbcore: registered new interface driver usbfs
[    0.344042] usbcore: registered new interface driver hub
[    0.344177] usbcore: registered new device driver usb
[    0.344452] i2c_designware f7100000.i2c: could not find pctldev for node /soc/pinmux at f7010000/i2c0_pmx_func, deferring probe
[    0.344494] i2c_designware f7101000.i2c: could not find pctldev for node /soc/pinmux at f7010000/i2c1_pmx_func, deferring probe
[    0.344535] i2c_designware f7102000.i2c: could not find pctldev for node /soc/pinmux at f7010000/i2c2_pmx_func, deferring probe
[    0.344915] pps_core: LinuxPPS API ver. 1 registered
[    0.344931] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.345003] PTP clock support registered
[    0.345325] dmi: Firmware registration failed.
[    0.345408] Registered efivars operations
[    0.345580] Advanced Linux Sound Architecture Driver Initialized.
[    0.346449] clocksource: Switched to clocksource arch_sys_counter
[    0.346617] VFS: Disk quotas dquot_6.6.0
[    0.346670] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.346935] pnp: PnP ACPI: disabled
[    0.355325] NET: Registered protocol family 2
[    0.355797] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.355885] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[    0.356026] TCP: Hash tables configured (established 8192 bind 8192)
[    0.356085] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.356120] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.356255] NET: Registered protocol family 1
[    0.356569] RPC: Registered named UNIX socket transport module.
[    0.356585] RPC: Registered udp transport module.
[    0.356599] RPC: Registered tcp transport module.
[    0.356613] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.356791] Unpacking initramfs...
[    0.497134] Freeing initrd memory: 3576K (ffff8000372d5000 - ffff800037653000)
[    0.497725] kvm [1]: 8-bit VMID
[    0.497744] kvm [1]: IDMAP page: 890000
[    0.497758] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    0.498691] kvm [1]: Hyp mode initialized successfully
[    0.498741] kvm [1]: vgic-v2 at f6804000
[    0.498936] kvm [1]: vgic interrupt IRQ1
[    0.498978] kvm [1]: virtual timer IRQ4
[    0.501267] futex hash table entries: 2048 (order: 6, 262144 bytes)
[    0.501394] audit: initializing netlink subsys (disabled)
[    0.501462] audit: type=2000 audit(0.495:1): initialized
[    0.501845] workingset: timestamp_bits=46 max_order=18 bucket_order=0
[    0.508960] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.509596] NFS: Registering the id_resolver key type
[    0.509632] Key type id_resolver registered
[    0.509645] Key type id_legacy registered
[    0.509665] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.509833] 9p: Installing v9fs 9p2000 file system support
[    0.512208] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.512235] io scheduler noop registered
[    0.512349] io scheduler cfq registered (default)
[    0.513271] libphy: mdio_driver_register: phy-bcm-ns2-pci
[    0.514198] pinctrl-single f7010000.pinmux: 159 pins at pa ffff000008e81000 size 636
[    0.514612] pinctrl-single f7010800.pinmux: 163 pins at pa ffff000008e83800 size 652
[    0.514770] pinctrl-single f8001800.pinmux: 30 pins at pa ffff000008e85800 size 120
[    0.515809] pl061_gpio f8011000.gpio: PL061 GPIO chip @0x00000000f8011000 registered
[    0.516214] pl061_gpio f8012000.gpio: PL061 GPIO chip @0x00000000f8012000 registered
[    0.516610] pl061_gpio f8013000.gpio: PL061 GPIO chip @0x00000000f8013000 registered
[    0.516687] gpio gpiochip3: gpio-line-names specifies 9 line names but there are 8 lines on the chip
[    0.517038] pl061_gpio f8014000.gpio: PL061 GPIO chip @0x00000000f8014000 registered
[    0.517416] pl061_gpio f7020000.gpio: PL061 GPIO chip @0x00000000f7020000 registered
[    0.517796] pl061_gpio f7021000.gpio: PL061 GPIO chip @0x00000000f7021000 registered
[    0.518172] pl061_gpio f7022000.gpio: PL061 GPIO chip @0x00000000f7022000 registered
[    0.518577] pl061_gpio f7023000.gpio: PL061 GPIO chip @0x00000000f7023000 registered
[    0.518658] gpio gpiochip8: gpio-line-names specifies 9 line names but there are 8 lines on the chip
[    0.518999] pl061_gpio f7024000.gpio: PL061 GPIO chip @0x00000000f7024000 registered
[    0.519385] pl061_gpio f7025000.gpio: PL061 GPIO chip @0x00000000f7025000 registered
[    0.519774] pl061_gpio f7026000.gpio: PL061 GPIO chip @0x00000000f7026000 registered
[    0.520162] pl061_gpio f7027000.gpio: PL061 GPIO chip @0x00000000f7027000 registered
[    0.520550] pl061_gpio f7028000.gpio: PL061 GPIO chip @0x00000000f7028000 registered
[    0.520939] pl061_gpio f7029000.gpio: PL061 GPIO chip @0x00000000f7029000 registered
[    0.521324] pl061_gpio f702a000.gpio: PL061 GPIO chip @0x00000000f702a000 registered
[    0.521719] pl061_gpio f702b000.gpio: PL061 GPIO chip @0x00000000f702b000 registered
[    0.522107] pl061_gpio f702c000.gpio: PL061 GPIO chip @0x00000000f702c000 registered
[    0.522505] pl061_gpio f702d000.gpio: PL061 GPIO chip @0x00000000f702d000 registered
[    0.522884] pl061_gpio f702e000.gpio: PL061 GPIO chip @0x00000000f702e000 registered
[    0.523275] pl061_gpio f702f000.gpio: PL061 GPIO chip @0x00000000f702f000 registered
[    0.526086] xenfs: not registering filesystem on non-xen platform
[    0.528934] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.530124] SuperH (H)SCI(F) driver initialized
[    0.530364] msm_serial: driver initialized
[    0.536344] loop: module loaded
[    0.539526] hisi_sas: driver version v1.6
[    0.541976] libphy: Fixed MDIO Bus: probed
[    0.542702] tun: Universal TUN/TAP device driver, 1.6
[    0.542719] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.543688] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    0.543707] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.543804] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    0.543821] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.543906] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    0.543930] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.544018] sky2: driver version 1.30
[    0.544551] VFIO - User Level meta-driver version: 0.3
[    0.546560] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.546590] ehci-pci: EHCI PCI platform driver
[    0.546638] ehci-platform: EHCI generic platform driver
[    0.546730] ehci-exynos: EHCI EXYNOS driver
[    0.546802] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    0.546866] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.546900] ohci-pci: OHCI PCI platform driver
[    0.546952] ohci-platform: OHCI generic platform driver
[    0.547024] ohci-exynos: OHCI EXYNOS driver
[    0.547324] usbcore: registered new interface driver usb-storage
[    0.547863] file system registered
[    0.548183] mousedev: PS/2 mouse device common for all mice
[    0.548621] input: HISI 65xx PowerOn Key as /devices/platform/f8000000.pmic/hi65xx-powerkey.0.auto/input/input0
[    0.549253] rtc-pl031 f8003000.rtc: rtc core: registered pl031 as rtc0
[    0.549459] rtc-pl031 f8004000.rtc: rtc core: registered pl031 as rtc1
[    0.549796] i2c /dev entries driver
[    0.552183] sdhci: Secure Digital Host Controller Interface driver
[    0.552207] sdhci: Copyright(c) Pierre Ossman
[    0.552403] Synopsys Designware Multimedia Card Interface Driver
[    0.553405] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.554851] ledtrig-cpu: registered to indicate activity on CPUs
[    0.555695] usbcore: registered new interface driver usbhid
[    0.555717] usbhid: USB HID core driver
[    0.557233] NET: Registered protocol family 17
[    0.557320] 9pnet: Installing 9P2000 support
[    0.557383] Key type dns_resolver registered
[    0.557996] registered taskstats version 1
[    0.561690] f7111000.uart: ttyAMA1 at MMIO 0xf7111000 (irq = 8, base_baud = 0) is a PL011 rev2
[    0.562226] f7112000.uart: ttyAMA2 at MMIO 0xf7112000 (irq = 9, base_baud = 0) is a PL011 rev2
[    0.562553] f7113000.uart: ttyAMA3 at MMIO 0xf7113000 (irq = 10, base_baud = 0) is a PL011 rev2
[    1.916968] console [ttyAMA3] enabled
[    1.922080] ssp-pl022 f7106000.spi: ARM PL022 driver, device ID: 0x00041022
[    1.929144] ssp-pl022 f7106000.spi: mapped registers from 0x00000000f7106000 to ffff000008f03000
[    1.938007] ssp-pl022 f7106000.spi: Failed to work in dma mode, work without dma!
[    1.949535] f72c0000.usb supply vusb_d not found, using dummy regulator
[    1.956256] f72c0000.usb supply vusb_a not found, using dummy regulator
[    2.344873] dwc2 f72c0000.usb: EPs: 16, dedicated fifos, 1920 entries in SPRAM
[    2.353154] dwc2 f72c0000.usb: DWC OTG Controller
[    2.357891] dwc2 f72c0000.usb: new USB bus registered, assigned bus number 1
[    2.364979] dwc2 f72c0000.usb: irq 38, io mem 0x00000000
[    2.371082] hub 1-0:1.0: USB hub found
[    2.374866] hub 1-0:1.0: 1 port detected
[    2.382071] rtc-pl031 f8003000.rtc: setting system clock to 1970-01-01 00:00:19 UTC (19)
[    2.390486] LDO2_2V8: disabling
[    2.393639] LDO7_SDIO: disabling
[    2.396900] LDO10_2V85: disabling
[    2.400234] LDO13_1V8: disabling
[    2.403476] LDO14_2V8: disabling
[    2.406721] LDO17_2V5: disabling
[    2.409956] LDO19_3V0: disabling
[    2.413199] wlan-en-regulator: disabling
[    2.417135] ALSA device list:
[    2.420109]   No soundcards found.
[    2.423712] uart-pl011 f7113000.uart: no DMA platform data
[    2.429585] Freeing unused kernel memory: 1024K (ffff800000c40000 - ffff800000d40000)
Loading, please wait...
starting version 228
[    2.479981] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    2.483570] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.483680] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.485404] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.485631] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.485859] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.486098] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.486305] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.486729] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.486951] random: udevadm: uninitialized urandom read (16 bytes read)
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... modprobe: can't change directory to '4.9.0-rc1-00251-g323792f': No such file or directory
done.
Begin: Waiting for root file system ... Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.

Thanks,
Leo Yan
