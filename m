From: eranian@googlemail.com (stephane eranian)
Date: Tue, 10 Jan 2012 01:46:18 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
Message-ID: <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See the dmesg from my 3.2 kernel:


[ ? ?0.000000] Booting Linux on physical CPU 0[ ? ?0.000000]
Initializing cgroup subsys cpuset[ ? ?0.000000] Initializing cgroup
subsys cpu[ ? ?0.000000] Linux version 3.2.0-omap4 (eranian at panda)
(gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #9 SMP PR[
0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7),
cr=10c5387d[ ? ?0.000000] CPU: PIPT / VIPT nonaliasing data cache,
VIPT aliasing instruction cache[ ? ?0.000000] Machine: OMAP4 Panda
board[ ? ?0.000000] Reserving 33554432 bytes SDRAM for VRAM[
0.000000] Memory policy: ECC disabled, Data cache writealloc[
0.000000] On node 0 totalpages: 239616[ ? ?0.000000]
free_area_init_node: node 0, pgdat c077c180, node_mem_map c07f4000[
0.000000] ? Normal zone: 1536 pages used for memmap[ ? ?0.000000]
Normal zone: 0 pages reserved[ ? ?0.000000] ? Normal zone: 180736
pages, LIFO batch:31[ ? ?0.000000] ? HighMem zone: 512 pages used for
memmap[ ? ?0.000000] ? HighMem zone: 56832 pages, LIFO batch:15[
0.000000] OMAP4430 ES2.2[ ? ?0.000000] PERCPU: Embedded 8 pages/cpu
@c0ffc000 s10240 r8192 d14336 u32768[ ? ?0.000000] pcpu-alloc: s10240
r8192 d14336 u32768 alloc=8*4096[ ? ?0.000000] pcpu-alloc: [0] 0 [0]
1[ ? ?0.000000] Built 1 zonelists in Zone order, mobility grouping on.
?Total pages: 237568[ ? ?0.000000] Kernel command line: ro
elevator=noop vram=32M mem=456M at 0x80000000 mem=512M at 0xA0000000
root=UUID=ec3f7a[ ? ?0.000000] PID hash table entries: 4096 (order: 2,
16384 bytes)[ ? ?0.000000] Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)[ ? ?0.000000] Inode-cache hash table entries:
65536 (order: 6, 262144 bytes)[ ? ?0.000000] allocated 4194304 bytes
of page_cgroup[ ? ?0.000000] please try 'cgroup_disable=memory' option
if you don't want memory cgroups[ ? ?0.000000] Memory: 456MB 480MB =
936MB total[ ? ?0.000000] Memory: 934980k/934980k available, 56252k
reserved, 229376K highmem[ ? ?0.000000] Virtual kernel memory layout:[
? ?0.000000] ? ? vector ?: 0xffff0000 - 0xffff1000 ? ( ? 4 kB)[
0.000000] ? ? fixmap ?: 0xfff00000 - 0xfffe0000 ? ( 896 kB)[
0.000000] ? ? vmalloc : 0xf0800000 - 0xf8000000 ? ( 120 MB)[
0.000000] ? ? lowmem ?: 0xc0000000 - 0xf0000000 ? ( 768 MB)[
0.000000] ? ? pkmap ? : 0xbfe00000 - 0xc0000000 ? ( ? 2 MB)[
0.000000] ? ? modules : 0xbf000000 - 0xbfe00000 ? ( ?14 MB)[
0.000000] ? ? ? .text : 0xc0008000 - 0xc06e1134 ? (7013 kB)[
0.000000] ? ? ? .init : 0xc06e2000 - 0xc071e800 ? ( 242 kB)[
0.000000] ? ? ? .data : 0xc0720000 - 0xc077ecf0 ? ( 380 kB)[
0.000000] ? ? ? ?.bss : 0xc077ed14 - 0xc07f32ec ? ( 466 kB)[
0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0,
CPUs=2, Nodes=1[ ? ?0.000000] Preemptible hierarchical RCU
implementation.[ ? ?0.000000] NR_IRQS:410[ ? ?0.000000] omap_hwmod:
dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.[ ? ?0.000000]
OMAP clockevent source: GPTIMER1 at 32768 Hz[ ? ?0.000000]
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every
131071999ms[ ? ?0.000000] Console: colour dummy device 80x30[
0.000000] console [tty0] enabled[ ? ?0.000213] Calibrating delay
loop... 1576.53 BogoMIPS (lpj=6156288)[ ? ?0.070373] pid_max: default:
32768 minimum: 301[ ? ?0.070617] Security Framework initialized[
0.070678] Smack: ?Initializing.[ ? ?0.070770] Mount-cache hash table
entries: 512[ ? ?0.071807] Initializing cgroup subsys cpuacct[
0.071868] Initializing cgroup subsys memory[ ? ?0.071929] Initializing
cgroup subsys devices[ ? ?0.071929] Initializing cgroup subsys
freezer[ ? ?0.071960] Initializing cgroup subsys blkio[ ? ?0.071990]
Initializing cgroup subsys perf_event[ ? ?0.072143] CPU: Testing write
buffer coherency: ok[ ? ?0.072448] CPU0: thread -1, cpu 0, socket 0,
mpidr 80000000[ ? ?0.072509] Calibrating local timer... 386.32MHz.[
0.117462] hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7
counters available[ ? ?0.117523] L310 cache controller enabled[
0.117523] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000,
Cache size: 1048576 B[ ? ?0.194000] CPU1: Booted secondary processor[
 ?0.224121] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001[
0.224151] CPU1: Unknown IPI message 0x1[ ? ?0.224182] Brought up 2
CPUs[ ? ?0.224212] SMP: Total of 2 processors activated (3115.31
BogoMIPS).[ ? ?0.225097] devtmpfs: initialized[ ? ?0.228820]
omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.[
0.231903] omap_hwmod: dmm: _wait_target_disable failed[ ? ?0.234497]
omap_hwmod: emif_fw: _wait_target_disable failed[ ? ?0.237091]
omap_hwmod: l3_main_1: _wait_target_disable failed[ ? ?0.239715]
omap_hwmod: l3_main_2: _wait_target_disable failed[ ? ?0.242309]
omap_hwmod: l4_abe: _wait_target_disable failed[ ? ?0.244903]
omap_hwmod: l4_cfg: _wait_target_disable failed[ ? ?0.247528]
omap_hwmod: l4_per: _wait_target_disable failed[ ? ?0.250610]
omap_hwmod: l4_wkup: _wait_target_disable failed[ ? ?0.253234]
omap_hwmod: dma_system: _wait_target_disable failed[ ? ?0.255889]
omap_hwmod: dss_core: _wait_target_disable failed[ ? ?0.258514]
omap_hwmod: dss_dispc: _wait_target_disable failed[ ? ?0.261108]
omap_hwmod: dss_dsi1: _wait_target_disable failed[ ? ?0.263732]
omap_hwmod: dss_dsi2: _wait_target_disable failed[ ? ?0.266326]
omap_hwmod: dss_hdmi: _wait_target_disable failed[ ? ?0.268920]
omap_hwmod: dss_rfbi: _wait_target_disable failed[ ? ?0.271545]
omap_hwmod: dss_venc: _wait_target_disable failed[ ? ?0.275054]
omap_hwmod: mailbox: _wait_target_disable failed[ ? ?0.277709]
omap_hwmod: mcpdm: cannot be enabled (3)[ ? ?0.280487] omap_hwmod:
spinlock: _wait_target_disable failed[ ? ?0.282348] print_constraints:
dummy:[ ? ?0.282592] NET: Registered protocol family 16[ ? ?0.282775]
GPMC revision 6.0[    0.284332] OMAP GPIO hardware version 0.1
[    0.285552] omap_mux_init: Add partition: #1: core, flags: 2
[    0.286468] omap_mux_init: Add partition: #2: wkup, flags: 2
[    0.291015] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.291015] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.291595] RES:0 IRQ:33
[    0.291595] RES:1 IRQ:34
[    0.294219] OMAP DMA hardware revision 0.0
[    0.299591] bio: create slab <bio-0> at 0
[    0.300109] print_constraints: vwl1271: 1800 mV
[    0.300994] SCSI subsystem initialized
[    0.301239] usbcore: registered new interface driver usbfs
[    0.301300] usbcore: registered new interface driver hub
[    0.301391] usbcore: registered new device driver usb
[    0.315643] omap_i2c omap_i2c.1: bus 1 rev2.4.0 at 400 kHz
[    0.316131] Skipping twl internal clock init and using bootloader
value (unknown osc rate)
[    0.316619] twl6030: PIH (irq 39) chaining IRQs 368..387
[    0.316986] print_constraints: VUSB: 3300 mV normal standby
[    0.514312] twl6030_usb twl6030_usb: Initialized TWL6030 USB module
[    0.514648] print_constraints: VMMC: 1200 <--> 3000 mV at 3000 mV
normal standby
[    0.515075] print_constraints: VPP: 1800 <--> 2500 mV at 1900 mV
normal standby
[    0.515563] print_constraints: VCXIO: 1800 mV normal standby
[    0.515808] print_constraints: VDAC: 1800 mV normal standby
[    0.516174] print_constraints: VAUX2_6030: 1200 <--> 2800 mV at
1800 mV normal standby
[    0.516601] print_constraints: VAUX3_6030: 1000 <--> 3000 mV at
1200 mV normal standby
[    0.516845] print_constraints: CLK32KG:
[    0.517059] print_constraints: VANA: 2100 mV normal standby
[    0.529052] omap_i2c omap_i2c.2: bus 2 rev2.4.0 at 400 kHz
[    0.544281] omap_i2c omap_i2c.3: bus 3 rev2.4.0 at 100 kHz
[    0.559539] omap_i2c omap_i2c.4: bus 4 rev2.4.0 at 400 kHz
[    0.559997] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    0.560516] Bluetooth: Core ver 2.16
[    0.560577] NET: Registered protocol family 31
[    0.560577] Bluetooth: HCI device and connection manager initialized
[    0.560607] Bluetooth: HCI socket layer initialized
[    0.560821] cfg80211: Calling CRDA to update world regulatory domain
[    0.561523] NetLabel: Initializing
[    0.561523] NetLabel:  domain hash size = 128
[    0.561553] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.561584] NetLabel:  unlabeled traffic allowed by default
[    0.561614] Switching to clocksource 32k_counter
[    0.592681] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    0.592864] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk
combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn
[    0.592926] musb-hdrc: MHDRC RTL version 2.0
[    0.592926] musb-hdrc: setup fifo_mode 4
[    0.592956] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    0.593231] musb-hdrc musb-hdrc: USB OTG mode controller at
fc0ab000 using DMA, IRQ 124
[    0.593627] NET: Registered protocol family 2
[    0.593933] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.595001] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.596923] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.598022] TCP: Hash tables configured (established 131072 bind 65536)
[    0.598022] TCP reno registered
[    0.598052] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.598083] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.598449] NET: Registered protocol family 1
[    0.598846] RPC: Registered named UNIX socket transport module.
[    0.598846] RPC: Registered udp transport module.
[    0.598846] RPC: Registered tcp transport module.
[    0.598876] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.599121] Trying to unpack rootfs image as initramfs...
[    0.793060] Freeing initrd memory: 2612K
[    0.914703] audit: initializing netlink socket (disabled)
[    0.914764] type=2000 audit(0.921:1): initialized
[    1.053497] highmem bounce pool size: 64 pages
[    1.060485] VFS: Disk quotas dquot_6.5.2
[    1.060913] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.063934] msgmni has been set to 1383
[    1.065399] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[    1.065429] io scheduler noop registered (default)
[    1.065429] io scheduler deadline registered
[    1.065460] io scheduler cfq registered
[    1.066253] OMAP DSS rev 4.0
[    1.068847] omap_hwmod: dss_core: _wait_target_disable failed
[    1.071716] omap_hwmod: dss_core: _wait_target_disable failed
[    1.074340] omap_hwmod: dss_dispc: _wait_target_disable failed
[    1.077209] omap_hwmod: dss_dispc: _wait_target_disable failed
[    1.079864] omap_hwmod: dss_core: _wait_target_disable failed
[    1.082489] omap_hwmod: dss_dsi1: _wait_target_disable failed
[    1.085266] omap_hwmod: dss_dispc: _wait_target_disable failed
[    1.087890] omap_hwmod: dss_dsi2: _wait_target_disable failed
[    1.091247] omap_hwmod: dss_dispc: _wait_target_disable failed
[    1.093841] omap_hwmod: dss_core: _wait_target_disable failed
[    1.098175] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 104) is a OMAP UART0
[    1.116394] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 105) is a OMAP UART1
[    1.139831] omap_uart.2: ttyO2 at MMIO 0x48020000 (irq = 106) is a OMAP UART2
[    1.257019] omap_uart.3: ttyO3 at MMIO 0x4806e000 (irq = 102) is a OMAP UART3
[    1.382202] [drm] Initialized drm 1.1.0 20060810
[    1.382781] brd: module loaded
[    1.386749] loop: module loaded
[    1.386932] (stk) :sysfs entries created
[    1.386962] (stk) : debugfs entries created
[    1.387573] usbcore: registered new interface driver smsc95xx
[    1.387603] cdc_ncm: 04-Aug-2011
[    1.387695] usbcore: registered new interface driver cdc_ncm
[    1.387786] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.387817] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
[    1.387908] _regulator_get: ehci-omap.0 supply hsusb0 not found,
using dummy regulator
[    1.388031] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=0
cc=1 pcc=3 ordered ports=3
[    1.388061] ehci-omap ehci-omap.0: reset hcc_params 20016 thresh 1
uframes 256/512/1024 park LPM
[    1.388061] ehci-omap ehci-omap.0: reset hcc_params 20016 thresh 1
uframes 256/512/1024 park LPM
[    1.388061] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    1.388092] ehci-omap ehci-omap.0: new USB bus registered, assigned
bus number 1
[    1.388214] ehci-omap ehci-omap.0: park 0
[    1.388214] ehci-omap ehci-omap.0: support lpm
[    1.388244] ehci-omap ehci-omap.0: irq 109, io mem 0x4a064c00
[    1.388275] ehci-omap ehci-omap.0: reset command 0080b02  park=3
ithresh=8 period=1024 Reset HALT
[    1.388305] ehci-omap ehci-omap.0: init command 0010005 (park)=0
ithresh=1 period=512 RUN
[    1.397613] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    1.397735] usb usb1: default language 0x0409
[    1.397766] usb usb1: udev 1, busnum 1, minor = 0
[    1.397796] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.397796] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.397796] usb usb1: Product: OMAP-EHCI Host Controller
[    1.397827] usb usb1: Manufacturer: Linux 3.2.0-omap4 ehci_hcd
[    1.397827] usb usb1: SerialNumber: ehci-omap.0
[    1.398223] usb usb1: usb_probe_device
[    1.398254] usb usb1: configuration #1 chosen from 1 choice
[    1.398284] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    1.398406] hub 1-0:1.0: usb_probe_interface
[    1.398406] hub 1-0:1.0: usb_probe_interface - got id
[    1.398437] hub 1-0:1.0: USB hub found
[    1.398437] hub 1-0:1.0: 3 ports detected
[    1.398468] hub 1-0:1.0: standalone hub
[    1.398468] hub 1-0:1.0: individual port power switching
[    1.398468] hub 1-0:1.0: individual port over-current protection
[    1.398498] hub 1-0:1.0: power on to power good time: 20ms
[    1.398498] hub 1-0:1.0: local power source is good
[    1.398529] hub 1-0:1.0: enabling power on all ports
[    1.398712] ehci-omap ehci-omap.0: ...powerup ports...
[    1.428924] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.428924] ohci_hcd: block sizes: ed 64 td 64
[    1.429046] ohci-omap3 ohci-omap3.0: OMAP3 OHCI Host Controller
[    1.429077] ohci-omap3 ohci-omap3.0: new USB bus registered,
assigned bus number 2
[    1.429077] ohci-omap3 ohci-omap3.0: starting OHCI controller
[    1.429168] ohci-omap3 ohci-omap3.0: created debug files
[    1.429199] ohci-omap3 ohci-omap3.0: irq 108, io mem 0x4a064800
[    1.499206] ehci-omap ehci-omap.0: GetStatus port:1 status 001803 0
 ACK POWER sig=j CSC CONNECT
