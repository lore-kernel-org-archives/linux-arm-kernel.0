From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 31 May 2016 12:32:04 +0900
Subject: [RFC 0/4] ARM: dts: r8a7790: lager: use demuxer for I2C
Message-ID: <1464665528-11398-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the intention of this series is to extend use of the demuxer for I2C
on the lager/r8a7790 to cover all I2C IP blocks.

This is based on work by Wolfram Sang.

I have not included GPIO in the demux configuration. This is in keeping
with the existing usage for IIC0/I2C0.

Any advice or assistance in testing would be gratefully received.

For reference a boot log is provided below.

This series is based on renesas-devel-20160530-v4.7-rc1.

To aid review it is provided in git at:

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/i2c-demux

I also intend to add demux for I2C to other R-Car Gen2 boards as a follow-up.


Simon Horman (4):
  ARM: dts: r8a7790: lager: rename i2cexio as i2cexio0
  ARM: dts: r8a7790: lager: use demuxer for IIC1/I2C1
  ARM: dts: r8a7790: lager: use demuxer for IIC2/I2C2
  ARM: dts: r8a7790: lager: use demuxer for IIC3/I2C3

 arch/arm/boot/dts/r8a7790-lager.dts | 241 ++++++++++++++++++++++--------------
 1 file changed, 151 insertions(+), 90 deletions(-)

--- Boot log ---

