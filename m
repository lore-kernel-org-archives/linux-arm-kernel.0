From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 18 Feb 2016 22:09:13 +0800
Subject: iMX7d cpu1 issue
In-Reply-To: <56C2D63F.1030408@compulab.co.il>
References: <56C2D63F.1030408@compulab.co.il>
Message-ID: <20160218140913.GY6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 09:56:47AM +0200, Ilya Ledvich wrote:
> Hi Shawn,
> I'm working on Compulab CL-SOM-IMX7 device (http://www.compulab.co.il/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module)
> based on Freescale iMX7d CPU.
> I use the Freescale latest BSP imx_3.14.52_1.1.0_ga  and the Linux
> mainline v4.4-rc6 as a reference.
> I observe an issue with bringing up the second CPU core. Briefly,
> the kernel can successfully boot only when CPU1 fails to come
> online.
> In this case the boot log shows the following messages:
> ...
> CPU1: failed to come online
> Brought up 1 CPUs
> SMP: Total of 1 processors activated (6.00 BogoMIPS).
> ...
> 
> Otherwise, the device tries to start kernel several times until the
> boot process eventually crashes. Please see attached logs for more
> details.
> This never happens on mainline Linus kernel, because it never tries
> to bring up CPU1.
> Unfortunately, we cannot verify this behavior on reference board
> cause we have no one.
> Have you ever seen such behavior? Could you please advice something?

I never played i.MX7D support on any real hardware.  I copied a couple
Freescale/NXP people here.  Let's see if you can get some help from
them.

Shawn

> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
> Kernel command line: console=ttymxc0,115200 earlyprintk=ttymxc0,115200 root=/dev/nfs ip=dhcp nfsroot=192.168.11.24:/home/ilya/work/rootfs/sid-minbase,v3,tcp rw rootwait
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 700996K/1048576K available (6617K kernel code, 353K rwdata, 2280K rodata, 384K init, 421K bss, 347580K reserved, 0K highmem)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
>     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
>       .text : 0x80008000 - 0x808b8880   (8899 kB)
>       .init : 0x808b9000 - 0x80919080   ( 385 kB)
>       .data : 0x8091a000 - 0x80972680   ( 354 kB)
>        .bss : 0x8097268c - 0x809dbc00   ( 422 kB)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> Preemptible hierarchical RCU implementation.
>         RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
> RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> NR_IRQS:16 nr_irqs:16 16
> Switching to timer-based delay loop
> sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655765682ns
> Architected cp15 timer(s) running at 8.00MHz (phys).
> sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every 2147483648000ns
> Ignoring duplicate/late registration of read_current_timer delay
> Console: colour dummy device 80x30
> Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> CPU: Testing write buffer coherency: ok
> /cpus/cpu at 0 missing clock-frequency property
> /cpus/cpu at 1 missing clock-frequency property
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> Setting up static identity map for 0x80647850 - 0x806478a8
> Switching to timer-based delay loop
> Calibrating delay loop (skipped) already calibrated this CPU6.00 BogoMIPS (lpj=30000)
> sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655765682ns
> Architected cp15 timer(s) running at 8.00MHz (phys).
> 2147483648000ns
> Current pid: 1 comm: swapper/0 / Idle pid: 0 comm: swapper/0
> Ignoring duplicate/late registra
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> CPU1: failed to come online
> Brought up 1 CPUs
> SMP: Total of 1 processors activated (6.00 BogoMIPS).
> CPU: All CPU(s) started in SVC mode.
> devtmpfs: initialized
> VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> cpuidle: using governor ladder
> cpuidle: using governor menu
> Use WDOG1 as reset source
> syscon 30340000.iomuxc-gpr: regmap [mem 0x30340000-0x3034ffff] registered
> syscon 30350000.ocotp-ctrl: regmap [mem 0x30350000-0x3035ffff] registered
> syscon 30360000.anatop: regmap [mem 0x30360000-0x3036ffff] registered
> vdd1p0d: 800 <--> 1200 mV at 1000 mV 
> vdd1p2: 1100 <--> 1300 mV 
> syscon 30390000.src: regmap [mem 0x30390000-0x3039ffff] registered
> DDR type is DDR3!
> failed to find ocotp node
> failed to find ocotp node
> hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> hw-breakpoint: maximum watchpoint size is 8 bytes.
> imx7d-pinctrl 302c0000.iomuxc-lpsr: initialized IMX pinctrl driver
> imx7d-pinctrl 30330000.iomuxc: initialized IMX pinctrl driver
> MU is ready for cross core communication!
> bio: create slab <bio-0> at 0
> mxs-dma 33000000.dma-apbh: initialized
> usb_otg1_vbus: 5000 mV 
> fec1_phy_nreset: 3300 mV 
> platform regulator.15: Driver reg-fixed-voltage requests probe deferral
> tsc2046-reg: 3300 mV 
> platform regulator.17: Driver reg-fixed-voltage requests probe deferral
> platform lcd_nstby_3v3.18: Driver reg-fixed-voltage requests probe deferral
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> usbphy_nop1.10 supply vcc not found, using dummy regulator
> usbphy_nop2.11 supply vcc not found, using dummy regulator
> i2c i2c-1: IMX I2C adapter registered
> i2c i2c-3: IMX I2C adapter registered
> Linux video capture interface: v2.00
> pps_core: LinuxPPS API ver. 1 registered
> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> PTP clock support registered
> MIPI CSI2 driver module loaded
> Advanced Linux Sound Architecture Driver Initialized.
> Switched to clocksource arch_sys_counter
> cfg80211: Calling CRDA to update world regulatory domain
> NET: Registered protocol family 2
> TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP: reno registered
> UDP hash table entries: 512 (order: 2, 16384 bytes)
> UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> imx rpmsg driver is registered.
> Bus freq driver module loaded
> futex hash table entries: 512 (order: 3, 32768 bytes)
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> jffs2: version 2.2. (NAND) ???? 2001-2006 Red Hat, Inc.
> fuse init (API version 7.22)
> msgmni has been set to 2009
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> backlight.20 supply power not found, using dummy regulator
> MIPI DSI driver module loaded
> 30730000.lcdif supply lcd not found, using dummy regulator
> mxsfb 30730000.lcdif: failed to find mxc display driver 
> Console: switching to colour frame buffer device 100x30
> mxsfb 30730000.lcdif: initialized
> imx-sdma 30bd0000.sdma: no event needs to be remapped
> imx-sdma 30bd0000.sdma: loaded firmware 4.1
> imx-sdma 30bd0000.sdma: initialized
> pfuze100-regulator 1-0008: Full layer: 1, Metal layer: 1
> pfuze100-regulator 1-0008: FAB: 0, FIN: 0
> pfuze100-regulator 1-0008: pfuze3000 found.
> SW1A: 700 <--> 3300 mV at 1100 mV 
> SW1B: 700 <--> 1475 mV at 1000 mV 
> SW2: 1500 <--> 1850 mV at 1800 mV 
> SW3: 900 <--> 1650 mV at 1350 mV 
> SWBST: 5000 <--> 5150 mV at 5000 mV 
> VSNVS: 1000 <--> 3000 mV at 3000 mV 
> VREFDDR: 750 mV 
> VLDO1: 1800 <--> 3300 mV at 1800 mV 
> VLDO2: 800 <--> 1550 mV at 1500 mV 
> VCCSD: 2850 <--> 3300 mV at 3300 mV 
> V33: 2850 <--> 3300 mV at 3300 mV 
> VLDO3: 1800 <--> 3300 mV at 3300 mV 
> VLDO4: 1800 <--> 3300 mV at 3300 mV 
> Serial: IMX driver
> 30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 58, base_baud = 1500000) is a IMX
> console [ttymxc0] enabled
> bootconsole [earlycon0] disabled
> serial: Freescale lpuart driver
> imx sema4 driver is registered.
> [drm] Initialized drm 1.1.0 20060810
> [drm] Initialized vivante 1.0.0 20120216 on minor 0
> brd: module loaded
> loop: module loaded
> at24 1-0050: 1024 byte 24c08 EEPROM, writable, 16 bytes/write
> m25p80 spi0.1: m25px16 (2048 Kbytes)
> 3 ofpart partitions found on MTD device spi0.1
> Creating 3 MTD partitions on "spi0.1":
> 0x000000000000-0x0000000c0000 : "uboot"
> 0x0000000c0000-0x000000100000 : "uboot environment"
> 0x000000100000-0x000000200000 : "splash"
> spi_imx 30820000.ecspi: probed
> 30be0000.ethernet supply phy not found, using dummy regulator
> pps pps0: new PPS source ptp0
> libphy: fec_enet_mii_bus: probed
> fec 30be0000.ethernet eth0: registered PHC device 0
> 30bf0000.ethernet supply phy not found, using dummy regulator
> pps pps1: new PPS source ptp1
> fec 30bf0000.ethernet (unregistered net_device): Invalid MAC address: 00:00:00:00:00:00
> fec 30bf0000.ethernet (unregistered net_device): Using random MAC address: c2:a3:b7:db:4d:b0
> fec 30bf0000.ethernet eth1: registered PHC device 1
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-mxc: Freescale On-Chip EHCI Host driver
> usbcore: registered new interface driver usb-storage
> 30b10200.usbmisc supply vbus-wakeup not found, using dummy regulator
> 30b20200.usbmisc supply vbus-wakeup not found, using dummy regulator
> 30b30200.usbmisc supply vbus-wakeup not found, using dummy regulator
> 30b20000.usb supply vbus not found, using dummy regulator
> ci_hdrc ci_hdrc.1: EHCI Host Controller
> ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
> ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> imx_usb 30b30000.usb: Can't register ci_hdrc platform device, err=-517
> platform 30b30000.usb: Driver imx_usb requests probe deferral
> mousedev: PS/2 mouse device common for all mice
> input: 30370000.snvs-pwrkey as /devices/soc.3/30000000.aips-bus/30370000.snvs-pwrkey/input/input0
> snvs_pwrkey 30370000.snvs-pwrkey: i.MX snvs powerkey probed
> rtc-em3027 1-0056: rtc core: registered rtc-em3027 as rtc0
> snvs_rtc 30370034.snvs-rtc-lp: rtc core: registered 30370034.snvs-rtc-l as rtc1
> i2c /dev entries driver
> IR NEC protocol handler initialized
> IR RC5(x) protocol handler initialized
> IR RC6 protocol handler initialized
> IR JVC protocol handler initialized
> IR Sony protocol handler initialized
> IR RC5 (streamzap) protocol handler initialized
> IR SANYO protocol handler initialized
> IR MCE Keyboard/mouse protocol handler initialized
> imx2-wdt 30280000.wdog: IMX2+ Watchdog Timer enabled. timeout=60s (nowayout=0)
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> sdhci-esdhc-imx 30b40000.usdhc: could not get ultra high speed state, work on normal mode
> mmc0: no vqmmc regulator found
> mmc0: no vmmc regulator found
> mmc0: SDHCI controller on 30b40000.usdhc [30b40000.usdhc] using ADMA
> sdhci-esdhc-imx 30b60000.usdhc: could not get ultra high speed state, work on normal mode
> mmc2: no vqmmc regulator found
> mmc2: no vmmc regulator found
> mmc0: new high speed SDHC card at address e624
> mmc2: SDHCI controller on 30b60000.usdhc [30b60000.usdhc] using ADMA
> mmcblk0: mmc0:e624 SS08G 7.40 GiB 
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
>  mmcblk0: unknown partition table
> TCP: cubic registered
> NET: Registered protocol family 10
> sit: IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> Key type dns_resolver registered
> usb 1-1: new high-speed USB device number 2 using ci_hdrc
> Registering SWP/SWPB emulation handler
> SWBST: disabling
> usb_otg1_vbus: disabling
> regulator-dummy: disabling
> imx mcc test is registered.
> fec2_phy_nreset: 3300 mV 
> usb_host_nreset: 3300 mV 
> lcd_nstby_3v3: no parameters
> ci_hdrc ci_hdrc.2: EHCI Host Controller
> ci_hdrc ci_hdrc.2: new USB bus registered, assigned bus number 2
> mmc2: BKOPS_EN bit is not set
> mmc2: new high speed DDR MMC card at address 0001
> mmcblk2: mmc2:0001 SEM04G 3.68 GiB 
> mmcblk2boot0: mmc2:0001 SEM04G partition 1 2.00 MiB
> mmcblk2boot1: mmc2:0001 SEM04G partition 2 2.00 MiB
> mmcblk2rpmb: mmc2:0001 SEM04G partition 3 2.00 MiB
>  mmcblk2: unknown partition table
>  mmcblk2boot1: unknown partition table
>  mmcblk2boot0: unknown partition table
> ci_hdrc ci_hdrc.2: USB 2.0 started, EHCI 1.00
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> Number of LUNs=8
> Mass Storage Function, version: 2009/09/11
> LUN: removable file: (no medium)
> usb-storage 1-1:1.0: USB Mass Storage device detected
> scsi0 : usb-storage 1-1:1.0
> Number of LUNs=1
> no file given for LUN0
> g_mass_storage ci_hdrc.0: failed to start g_mass_storage: -22
> rtc-em3027 1-0056: setting system clock to 2016-02-16 07:32:51 UTC (1455607971)
> fec 30be0000.ethernet eth0: Freescale FEC PHY driver [Atheros 8031 ethernet] (mii_bus:phy_addr=30be0000.etherne:00, irq=-1)
> IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> fec 30bf0000.ethernet eth1: Freescale FEC PHY driver [Atheros 8031 ethernet] (mii_bus:phy_addr=30be0000.etherne:01, irq=-1)
> usb 2-1: new high-speed USB device number 2 using ci_hdrc
> IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> hub 2-1:1.0: USB hub found
> hub 2-1:1.0: 3 ports detected
> scsi 0:0:0:0: Direct-Access     SanDisk  Cruzer Slice     1.14 PQ: 0 ANSI: 2
> sd 0:0:0:0: [sda] 15633408 512-byte logical blocks: (8.00 GB/7.45 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] No Caching mode page found
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sd 0:0:0:0: [sda] No Caching mode page found
> sd 0:0:0:0: [sda] Assuming drive cache: write through
>  sda: unknown partition table
> sd 0:0:0:0: [sda] No Caching mode page found
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> libphy: 30be0000.etherne:00 - Link is Up - 1000/Full
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> Sending DHCP requests ., OK
> IP-Config: Got DHCP answer from 10.1.1.240, my address is 192.168.27.43
> IP-Config: Complete:
>      device=eth0, hwaddr=00:01:c0:1a:e9:13, ipaddr=192.168.27.43, mask=255.255.0.0, gw=192.168.0.110
>      host=192.168.27.43, domain=compulab.local, nis-domain=(none)
>      bootserver=10.1.1.247, rootserver=192.168.11.24, rootpath=
>      nameserver0=192.168.10.13, nameserver1=10.1.1.247
> ALSA device list:
>   No soundcards found.
> VFS: Mounted root (nfs filesystem) on device 0:13.
> devtmpfs: mounted
> Freeing unused kernel memory: 384K (808b9000 - 80919000)
> random: systemd urandom read with 58 bits of entropy available
> systemd[1]: systemd 228 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
> systemd[1]: Detected architecture arm.
> 
> Welcome to Debian GNU/Linux stretch/sid!
> 

> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
> Kernel command line: console=ttymxc0,115200 earlyprintk=ttymxc0,115200 root=/dev/nfs ip=dhcp nfsroot=192.168.11.24:/home/ilya/work/rootfs/sid-minbase,v3,tcp rw rootwait
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 700996K/1048576K available (6617K kernel code, 353K rwdata, 2280K rodata, 384K init, 421K bss, 347580K reserved, 0K highmem)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
>     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
>       .text : 0x80008000 - 0x808b8880   (8899 kB)
>       .init : 0x808b9000 - 0x80919080   ( 385 kB)
>       .data : 0x8091a000 - 0x80972680   ( 354 kB)
>        .bss : 0x8097268c - 0x809dbc00   ( 422 kB)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> Preemptible hierarchical RCU implementation.
>         RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
> RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> NR_IRQS:16 nr_irqs:16 16
> Switching to timer-based delay loop
> sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 1431655765682ns
> Architected cp15 timer(s) running at 8.00MHz (phys).
> sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every 2147483648000ns
> Ignoring duplicate/late registration of read_current_timer delay
> Console: colour dummy device 80x30
> Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> CPU: Testing write buffer coherency: ok
> /cpus/cpu at 0 missing clock-frequency property
> /cpus/cpu at 1 missing clock-frequency property
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> Setting up static identity map for 0x80647850 - 0x806478a8
> Memory: 700996K/1048576K available (6617K kernel code, 353K rwdata, 2280K rodata, 384K init, 421K bss, 347580K reserved, 0K highmem)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
>     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
>       .text : 0x80008000 - 0x808b8880   (8899 kB)
>       .init : 0x808b9000 - 0x80919080   ( 385 kB)
>       .data : 0x8091a000 - 0x80972680   ( 354 kB)
>        .bss : 0x8097268c - 0x809dbc00   ( 422 kB)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> Preemptible hierarchical RCU implementation.
>         RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
> RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> Calibrating delay loop (skipped) already calibrated this CPU6.00 BogoMIPS (lpj=30000)
> NR_IRQS:16 nr_irqs:16 16
> Switching to timer-based delay loop
> sched_clock: 32 bits at 3000kHz,
> [000001d8] *pgd=00000000
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> Modules linked in:
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> [00000008] *pgd=00000000
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
> Modules linked in:
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> [00000000] *pgd=00000000
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> Modules linked in:
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [00000000] *pgd=00000000
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> Modules linked in:
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [00000000] *pgd=00000000
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> Modules linked in:
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> nPU: PIPT / VIPT nonaliasing data cacCPhUe1,:  VfIaPiTl ealdia stion gc oimnes tornulctiinoe
>  Braoucghhet
> m 1Ma chCiPnUes 
> seSMlP::  CToomtaplu Loafb  S1B C-pirMoXc7es
> asbo oatcctoivnastoelde  (6[.0e0a rBloygcooMnI0P]S )e.n
> AClPeU:d 
> 0c mCaP: UC(MsA:)  rsetsaerrtveedd  i3n20  SMViCB m oadte .ac
> 0000
> cheemvotrmyp fpso:l iciyn:it iDaaltiaz ecda
>  writealloc
> On node 0 totalpages: 262144
> aree_area_init_nVFoPde :s unpopdoer t0,  pvg0d.a3t:  80i9m71p1l0e0m,e nntoord 4e1_ meamr_chmitaepc taubr7e5 9200 0p
> p 3  0D MvAa rzioannet :7  r2e0v4 85 
> tes uspeidn cftorlr c ormee:m mianpi
> i a lDiMzAe dz opnie:n c0t rpalge s sruebsseyrsvteedm
> 
> h DMAre guzloanteo:r -2d62u14m4m yp:a gneos ,p aLrIaFmOe tebrastc
> 31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Binux version 3.14.52+ (ilya at ilya-pc) NE(Tg:c cR evgeirssiotne r4e.d 7pr.o2t (oScoolu fracmeirlyy  C1o6de
> nch Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410DMfAc:0 7p5r]e arlelvoicsaitoend  52 5(6A RKMivB7 )p,o olc rf=1o0rc 5a3to8mi7cd 
> ahCPeU:r PeInPt Ta l/ lVoIcaPtTi noonns
> iasing datacp uciadclhee:,  uVsIPiTn g agloivaesirngn oir nlsatrducdteiro
> : cpauicdhlee
> mpMnagc hignoev emrnoodrel :m enCuo
>  abUs eS BWCD-iOMXG71
>   rbeosoettc osnosuorlcee
> [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> pysOcno nno d3e0 304 0t0o0t0.ailopmaugxecs-:g p2r6:2 r1eg4m4a
> 11freeme _0axr3ea0_3i40n0i0t_0no-d0ex3:0 3no4dfef f0f, ]p grdeagti s8t0er9ed7
> c, snyosdcoen_ m3e0m3_50m0a0p0 .aobc7o5t90p00-
> el  :DM Ar ezgomanpe :[ m2e0m48  0pxa3g0e3s50 00u0s-ed0 xf3o0r3 5mfefmffm]a pr
> o s teDrMeA dz
> : 0 pagseyss croesne r3v0e3d6
> 6f  0D.MaAn zaonteo:p:  2r6e2g1m4a4p  pa[gmeesm, 0 xL3I03F6O0 0b0a0t-c0hx:33013
> ffPE]R CrePgiUs:t eErmbeedd
> d1 8 pvdad1gp0eds:/ c8p0u0  @<a-b-7>3 1520000 0m Vs 8a3t2 01 0r080 1m9V2  
> 056 vdud13p22:7 61810
> x--B>o o1ti3n0g0  mLVin u
> 30 physical CPUsy sc0oxn0 
>  0L0i0n0ux. svrecr:si orne g3m.a1p4 .[m5em2 +0 x(3i0l39y0a0 at i0l0y-a0-xp3c0)3 9f(fgfccf ]v reergsiiosnt e4r.e7.d2
> 9ourcery CodeDBDeRn cthy pLei itse  2D0D1R23.!0
> -64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> sPU: ARMv7 Profacileesdso rt o[ 4f1i0nfdc 0o7c5o]tp  nroedvei
> ofna i5l e(dAR Mtvo 7fi)n,d  corc=o1t0pc 5n38o7dd
> e
> ghUw: -PbIrPeTa k/p oViInPt:T f ounnodn a5l i(a+s1i nrge sdeartvae dc)a cbhree,a kVIpPTo ianltia sianngd  in4s twartucchtpiooinn tc archee
>  mtaecrhsi.ne
> mhewl:- bCroemakppouiLnabt S:B Cm-aixMiXm7u
> etcbhopooticnotn ssoilzee  [eiarsl y8c onb0]y teensab.l
>  d
> 0ma: CMA: reserviemdx 73d2-0p iMnicBt ralt  3a0c20c00000000
> dMoemmuoxrc-yl ppsorl:i icniyt:i Daaltizae dca chIeM X wpriintceatlrlloc 
> noOenr 
> 0 0 tiomtxa7ldp-apgiensc:t r2l6 320134340
>  .frieoem_uarxeac_:i inniitt_inoadlei: zneodd eI M0X,  ppigndcatt r8l0 9dr7i1v1e0r0,
> ode_mem_map ab759000
>   DMUM iAs  zroenaed:y  2f0o4r 8c rpoasgse sc oursee dco mfmourn imceatmimoanp!
> 
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> tooting biLoi:n ucxr eaotne p hsylasbi ca<l bCiPoU- 00>x 0a
> 0 
> 2ux version 3.14.52+ (ilya at ilya-pc) (gcc vmexrss-idomna  43.37.020 00(0S0ou.rcdemray- aCpobdhe:B einnitciha Lliitzeed 
> b2.09-64) us)b _#ot8g 1SM_P vPbRuEsE: M5P0T 0M0o mnV  Fe
> 35 1f4e:c51_5p:h0y8_n rIeSTs e2t:0 136
> 0 m[0V00 0
> 04]pl a*tpgfd=o0r0m 0r0e0g0u0l0at
> =1.P1U5::  DArRMiv7v ePrr orecg-efsisoxre d-[v4o10lftcag0e 7r5e]q ureevisstis opnr 5o (bAeR Mdve7f)e,r raclr
> 453t8s7cd20
> IreCPgU::  P3I3P00T m V/  V
> T plnaotnfaolrima srienggu ldaattoar .c1a7c:h Der,i VvIePrT  reag-lfiiasxiend-gvo litnasgter urcetiqounes tcsa cpher
> liM odedfuelrerasl 
> rpleadt ifn:o
> - lMcadc_hinnsetb y_m3ovde3l.:18 :C omDpruivLera br eSgBC--ifMiXxe7d
> bboolottacgeo rnesqoulees [tesa rplroybec odn0e]f ereranla
> ed
> 0ma: CMASC:S Ir esusbesryvsedt 3e2m0 i nMiitBi aalti zace0d0
> 00
> ieusmbcoorrye :p orleigciys:te rDeatda  necwa chien twerritfeaaclel odcr
>  r Ouns bnofdse
> etoustbaclopraeg:e sr:e g2i6s2t1e4r4
>  nefrwe ei_natreear_fianciet _dnordiev:e rn ohdeu b0
> vpusgbdcato r8e0:97 11r0e0g,i stneordee_dm emn_emwa pd eabv7i5c9e0 d0r0i
> r   uDMsAb 
> oneus:bp h2y0_4n8o pp1.a1g0es  suuspepdl yf ovrc cm enmmoatp f
> dd  ,DM Au siznogn ed: u0m mpayg erse gruelsaetrovre
> 
> nsb  pDMhA yz_onnoep:2 .21612 1s44u ppplayg evsc,c  LnIoFOt  bfaotuncdh,: u3s1i
> edPuEmmRyC PrUeg:u lEamtbeodrd
>  8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
>   DMA zone: 2048 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 262144 pages, LIFO batch:31
> PERCPU: Embedded 8 pages/cpu @ab735000 s8320 r8192 d16256 u32768
> Booting Linux on physical CPU 0x0
> Linux version 3.14.52+ (ilya at ilya-pc) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-64) ) #8 SMP PREEMPT Mon Feb 15 14:55:08 IST 2016
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: CompuLab SBC-iMX7
> bootconsole [earlycon0] enabled
> cma: CMA: reserved 320 MiB at ac000000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 262144
> free_area_init_node: node 0, pgdat 80971100, node_mem_map ab759000
> [00000000] *pgd=00000000
>   DMA zone: 2048 pages used for memmap
> 