[    1.499237] hub 1-0:1.0: port 1: status 0501 change 0001
[    1.510986] ohci-omap3 ohci-omap3.0: OHCI controller state
[    1.510986] ohci-omap3 ohci-omap3.0: OHCI 1.0, NO legacy support registers
[    1.511016] ohci-omap3 ohci-omap3.0: control 0x283 RWC
HCFS=operational CBSR=3
[    1.511016] ohci-omap3 ohci-omap3.0: cmdstatus 0x00000 SOC=0
[    1.511047] ohci-omap3 ohci-omap3.0: intrstatus 0x00000004 SF
[    1.511047] ohci-omap3 ohci-omap3.0: intrenable 0x8000005a MIE RHSC UE RD WDH
[    1.511077] ohci-omap3 ohci-omap3.0: hcca frame #0014
[    1.511077] ohci-omap3 ohci-omap3.0: roothub.a 0a000203 POTPGT=10
NPS NDP=3(3)
[    1.511108] ohci-omap3 ohci-omap3.0: roothub.b 00000000 PPCM=0000 DR=0000
[    1.511108] ohci-omap3 ohci-omap3.0: roothub.status 00008000 DRWE
[    1.511108] ohci-omap3 ohci-omap3.0: roothub.portstatus [0] 0x00000100 PPS
[    1.511138] ohci-omap3 ohci-omap3.0: roothub.portstatus [1] 0x00000100 PPS
[    1.511138] ohci-omap3 ohci-omap3.0: roothub.portstatus [2] 0x00000100 PPS
[    1.511199] usb usb2: default language 0x0409
[    1.511230] usb usb2: udev 1, busnum 2, minor = 128
[    1.511230] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.511260] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.511260] usb usb2: Product: OMAP3 OHCI Host Controller
[    1.511291] usb usb2: Manufacturer: Linux 3.2.0-omap4 ohci_hcd
[    1.511291] usb usb2: SerialNumber: ohci-omap3.0
[    1.511627] usb usb2: usb_probe_device
[    1.511627] usb usb2: configuration #1 chosen from 1 choice
[    1.511657] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[    1.511779] hub 2-0:1.0: usb_probe_interface
[    1.511779] hub 2-0:1.0: usb_probe_interface - got id
[    1.511779] hub 2-0:1.0: USB hub found
[    1.511810] hub 2-0:1.0: 3 ports detected
[    1.511810] hub 2-0:1.0: standalone hub
[    1.511840] hub 2-0:1.0: no power switching (usb 1.0)
[    1.511840] hub 2-0:1.0: global over-current protection
[    1.511871] hub 2-0:1.0: power on to power good time: 20ms
[    1.511871] hub 2-0:1.0: local power source is good
[    1.511901] hub 2-0:1.0: no over-current condition exists
[    1.511901] hub 2-0:1.0: trying to enable port power on non-switchable hub
[    1.512176] Initializing USB Mass Storage driver...
[    1.512329] usbcore: registered new interface driver usb-storage
[    1.512359] USB Mass Storage support registered.
[    1.512664] mousedev: PS/2 mouse device common for all mice
[    1.515930] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.516174] i2c /dev entries driver
[    1.516815] Linux video capture interface: v2.00
[    1.516845] Driver for 1-wire Dallas network protocol.
[    1.516967] 1-Wire driver for the DS2760 battery monitor  chip  -
(c) 2004-2005, Szabolcs Gyurko
[    1.517669] OMAP Watchdog Timer Rev 0x00: initial timeout 60 sec
[    1.517822] Bluetooth: Bluetooth Driver for TI WiLink - Version 1.0
[    1.517913] cpuidle: using governor ladder
[    1.517944] cpuidle: using governor menu
[    1.519592] _regulator_get: omap_hsmmc.0 supply vmmc_aux not found,
using dummy regulator
[    1.522094] _regulator_get: omap_hsmmc.4 supply vmmc_aux not found,
using dummy regulator
[    1.592010] Registered led device: pandaboard::status1
[    1.592102] Registered led device: pandaboard::status2
[    1.592712] omap-iommu omap-iommu.0: ducati registered
[    1.593780] ALSA device list:
[    1.593780]   No soundcards found.
[    1.594940] TCP cubic registered
[    1.595581] NET: Registered protocol family 10
[    1.598114] NET: Registered protocol family 17
[    1.598266] lib80211: common routines for IEEE802.11 drivers
[    1.598297] lib80211_crypt: registered algorithm 'NULL'
[    1.598297] Registering the dns_resolver key type
[    1.598327] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 1
[    1.598358] ThumbEE CPU extension supported.
[    1.598388] Registering SWP/SWPB emulation handler
[    1.600585] omap_vc_i2c_init: I2C config for all channels must match.
[    1.600616] omap_vc_i2c_init: I2C config for all channels must match.
[    1.600799] hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
[    1.600830] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[    1.602111] Power Management for TI OMAP4.
[    1.602142] sr_init: No PMIC hook to init smartreflex
[    1.602294] smartreflex smartreflex.0: omap_sr_probe: SmartReflex
driver initialized
[    1.602416] smartreflex smartreflex.1: omap_sr_probe: SmartReflex
driver initialized
[    1.602539] smartreflex smartreflex.2: omap_sr_probe: SmartReflex
driver initialized
[    1.602691] SmartReflex Class3 initialized
[    1.610168] registered taskstats version 1
[    1.610321] omapfb omapfb: no driver for display: dvi
[    1.623474] omapdss error: timeout reading edid
[    1.629852] omap_hwmod: dss_hdmi: _wait_target_disable failed
[    1.632507] omap_hwmod: dss_dispc: _wait_target_disable failed
[    1.635131] omap_hwmod: dss_core: _wait_target_disable failed
[    1.653015] Console: switching to colour frame buffer device 80x30
[    1.658050] omap_hwmod: dss_dispc: _wait_target_disable failed
[    1.660644] omap_hwmod: dss_core: _wait_target_disable failed
[    1.663421] ehci-omap ehci-omap.0: port 1 high speed
[    1.663452] ehci-omap ehci-omap.0: GetStatus port:1 status 001005 0
 ACK POWER sig=se0 PE CONNECT