Lager booted with kernel using shmobile_defconfig.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.7.0-rc1-11566-g37773b1e292b (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #621 SMP Tue May 31 12:07:50 JST 2016
[    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Lager
[    0.000000] Ignoring memory block 0x140000000 - 0x200000000
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c0a3d680, node_mem_map ef7f9000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 11 pages/cpu @ef77b000 s22720 r0 d22336 u45056
[    0.000000] pcpu-alloc: s22720 r0 d22336 u45056 alloc=11*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260608
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1029228K/1048576K available (6148K kernel code, 251K rwdata, 1480K rodata, 1024K init, 292K bss, 19348K reserved, 0K cma-reserved, 262144K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]       .text : 0xc0008000 - 0xc087307c   (8621 kB)
[    0.000000]       .init : 0xc0900000 - 0xc0a00000   (1024 kB)
[    0.000000]       .data : 0xc0a00000 - 0xc0a3ef80   ( 252 kB)
[    0.000000]        .bss : 0xc0a40000 - 0xc0a8919c   ( 293 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 10.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000004] sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
[    0.000014] Switching to timer-based delay loop, resolution 100ns
[    0.000525] Console: colour dummy device 80x30
[    0.000812] console [tty0] enabled
[    0.000837] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
[    0.000862] pid_max: default: 32768 minimum: 301
[    0.000987] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001004] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001448] CPU: Testing write buffer coherency: ok
[    0.001708] CPU0: update cpu_capacity 1535
[    0.001725] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.003528] Setting up static identity map for 0x40100000 - 0x40100058
[    0.006976] CPU1: update cpu_capacity 1535
[    0.006982] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.007849] CPU2: update cpu_capacity 1535
[    0.007856] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.008731] CPU3: update cpu_capacity 1535
[    0.008737] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.009384] CPU4: failed to boot: -22
[    0.010088] CPU5: failed to boot: -22
[    0.010715] CPU6: failed to boot: -22
[    0.011335] CPU7: failed to boot: -22
[    0.011423] Brought up 4 CPUs
[    0.011437] SMP: Total of 4 processors activated (80.00 BogoMIPS).
[    0.011450] CPU: All CPU(s) started in SVC mode.
[    0.060700] devtmpfs: initialized
[    0.070169] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.070566] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.127064] pinctrl core: initialized pinctrl subsystem
[    0.268112] NET: Registered protocol family 16
[    0.268305] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.271065] renesas_irqc e61c0000.interrupt-controller: driving 4 irqs
[    0.274207] sh-pfc e6060000.pfc: r8a77900_pfc support registered
[    0.279976] No ATAGs?
[    0.280000] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.280025] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.280067] IRQ2 is asserted, installing da9063/da9210 regulator quirk
[    0.791592] vgaarb: loaded
[    0.880763] SCSI subsystem initialized
[    0.880929] libata version 3.00 loaded.
[    0.881158] usbcore: registered new interface driver usbfs
[    0.881216] usbcore: registered new interface driver hub
[    0.881318] usbcore: registered new device driver usb
[    0.881857] media: Linux media interface: v0.10
[    0.881915] Linux video capture interface: v2.00
[    0.882284] sh_cmt ffca0000.timer: ch0: used for clock events
[    0.882308] sh_cmt ffca0000.timer: ch1: used as clock source
[    0.882326] clocksource: ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
[    0.882978] Advanced Linux Sound Architecture Driver Initialized.
[    0.883681] clocksource: Switched to clocksource arch_sys_counter
[    1.233687] NET: Registered protocol family 2
[    1.353767] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    1.353836] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    1.353939] TCP: Hash tables configured (established 8192 bind 8192)
[    1.353991] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    1.354023] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    1.473682] NET: Registered protocol family 1
[    1.533688] RPC: Registered named UNIX socket transport module.
[    1.533704] RPC: Registered udp transport module.
[    1.533716] RPC: Registered tcp transport module.
[    1.533728] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.533744] PCI: CLS 0 bytes, default 64
[    1.594689] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.595243] workingset: timestamp_bits=28 max_order=18 bucket_order=0
[    1.833703] NFS: Registering the id_resolver key type
[    1.833741] Key type id_resolver registered
[    1.833754] Key type id_legacy registered
[    1.833775] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.833790] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.835424] bounce: pool size: 64 pages
[    1.903719] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    1.903741] io scheduler noop registered
[    1.903754] io scheduler deadline registered
[    1.903775] io scheduler cfq registered (default)
[    1.905105] gpio_rcar e6050000.gpio: driving 32 GPIOs
[    1.905547] gpio_rcar e6051000.gpio: driving 30 GPIOs
[    1.905973] gpio_rcar e6052000.gpio: driving 30 GPIOs
[    1.906416] gpio_rcar e6053000.gpio: driving 32 GPIOs
[    1.906843] gpio_rcar e6054000.gpio: driving 32 GPIOs
[    1.907281] gpio_rcar e6055000.gpio: driving 32 GPIOs
[    1.907986] pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
[    1.908152] pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
[    1.908173] pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
[    1.908189] pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
[    1.908205] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.908248] pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
[    1.908277] pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
[    1.908297] pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    1.908517] pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
[    1.908547] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    1.908627] pci 0000:00:01.0: supports D1 D2
[    1.908643] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
[    1.908857] pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
[    1.908887] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    1.908967] pci 0000:00:02.0: supports D1 D2
[    1.908981] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
[    1.909199] PCI: bus0: Fast back to back transfers disabled
[    1.909219] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    1.909309] pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
[    1.909330] pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
[    1.909378] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    1.909422] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    1.909666] pci-rcar-gen2 ee0b0000.pci: PCI: bus0 revision 11
[    1.909819] pci-rcar-gen2 ee0b0000.pci: PCI host bridge to bus 0001:01
[    1.909836] pci_bus 0001:01: root bus resource [io  0xee0a0000-0xee0a10ff]
[    1.909852] pci_bus 0001:01: root bus resource [mem 0xee0a0000-0xee0a10ff]
[    1.909867] pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
[    1.909902] pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
[    1.909928] pci 0001:01:00.0: reg 0x10: [mem 0xee0b0800-0xee0b0bff]
[    1.909947] pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    1.910152] pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
[    1.910182] pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    1.910263] pci 0001:01:01.0: supports D1 D2
[    1.910278] pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
[    1.910486] pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
[    1.910516] pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    1.910595] pci 0001:01:02.0: supports D1 D2
[    1.910610] pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
[    1.910818] PCI: bus1: Fast back to back transfers disabled
[    1.910836] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    1.910968] pci 0001:01:01.0: BAR 0: assigned [mem 0xee0a0000-0xee0a0fff]
[    1.910988] pci 0001:01:02.0: BAR 0: assigned [mem 0xee0a1000-0xee0a10ff]
[    1.911024] pci 0001:01:01.0: enabling device (0140 -> 0142)
[    1.911066] pci 0001:01:02.0: enabling device (0140 -> 0142)
[    1.911241] pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
[    1.911400] pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0002:02
[    1.911418] pci_bus 0002:02: root bus resource [io  0xee0c0000-0xee0c10ff]
[    1.911433] pci_bus 0002:02: root bus resource [mem 0xee0c0000-0xee0c10ff]
[    1.911448] pci_bus 0002:02: No busn resource found for root bus, will use [bus 02-ff]
[    1.911485] pci 0002:02:00.0: [1033:0000] type 00 class 0x060000
[    1.911509] pci 0002:02:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
[    1.911528] pci 0002:02:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    1.911732] pci 0002:02:01.0: [1033:0035] type 00 class 0x0c0310
[    1.911761] pci 0002:02:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    1.911840] pci 0002:02:01.0: supports D1 D2
[    1.911855] pci 0002:02:01.0: PME# supported from D0 D1 D2 D3hot
[    1.912067] pci 0002:02:02.0: [1033:00e0] type 00 class 0x0c0320
[    1.912096] pci 0002:02:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    1.912176] pci 0002:02:02.0: supports D1 D2
[    1.912190] pci 0002:02:02.0: PME# supported from D0 D1 D2 D3hot
[    1.912408] PCI: bus2: Fast back to back transfers disabled
[    1.912426] pci_bus 0002:02: busn_res: [bus 02-ff] end is updated to 02
[    1.912612] pci 0002:02:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
[    1.912633] pci 0002:02:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
[    1.912669] pci 0002:02:01.0: enabling device (0140 -> 0142)
[    1.912709] pci 0002:02:02.0: enabling device (0140 -> 0142)
[    1.924475] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.925658] SuperH (H)SCI(F) driver initialized
[    1.926117] e6c50000.serial: ttySC1 at MMIO 0xe6c50000 (irq = 99, base_baud = 0) is a scifa
[    1.926642] e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 100, base_baud = 0) is a scif
[    3.034029] console [ttySC0] enabled
[    3.038133] [drm] Initialized drm 1.1.0 20060810
[    3.043595] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.050230] [drm] No driver support for vblank timestamp query.
[    3.056800] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    3.065038] scsi host0: sata_rcar
[    3.068573] ata1: SATA max UDMA/133 irq 102
[    3.073495] renesas_spi e6b10000.spi: DMA available
[    3.079099] m25p80 spi0.0: s25fl512s (65536 Kbytes)
[    3.084040] 3 ofpart partitions found on MTD device spi0.0
[    3.089530] Creating 3 MTD partitions on "spi0.0":
[    3.094340] 0x000000000000-0x000000040000 : "loader"
[    3.100176] 0x000000040000-0x000000440000 : "user"
[    3.105794] 0x000000440000-0x000004000000 : "flash"
[    3.111484] renesas_spi e6b10000.spi: probed
[    3.116579] spi_sh_msiof e6e10000.spi: DMA available
[    3.122717] CAN device driver interface
[    3.127403] libphy: sh_mii: probed
[    3.131875] sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:6e:71, IRQ 101.
[    3.141156] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.147703] ehci-pci: EHCI PCI platform driver
[    3.152278] ehci-pci 0000:00:02.0: EHCI Host Controller
[    3.157536] ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
[    3.165054] ehci-pci 0000:00:02.0: irq 116, io mem 0xee081000
[    3.183686] ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
[    3.190140] hub 1-0:1.0: USB hub found
[    3.193942] hub 1-0:1.0: 1 port detected
[    3.198274] ehci-pci 0001:01:02.0: EHCI Host Controller
[    3.203520] ehci-pci 0001:01:02.0: new USB bus registered, assigned bus number 2
[    3.211029] ehci-pci 0001:01:02.0: irq 117, io mem 0xee0a1000
[    3.233685] ehci-pci 0001:01:02.0: USB 2.0 started, EHCI 1.00
[    3.240066] hub 2-0:1.0: USB hub found
[    3.243862] hub 2-0:1.0: 1 port detected
[    3.248185] ehci-pci 0002:02:02.0: EHCI Host Controller
[    3.253429] ehci-pci 0002:02:02.0: new USB bus registered, assigned bus number 3
[    3.260933] ehci-pci 0002:02:02.0: irq 118, io mem 0xee0c1000
[    3.283685] ehci-pci 0002:02:02.0: USB 2.0 started, EHCI 1.00
[    3.290051] hub 3-0:1.0: USB hub found
[    3.293853] hub 3-0:1.0: 1 port detected
[    3.298131] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.304340] ohci-pci: OHCI PCI platform driver
[    3.308853] ohci-pci 0000:00:01.0: OHCI PCI host controller
[    3.314457] ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 4
[    3.321895] ohci-pci 0000:00:01.0: irq 116, io mem 0xee080000
[    3.414324] hub 4-0:1.0: USB hub found
[    3.418107] hub 4-0:1.0: 1 port detected
[    3.422384] ohci-pci 0001:01:01.0: OHCI PCI host controller
[    3.427989] ohci-pci 0001:01:01.0: new USB bus registered, assigned bus number 5
[    3.435433] ohci-pci 0001:01:01.0: irq 117, io mem 0xee0a0000
[    3.493688] ata1: link resume succeeded after 1 retries
[    3.524349] hub 5-0:1.0: USB hub found
[    3.528132] hub 5-0:1.0: 1 port detected
[    3.532425] ohci-pci 0002:02:01.0: OHCI PCI host controller
[    3.538041] ohci-pci 0002:02:01.0: new USB bus registered, assigned bus number 6
[    3.545491] ohci-pci 0002:02:01.0: irq 118, io mem 0xee0c0000
[    3.603701] ata1: SATA link down (SStatus 0 SControl 300)
[    3.634334] hub 6-0:1.0: USB hub found
[    3.638120] hub 6-0:1.0: 1 port detected
[    3.642710] sh-pfc e6060000.pfc: pin GP_5_19 already requested by ee090000.pci; cannot claim for e6590000.usb
[    3.652649] sh-pfc e6060000.pfc: pin-179 (e6590000.usb) status -22
[    3.658844] sh-pfc e6060000.pfc: could not request pin 179 (GP_5_19) from group usb0_ovc_vbus  on device sh-pfc
[    3.668949] renesas_usbhs e6590000.usb: Error applying setting, reverse things back
[    3.676844] renesas_usbhs e6590000.usb: transceiver found
[    3.682404] renesas_usbhs e6590000.usb: gadget probed
[    3.687558] phy phy-e6590100.usb-phy.1: phy init failed --> -16
[    3.693486] renesas_usbhs e6590000.usb: probed
[    3.698157] using random self ethernet address
[    3.702609] using random host ethernet address
[    3.707486] usb0: HOST MAC a2:bd:c8:b5:c1:92
[    3.711778] usb0: MAC d2:33:7b:bb:af:f1
[    3.715639] using random self ethernet address
[    3.720087] using random host ethernet address
[    3.724590] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    3.731208] g_ether gadget: g_ether ready
[    3.735412] mousedev: PS/2 mouse device common for all mice
[    3.741394] i2c /dev entries driver
[    3.746291] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
[    3.754293] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
[    3.762237] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
[    3.777719] i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 100000 Hz
[    3.785054] i2c 11-0058: Masking da9063 interrupt sources
[    3.796955] da9063 11-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
[    3.834992] da9063-rtc da9063-rtc: rtc core: registered da9063-rtc as rtc0
[    3.848136] i2c 11-0068: Masking da9210 interrupt sources
[    3.857027] i2c 11-0068: IRQ2 is not asserted, removing quirk
[    3.864260] DA9210: Bringing 1080000uV into 1000000-1000000uV
[    3.875154] adv7180 10-0020: chip found @ 0x20 (i2c-demux (master i2c-6))
[    3.895816] soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
[    3.903400] rcar_jpu fe980000.jpeg-codec: encoder device registered as /dev/video1
[    3.910998] rcar_jpu fe980000.jpeg-codec: decoder device registered as /dev/video2
[    3.920291] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 bru was not initialized!
[    3.928847] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 hsi was not initialized!
[    3.937395] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 hst was not initialized!
[    3.945939] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 rpf.0 was not initialized!
[    3.954657] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 rpf.1 was not initialized!
[    3.963366] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 rpf.2 was not initialized!
[    3.972084] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 rpf.3 was not initialized!
[    3.980801] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 rpf.4 was not initialized!
[    3.989518] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 sru was not initialized!
[    3.998062] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 uds.0 was not initialized!
[    4.006778] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 wpf.0 was not initialized!
[    4.015495] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 wpf.1 was not initialized!
[    4.024212] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 wpf.2 was not initialized!
[    4.032921] vsp1 fe920000.vsp1: Entity type for entity fe920000.vsp1 wpf.3 was not initialized!
[    4.045012] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 bru was not initialized!
[    4.053558] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 hsi was not initialized!
[    4.062108] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 hst was not initialized!
[    4.070653] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 lut was not initialized!
[    4.079197] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 rpf.0 was not initialized!
[    4.087914] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 rpf.1 was not initialized!
[    4.096631] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 rpf.2 was not initialized!
[    4.105349] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 rpf.3 was not initialized!
[    4.114065] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 rpf.4 was not initialized!
[    4.122774] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 sru was not initialized!
[    4.131317] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 uds.0 was not initialized!
[    4.140037] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 uds.1 was not initialized!
[    4.148754] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 uds.2 was not initialized!
[    4.157471] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 wpf.0 was not initialized!
[    4.166187] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 wpf.1 was not initialized!
[    4.174904] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 wpf.2 was not initialized!
[    4.183613] vsp1 fe928000.vsp1: Entity type for entity fe928000.vsp1 wpf.3 was not initialized!
[    4.195933] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 bru was not initialized!
[    4.204493] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 hsi was not initialized!
[    4.213029] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 hst was not initialized!
[    4.221572] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 lif was not initialized!
[    4.230116] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 lut was not initialized!
[    4.238659] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 rpf.0 was not initialized!
[    4.247375] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 rpf.1 was not initialized!
[    4.256092] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 rpf.2 was not initialized!
[    4.264808] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 rpf.3 was not initialized!
[    4.273517] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 uds.0 was not initialized!
[    4.282232] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 wpf.0 was not initialized!
[    4.290949] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 wpf.1 was not initialized!
[    4.299665] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 wpf.2 was not initialized!
[    4.308382] vsp1 fe930000.vsp1: Entity type for entity fe930000.vsp1 wpf.3 was not initialized!
[    4.320287] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 bru was not initialized!
[    4.328847] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 hsi was not initialized!
[    4.337393] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 hst was not initialized!
[    4.345937] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 lif was not initialized!
[    4.354480] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 lut was not initialized!
[    4.363016] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 rpf.0 was not initialized!
[    4.371733] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 rpf.1 was not initialized!
[    4.380449] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 rpf.2 was not initialized!
[    4.389165] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 rpf.3 was not initialized!
[    4.397887] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 uds.0 was not initialized!
[    4.406604] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 wpf.0 was not initialized!
[    4.415320] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 wpf.1 was not initialized!
[    4.424037] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 wpf.2 was not initialized!
[    4.432746] vsp1 fe938000.vsp1: Entity type for entity fe938000.vsp1 wpf.3 was not initialized!
[    4.445893] rcar_thermal e61f0000.thermal: 1 sensor probed
[    4.457775] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    4.463122] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    4.503711] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    4.511151] usbcore: registered new interface driver usbhid
[    4.516743] usbhid: USB HID core driver
[    4.526878] rcar_sound ec500000.sound: probed
[    4.901310] mmc0: new high speed MMC card at address 0001
[    4.907087] mmcblk0: mmc0:0001 MMC08G 7.33 GiB 
[    4.911791] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    4.913698] NET: Registered protocol family 10
[    4.914406] sit: IPv6 over IPv4 tunneling driver
[    4.914978] NET: Registered protocol family 17
[    4.914989] can: controller area network core (rev 20120528 abi 9)
[    4.915038] NET: Registered protocol family 29
[    4.915043] can: raw protocol (rev 20120528)
[    4.915047] can: broadcast manager protocol (rev 20120528 t)
[    4.915054] can: netlink gateway (rev 20130117) max_hops=1
[    4.957494] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    4.965208]  mmcblk0: p1
[    5.013753] Key type dns_resolver registered
[    5.018099] Registering SWP/SWPB emulation handler
[    5.025432] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.032054] [drm] No driver support for vblank timestamp query.
[    5.067400] Console: switching to colour frame buffer device 128x48
[    5.082885] rcar-du feb00000.display: fb0:  frame buffer device
[    5.089384] [drm] Device feb00000.display probed
[    5.094664] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    5.233861] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    5.242410] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    5.383844] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    5.393429] asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
[    5.402269] input: keyboard as /devices/platform/keyboard/input/input0
[    5.410872] da9063-rtc da9063-rtc: setting system clock to 2000-01-01 00:00:01 UTC (946684801)
[    5.495935] Micrel KSZ8041RNLI ee700000.etherne:01: attached PHY driver [Micrel KSZ8041RNLI] (mii_bus:phy_addr=ee700000.etherne:01, irq=307)
[    5.508852] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    5.514872] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[    5.633835] mmc1: new ultra high speed SDR50 SDHC card at address 0001
[    5.640811] mmcblk1: mmc1:0001 00000 29.8 GiB 
[    5.648918]  mmcblk1: p1
[    8.411027] sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
[    8.413703] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    8.433686] Sending DHCP requests ., OK
[    8.613682] IP-Config: Got DHCP answer from 10.3.3.2, my address is 10.3.3.167
[    8.625312] IP-Config: Complete:
[    8.632542]      device=eth0, hwaddr=2e:09:0a:00:6e:71, ipaddr=10.3.3.167, mask=255.255.255.0, gw=10.3.3.2
[    8.646341]      host=10.3.3.167, domain=isobedori.kobe.vergenet.net kanocho.kobe.vergenet.net vergenet., nis-domain=(none)
[    8.661696]      bootserver=10.3.3.135, rootserver=10.3.3.135, rootpath=/srv/nfs/lager-armhf,rsize=1024,wsize=1024     nameserver0=10.3.3.2, nameserver1=8.8.8.8
[    8.684784] SDHI2 Vcc: disabling
[    8.692313] SDHI2 VccQ: disabling
[    8.700112] ALSA device list:
[    8.707304]   #0: rsnd-dai.0-ak4642-hifi
[    8.720578] VFS: Mounted root (nfs filesystem) on device 0:14.
[    8.731125] devtmpfs: mounted
[    8.739080] Freeing unused kernel memory: 1024K (c0900000 - c0a00000)
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd[    9.646302] udevd[1089]: starting version 175
.
Synthesizing the initial hotplug events...done.
[    9.781824] random: nonblocking pool is initialized
Waiting for /dev to be fully populated...done.
Activating swap...done.
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux 2.20.1
done.
Mounting local filesystems...done.
Activating swapfile swap...done.
Cleaning up temporary files....
Cleaning up ifupdown....
Setting up networking....
Configuring network interfaces...Internet Systems Consortium DHCP Client 4.2.2
Copyright 2004-2011 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/2e:09:0a:00:6e:71
Sending on   LPF/eth0/2e:09:0a:00:6e:71
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPOFFER from 10.3.3.2
DHCPACK from 10.3.3.2
RTNETLINK answers: File exists
bound to 10.3.3.167 -- renewal in 269 seconds.
done.
Cleaning up temporary files....
Setting up ALSA...warning: 'alsactl restore' failed with error message 'Found hardware: "rsnd-dai_0-ak46" "" "" "" ""
Hardware is initialized using a generic method'...done.
Setting kernel variables ...done.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting enhanced syslogd: rsyslogd.
Starting periodic command scheduler: cron.
Starting system message bus: dbus.
Starting OpenBSD Secure Shell server: sshd.

Debian GNU/Linux wheezy/sid debian ttySC0

debian login: root
Password: 
Last login: Thu Jan  1 00:00:21 UTC 1970 on ttySC0
Linux debian 4.7.0-rc1-11566-g37773b1e292b #621 SMP Tue May 31 12:07:50 JST 2016 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root at debian:~# cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
 19:       5428       4738       2964       2784     GIC-0  27 Edge      arch_timer
 21:          0          0          0          0     GIC-0  36 Level     e6050000.gpio
 22:          0          0          0          0     GIC-0  37 Level     e6051000.gpio
 23:          0          0          0          0     GIC-0  38 Level     e6052000.gpio
 24:          0          0          0          0     GIC-0  39 Level     e6053000.gpio
 25:          0          0          0          0     GIC-0  40 Level     e6054000.gpio
 26:          0          0          0          0     GIC-0  41 Level     e6055000.gpio
 27:          0          0          0          0     GIC-0 101 Level     e61f0000.thermal
 28:          0          0          0          0     GIC-0 174 Level     ffca0000.timer
 30:          1          0          0          0     GIC-0  32 Level     e61c0000.interrupt-controller
 31:          0          0          0          0     GIC-0  33 Level     e61c0000.interrupt-controller
 32:          6          0          0          0     GIC-0  34 Level     e61c0000.interrupt-controller
 33:          0          0          0          0     GIC-0  35 Level     e61c0000.interrupt-controller
 34:          0          0          0          0     GIC-0 229 Level     e6700000.dma-controller:error
 35:          0          0          0          0     GIC-0 232 Level     e6700000.dma-controller:0
 36:          0          0          0          0     GIC-0 233 Level     e6700000.dma-controller:1
 37:          0          0          0          0     GIC-0 234 Level     e6700000.dma-controller:2
 38:          0          0          0          0     GIC-0 235 Level     e6700000.dma-controller:3
 39:          0          0          0          0     GIC-0 236 Level     e6700000.dma-controller:4
 40:          0          0          0          0     GIC-0 237 Level     e6700000.dma-controller:5
 41:          0          0          0          0     GIC-0 238 Level     e6700000.dma-controller:6
 42:          0          0          0          0     GIC-0 239 Level     e6700000.dma-controller:7
 43:          0          0          0          0     GIC-0 240 Level     e6700000.dma-controller:8
 44:          0          0          0          0     GIC-0 241 Level     e6700000.dma-controller:9
 45:          0          0          0          0     GIC-0 242 Level     e6700000.dma-controller:10
 46:          0          0          0          0     GIC-0 243 Level     e6700000.dma-controller:11
 47:          0          0          0          0     GIC-0 244 Level     e6700000.dma-controller:12
 48:          0          0          0          0     GIC-0 245 Level     e6700000.dma-controller:13
 49:          0          0          0          0     GIC-0 246 Level     e6700000.dma-controller:14
 50:          0          0          0          0     GIC-0 252 Level     e6720000.dma-controller:error
 51:          0          0          0          0     GIC-0 248 Level     e6720000.dma-controller:0
 52:          0          0          0          0     GIC-0 249 Level     e6720000.dma-controller:1
 53:          0          0          0          0     GIC-0 250 Level     e6720000.dma-controller:2
 54:        203          0          0          0     GIC-0 251 Level     e6720000.dma-controller:3
 55:          0          0          0          0     GIC-0 340 Level     e6720000.dma-controller:4
 56:        171          0          0          0     GIC-0 341 Level     e6720000.dma-controller:5
 57:          0          0          0          0     GIC-0 342 Level     e6720000.dma-controller:6
 58:          0          0          0          0     GIC-0 343 Level     e6720000.dma-controller:7
 59:          0          0          0          0     GIC-0 344 Level     e6720000.dma-controller:8
 60:          0          0          0          0     GIC-0 345 Level     e6720000.dma-controller:9
 61:          0          0          0          0     GIC-0 346 Level     e6720000.dma-controller:10
 62:          0          0          0          0     GIC-0 347 Level     e6720000.dma-controller:11
 63:          0          0          0          0     GIC-0 348 Level     e6720000.dma-controller:12
 64:          0          0          0          0     GIC-0 349 Level     e6720000.dma-controller:13
 65:          0          0          0          0     GIC-0 350 Level     e6720000.dma-controller:14
 66:          0          0          0          0     GIC-0 378 Level     ec700000.dma-controller:error
 67:          0          0          0          0     GIC-0 352 Level     ec700000.dma-controller:0
 68:          0          0          0          0     GIC-0 353 Level     ec700000.dma-controller:1
 69:          0          0          0          0     GIC-0 354 Level     ec700000.dma-controller:2
 70:          0          0          0          0     GIC-0 355 Level     ec700000.dma-controller:3
 71:          0          0          0          0     GIC-0 356 Level     ec700000.dma-controller:4
 72:          0          0          0          0     GIC-0 357 Level     ec700000.dma-controller:5
 73:          0          0          0          0     GIC-0 358 Level     ec700000.dma-controller:6
 74:          0          0          0          0     GIC-0 359 Level     ec700000.dma-controller:7
 75:          0          0          0          0     GIC-0 360 Level     ec700000.dma-controller:8
 76:          0          0          0          0     GIC-0 361 Level     ec700000.dma-controller:9
 77:          0          0          0          0     GIC-0 362 Level     ec700000.dma-controller:10
 78:          0          0          0          0     GIC-0 363 Level     ec700000.dma-controller:11
 79:          0          0          0          0     GIC-0 364 Level     ec700000.dma-controller:12
 80:          0          0          0          0     GIC-0 379 Level     ec720000.dma-controller:error
 81:          0          0          0          0     GIC-0 365 Level     ec720000.dma-controller:0
 82:          0          0          0          0     GIC-0 366 Level     ec720000.dma-controller:1
 83:          0          0          0          0     GIC-0 367 Level     ec720000.dma-controller:2
 84:          0          0          0          0     GIC-0 368 Level     ec720000.dma-controller:3
 85:          0          0          0          0     GIC-0 369 Level     ec720000.dma-controller:4
 86:          0          0          0          0     GIC-0 370 Level     ec720000.dma-controller:5
 87:          0          0          0          0     GIC-0 371 Level     ec720000.dma-controller:6
 88:          0          0          0          0     GIC-0 372 Level     ec720000.dma-controller:7
 89:          0          0          0          0     GIC-0 373 Level     ec720000.dma-controller:8
 90:          0          0          0          0     GIC-0 374 Level     ec720000.dma-controller:9
 91:          0          0          0          0     GIC-0 375 Level     ec720000.dma-controller:10
 92:          0          0          0          0     GIC-0 376 Level     ec720000.dma-controller:11
 93:          0          0          0          0     GIC-0 377 Level     ec720000.dma-controller:12
 94:          0          0          0          0     GIC-0 141 Level     e65a0000.dma-controller:0, e65a0000.dma-controller:1
 95:          0          0          0          0     GIC-0 142 Level     e65b0000.dma-controller:0, e65b0000.dma-controller:1
 96:        546          0          0          0     GIC-0 202 Level     ee220000.mmc
 97:        385          0          0          0     GIC-0 197 Level     ee100000.sd
 98:          0          0          0          0     GIC-0 199 Level     ee140000.sd