[    1.665924] omap_hwmod: dss_dispc: _wait_target_disable failed
[    1.668548] omap_hwmod: dss_core: _wait_target_disable failed
[    1.686309] regulator_init_complete: VANA: incomplete constraints, leaving on
[    1.687469] regulator_init_complete: VDAC: incomplete constraints, leaving on
[    1.688049] regulator_init_complete: VUSB: incomplete constraints, leaving on
[    1.688873] twl_rtc twl_rtc: setting system clock to 2012-01-06
11:35:33 UTC (1325849733)
[    1.689300] Freeing init memory: 240K
[    1.725799] usb 1-1: new high-speed USB device number 2 using ehci-omap
[    1.771179] udevd[68]: starting version 173
[    1.788543] ehci-omap ehci-omap.0: port 1 high speed
[    1.788574] ehci-omap ehci-omap.0: GetStatus port:1 status 001005 0
 ACK POWER sig=se0 PE CONNECT
[    1.882476] usb 1-1: udev 2, busnum 1, minor = 1
[    1.882507] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
[    1.882507] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.882934] usb 1-1: usb_probe_device
[    1.882934] usb 1-1: configuration #1 chosen from 1 choice
[    1.883117] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
[    1.883239] hub 1-1:1.0: usb_probe_interface
[    1.883270] hub 1-1:1.0: usb_probe_interface - got id
[    1.883270] hub 1-1:1.0: USB hub found
[    1.883453] hub 1-1:1.0: 5 ports detected
[    1.883453] hub 1-1:1.0: compound device; port removable status: FRRRR
[    1.883483] hub 1-1:1.0: individual port power switching
[    1.883483] hub 1-1:1.0: individual port over-current protection
[    1.883636] hub 1-1:1.0: TT per port
[    1.883666] hub 1-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    1.883666] hub 1-1:1.0: power on to power good time: 100ms
[    1.883941] hub 1-1:1.0: local power source is good
[    1.883972] hub 1-1:1.0: enabling power on all ports
[    1.884674] hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
[    1.984588] hub 1-1:1.0: port 1: status 0101 change 0001
[    2.085235] usb 1-1: link qh256-0001/ef2b23c0 start 1 [1/0 us]
[    2.085296] hub 1-1:1.0: state 7 ports 5 chg 0002 evt 0000
[    2.085449] hub 1-1:1.0: port 1, status 0101, change 0000, 12 Mb/s
[    2.104522] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    2.106475] mmc0: new high speed SDHC card at address 0007
[    2.107696] mmcblk0: mmc0:0007 SD08G 7.42 GiB
[    2.111999]  mmcblk0: p1 p2
[    2.171325] usb 1-1.1: new high-speed USB device number 3 using ehci-omap
[    2.291595] usb 1-1.1: udev 3, busnum 1, minor = 2
[    2.291595] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
[    2.291625] usb 1-1.1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.291961] usb 1-1.1: usb_probe_device
[    2.291992] usb 1-1.1: configuration #1 chosen from 1 choice
[    2.294281] usb 1-1.1: adding 1-1.1:1.0 (config #1, interface 0)
[    2.294433] smsc95xx 1-1.1:1.0: usb_probe_interface
[    2.294464] smsc95xx 1-1.1:1.0: usb_probe_interface - got id
[    2.294525] smsc95xx v1.0.4
[    2.422302] smsc95xx 1-1.1:1.0: eth0: register 'smsc95xx' at
usb-ehci-omap.0-1.1, smsc95xx USB 2.0 Ethernet, 1a:8b:
[    2.422424] hub 1-1:1.0: state 7 ports 5 chg 0000 evt 0002
[    2.823638] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
data mode. Opts: (null)
[    5.319183] udevd[223]: starting version 173
[    6.641143] usb 1-1.1: link qh8-0001/eecde0c0 start 2 [1/0 us]
[    8.164916] smsc95xx 1-1.1:1.0: eth0: link up, 100Mbps,
full-duplex, lpa 0x45E1
[    8.581451] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=remount-ro
[    9.204528] init: failsafe main process (513) killed by TERM signal
[   10.159149] init: apport pre-start process (590) terminated with status 1
[   10.171966] init: alsa-restore main process (601) terminated with status 19
[   10.310028] init: apport post-stop process (630) terminated with status 1
[   16.678833] eth0: no IPv6 routers present
[   18.239624] Adding 524240k swap on /SWAP.swap.  Priority:-1
extents:11 across:571384k SS
[  616.003448] omap_hwmod: dss_hdmi: _wait_target_disable failed
[  616.006103] omap_hwmod: dss_dispc: _wait_target_disable failed
[  616.008728] omap_hwmod: dss_core: _wait_target_disable failed

On Tue, Jan 10, 2012 at 12:30 AM, Ming Lei <ming.lei@canonical.com> wrote:
> Hi,
>
> On Tue, Jan 10, 2012 at 6:49 AM, Will Deacon <will.deacon@arm.com> wrote:
>> On Mon, Jan 09, 2012 at 04:39:09PM +0000, Maynard Johnson wrote:
>>> On 01/08/2012 8:58 PM, Lik Lik wrote:
>>> > Hi all,
>>
>> Hi guys [adding a bunch of people to CC because this issue is really
>> annoying me now],
>>
>>> > I am an oprofile user and I need to profile one of my applications on a TI OMAP4
>>> > platform (pandaboard, to be specific). I have ubuntu 11.10 installed. My problem
>>> > is that oprofile always use the timer interrupt mode but doesn't recognize the
>>> > hardware counters, which I am sure my platform has.
>>
>> First and foremost, we can't currently generate PMU interrupts on OMAP4 in
>> mainline. There are some additional patches required for these to work:
>>
>> http://marc.info/?l=linux-arm-kernel&m=131946761428296&w=2
>>
>> However, as Stephane has pointed out here:
>>
>> http://marc.info/?l=linux-omap&m=132585784125352&w=2
>>
>> the interrupts still don't seem to work, even with the patches above
>> applied.
>>
>> Ming Lei doesn't seem to be replying to email anymore, so maybe somebody
>
> Sorry, I am on a trip now and no pandboard at my hand, so I may have
> time to verify
> the latest mainline next week after I return home.
>
> I remembered that last time I verified these patches on 3.2-rc2 and
> 3.2-rc2 next tree,
> and perf did work well on my pandaboard.
>
> Also seems there were reports that omap4 perf may not work on some specific
> uboot version even with these patches.
>
>> else on linux-omap could please help us? I'm hoping that we're just missing
>> some patches from somewhere, but it would be great if somebody could verify
>> this (and indeed, verify that the interrupts we're registering in the thread
>> above look sane).
>>
>>> OProfile userspace support for ARM Cortex-A9 was added by Will Deacon in June
>>> 2010. ?This support is available in OProfile 0.9.7. ?According to Will's
>>> posting, the kernel support was due to be added to Ubuntu Maverick, so I would
>>> expect your version should support CA9 out of the box. ?If not already using
>>> oprofile 0.9.7, please upgrade to that version and retry. ?If it still doesn't
>>> work, please re-post with complete information (kernel version, oprofile command
>>> output, and contents of /dev/oprofile/cpu_type).
>>
>> If with the latest OProfile, `timer mode' is still reported then you should
>> check that you have CONFIG_HW_PERF_EVENTS enabled in your kernel. It still
>> won't work though, because of the problems I mentioned above.
>
> If debug message from 'dmesg' can be provided, maybe we can find clue
> about the problem.
>
> thanks,
> --
> Ming Lei