100:        387          0          0          0     GIC-0 184 Level     e6e60000.serial:mux
101:      34376          0          0          0     GIC-0 194 Level     eth0
102:          0          0          0          0     GIC-0 138 Level     sata_rcar[ee500000.sata]
103:          0          0          0          0     GIC-0 139 Level     e6590000.usb
104:          0          0          0          0     GIC-0 221 Level     e6ef1000.video
105:          0          0          0          0     GIC-0 298 Level     fe920000.vsp1
106:          0          0          0          0     GIC-0 299 Level     fe928000.vsp1
107:          0          0          0          0     GIC-0 278 Level     fe930000.vsp1
108:          0          0          0          0     GIC-0 279 Level     fe938000.vsp1
109:        301          0          0          0     GIC-0 288 Level     feb00000.display
110:          0          0          0          0     GIC-0 300 Level     feb00000.display
111:          0          0          0          0     GIC-0 301 Level     feb00000.display
112:          0          0          0          0     GIC-0 304 Level     fe980000.jpeg-codec
113:         13          0          0          0     GIC-0 216 Level     e6b10000.spi:mux
114:          0          0          0          0     GIC-0 189 Level     e6e10000.spi
116:          0          0          0          0     GIC-0 140 Level     ehci_hcd:usb1, ohci_hcd:usb4
117:          0          0          0          0     GIC-0 144 Level     ehci_hcd:usb2, ohci_hcd:usb5
118:          0          0          0          0     GIC-0 145 Level     ehci_hcd:usb3, ohci_hcd:usb6
165:          0          0          0          0  e6051000.gpio  14 Edge      SW2-1
166:          0          0          0          0  e6051000.gpio  15 Level     10-0039
175:          0          0          0          0  e6051000.gpio  24 Edge      SW2-2
177:          0          0          0          0  e6051000.gpio  26 Edge      SW2-3
179:          0          0          0          0  e6051000.gpio  28 Edge      SW2-4
217:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
233:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd
307:          1          0          0          0  e61c0000.interrupt-controller   0 Level     phy_interrupt
308:          0          0          0          0     GIC-0 206 Level     e6500000.i2c
309:          0          0          0          0     GIC-0 207 Level     e6510000.i2c
310:        205          0          0          0     GIC-0 208 Level     e6520000.i2c
311:        703          0          0          0     GIC-0 205 Level     e60b0000.i2c
312:          6          0          0          0  e61c0000.interrupt-controller   2 Level     da9063-irq, da9210
314:          0          0          0          0  da9063-irq   1 Level     ALARM
342:          0          0          0          0     GIC-0 402 Level     ec500000.sound
343:          0          0          0          0     GIC-0 403 Level     ec500000.sound
354:          0          0          0          0     GIC-0 386 Level     ec500000.sound
355:          0          0          0          0     GIC-0 387 Level     ec500000.sound
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:       1474       4093       5034       3458  Rescheduling interrupts
IPI3:         28         32         17         35  Function call interrupts
IPI4:          0          0          0          0  CPU stop interrupts
IPI5:          0          0          0          0  IRQ work interrupts
IPI6:          0          0          0          0  completion interrupts
Err:          0
root at debian:~# dmesg | grep -A 2 i[2i]c
[    3.741394] i2c /dev entries driver
[    3.746291] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
[    3.754293] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
[    3.762237] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
[    3.777719] i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 100000 Hz
[    3.785054] i2c 11-0058: Masking da9063 interrupt sources
[    3.796955] da9063 11-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
[    3.834992] da9063-rtc da9063-rtc: rtc core: registered da9063-rtc as rtc0
[    3.848136] i2c 11-0068: Masking da9210 interrupt sources
[    3.857027] i2c 11-0068: IRQ2 is not asserted, removing quirk
[    3.864260] DA9210: Bringing 1080000uV into 1000000-1000000uV
[    3.875154] adv7180 10-0020: chip found @ 0x20 (i2c-demux (master i2c-6))
[    3.895816] soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
[    3.903400] rcar_jpu fe980000.jpeg-codec: encoder device registered as /dev/video1
