From: jcm@jonmasters.org (Jon Masters)
Date: Thu, 2 Jun 2016 04:48:19 -0400
Subject: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
Message-ID: <88f8df44-d815-48d6-8dd9-38a2aa621608@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2016 11:14 AM, Tomasz Nowicki wrote:
> From the functionality point of view this series may be split into the
> following logic parts:
> 1. Export ECAM API and add parent device to pci_config_window
> 2. Add IO resources handling to PCI core code
> 3. Support for generic domain assignment based on ACPI
> 4. New MCFG driver
> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/
> 
> Patches has been built on top of 4.7-rc1 and can be found here:
> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v8)
> 
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.

Boot log from Intel Itanium server attached for existential proof of
non-interference with IA64 systems on latest patch revision.

Jon.
-------------- next part --------------
[    0.000000] Linux version 4.7.0-rc1.jcm_tomasz_pciv8_test+ (jcm at hamartia) (gcc version 4.4.5 (Debian 4.4.5-8) ) #3 SMP Thu Jun 2 04:34:49 EDT 2016
[    0.000000] EFI v1.10 by HP:
[    0.000000] efi:  SALsystab=0x3fefa000  ACPI 2.0=0x3fd5e000  SMBIOS=0x3fefc000  HCDP=0x3fd5c000 
[    0.000000] booting generic kernel on platform hpzx1
[    0.000000] PCDP: v0 at 0x3fd5c000
[    0.000000] earlycon: uart8250 at MMIO 0x00000000ff5e0000 (options '9600n8')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000003FD5E000 000028 (v02 HP    )
[    0.000000] ACPI: XSDT 0x000000003FD5E02C 00008C (v01 HP     rx2620   00000000 HP   00000000)
[    0.000000] ACPI: FACP 0x000000003FD672A0 0000F4 (v03 HP     rx2620   00000000 HP   00000000)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 32/16 (20160422/tbfadt-624)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe1Block: 32/16 (20160422/tbfadt-624)
[    0.000000] ACPI: DSDT 0x000000003FD5E100 005F3C (v01 HP     rx2620   00000007 INTL 02012044)
[    0.000000] ACPI: FACS 0x000000003FD67398 000040
[    0.000000] ACPI: SPCR 0x000000003FD673D8 000050 (v01 HP     rx2620   00000000 HP   00000000)
[    0.000000] ACPI: DBGP 0x000000003FD67428 000034 (v01 HP     rx2620   00000000 HP   00000000)
[    0.000000] ACPI: APIC 0x000000003FD67520 0000A4 (v01 HP     rx2620   00000000 HP   00000000)
[    0.000000] ACPI: SPMI 0x000000003FD67460 000050 (v04 HP     rx2620   00000000 HP   00000000)
[    0.000000] ACPI: CPEP 0x000000003FD674B0 000034 (v01 HP     rx2620   00000000 HP   00000000)
[    0.000000] ACPI: SSDT 0x000000003FD64040 0001D6 (v01 HP     rx2620   00000006 INTL 02012044)
[    0.000000] ACPI: SSDT 0x000000003FD64220 000702 (v01 HP     rx2620   00000006 INTL 02012044)
[    0.000000] ACPI: SSDT 0x000000003FD64930 000A16 (v01 HP     rx2620   00000006 INTL 02012044)
[    0.000000] ACPI: SSDT 0x000000003FD65350 000A16 (v01 HP     rx2620   00000006 INTL 02012044)
[    0.000000] ACPI: SSDT 0x000000003FD65D70 000A16 (v01 HP     rx2620   00000006 INTL 02012044)
[    0.000000] ACPI: SSDT 0x000000003FD66790 000A16 (v01 HP     rx2620   00000006 INTL 02012044)
[    0.000000] ACPI: SSDT 0x000000003FD671B0 0000EB (v01 HP     rx2620   00000006 INTL 02012044)
[    0.000000] ACPI: Local APIC address c0000000fee00000
[    0.000000] 1 CPUs available, 1 CPUs total
[    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] warning: skipping physical page 0
[    0.000000] warning: skipping physical page 0
[    0.000000] warning: skipping physical page 0
[    0.000000] warning: skipping physical page 0
[    0.000000] Initial ramdisk at: 0xe00000003d4aa000 (17110715 bytes)
[    0.000000] SAL 3.1: HP version 3.15
[    0.000000] SAL Platform features: None
[    0.000000] SAL: AP wakeup using external interrupt vector 0xff
[    0.000000] MCA related initialization done
[    0.000000] warning: skipping physical page 0
[    0.000000] Virtual mem_map starts at 0xa0007fffffc80000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000004000-0x00000000ffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000004000-0x000000003f4b3fff]
[    0.000000]   node   0: [mem 0x000000003fc00000-0x000000003fc7bfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000004000-0x000000003fc7bfff]
[    0.000000] Built 1 zonelists in Node order, mobility grouping off.  Total pages: 64619
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: BOOT_IMAGE=scsi0:/EFI/debian/vmtest root=/dev/sda2  ro
[    0.000000] PID hash table entries: 4096 (order: 1, 32768 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 989776K/1037488K available (12192K kernel code, 1251K rwdata, 1440K rodata, 816K init, 816K bss, 47712K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=256
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
[    0.000000] NR_IRQS:1024
[    0.000000] ACPI: Local APIC address c0000000fee00000
[    0.000000] GSI 36 (level, low) -> CPU 0 (0x0000) vector 49
[    0.000000] clocksource: itc: mask: 0xffffffffffffffff max_cycles: 0x17101df767f, max_idle_ns: 440795286379 ns
[    0.000000] Console: colour dummy device 80x25
[    0.192000] Calibrating delay loop... 2390.01 BogoMIPS (lpj=4780032)
[    0.288000] pid_max: default: 32768 minimum: 301
[    0.348000] ACPI: Core revision 20160422
[    0.400000] Security Framework initialized
[    0.452000] SELinux:  Disabled at boot.
[    0.504000] Dentry cache hash table entries: 131072 (order: 6, 1048576 bytes)
[    0.596000] Inode-cache hash table entries: 65536 (order: 5, 524288 bytes)
[    0.688000] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.780000] Mountpoint-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.872000] Boot processor id 0x0/0x0
[    0.920000] Brought up 1 CPUs
[    0.960000] Total of 1 processors activated (2390.01 BogoMIPS).
[    1.040000] devtmpfs: initialized
[    1.084000] SMBIOS 2.3 present.
[    1.124000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.252000] NET: Registered protocol family 16
[    1.312000] ACPI: bus type PCI registered
[    1.364000] HugeTLB registered 256 MB page size, pre-allocated 0 pages
[    1.452000] ACPI: Added _OSI(Module Device)
[    1.508000] ACPI: Added _OSI(Processor Device)
[    1.564000] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.628000] ACPI: Added _OSI(Processor Aggregator Device)
[    1.704000] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    1.784000] 
[    1.804000] kernel unaligned access to 0xc0000000ff5c1016, ip=0xa00000010059b1e0
[    1.904000] kernel unaligned access to 0xc0000000ff5c1016, ip=0xa00000010061da70
[    2.000000] kernel unaligned access to 0xc0000000ff5c1017, ip=0xa00000010059b1e0
[    2.100000] kernel unaligned access to 0xc0000000ff5c1017, ip=0xa00000010061da70
[    2.196000] kernel unaligned access to 0xc0000000ff5c1015, ip=0xa00000010059b1e0
[    2.304000] ACPI: Interpreter enabled
[    2.356000] ACPI: (supports S0 S5)
[    2.400000] ACPI: Using IOSAPIC for interrupt routing
[    2.608000] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    2.688000] acpi HWP0002:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.796000] acpi HWP0002:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    2.896000] PCI host bridge to bus 0000:00
[    2.948000] pci_bus 0000:00: root bus resource [io  0x0000-0x1fff window]
[    3.040000] pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff window]
[    3.136000] pci_bus 0000:00: root bus resource [mem 0x80004000000-0x80103fffffe window]
[    3.244000] pci_bus 0000:00: root bus resource [bus 00-1f]
[    3.356000] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 20-3f])
[    3.436000] acpi HWP0002:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.544000] acpi HWP0002:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    3.648000] PCI host bridge to bus 0000:20
[    3.700000] pci_bus 0000:20: root bus resource [io  0x2000-0x2fff window]
[    3.792000] pci_bus 0000:20: root bus resource [mem 0x90000000-0x97ffffff window]
[    3.888000] pci_bus 0000:20: root bus resource [mem 0x90004000000-0x90103fffffe window]
[    3.996000] pci_bus 0000:20: root bus resource [bus 20-3f]
[    4.108001] ACPI: PCI Root Bridge [PCI2] (domain 0000 [bus 40-5f])
[    4.192001] acpi HWP0002:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.300001] acpi HWP0002:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    4.396001] PCI host bridge to bus 0000:40
[    4.452001] pci_bus 0000:40: root bus resource [io  0x3000-0x5fff window]
[    4.540001] pci_bus 0000:40: root bus resource [mem 0x98000000-0xafffffff window]
[    4.640001] pci_bus 0000:40: root bus resource [mem 0xa0004000000-0xa0103fffffe window]
[    4.744001] pci_bus 0000:40: root bus resource [bus 40-5f]
[    4.840001] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 60-7f])
[    4.920001] acpi HWP0002:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    5.028001] acpi HWP0002:03: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    5.128001] PCI host bridge to bus 0000:60
[    5.184001] pci_bus 0000:60: root bus resource [io  0x6000-0x7fff window]
[    5.272001] pci_bus 0000:60: root bus resource [mem 0xb0000000-0xc7ffffff window]
[    5.372001] pci_bus 0000:60: root bus resource [mem 0xb0004000000-0xb0103fffffe window]
[    5.476001] pci_bus 0000:60: root bus resource [bus 60-7f]
[    5.572001] ACPI: PCI Root Bridge [PCI4] (domain 0000 [bus 80-bf])
[    5.652001] acpi HWP0002:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    5.760001] acpi HWP0002:04: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    5.860001] PCI host bridge to bus 0000:80
[    5.912001] pci_bus 0000:80: root bus resource [io  0x8000-0xbfff window]
[    6.004001] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xdfffffff window]
[    6.100001] pci_bus 0000:80: root bus resource [mem 0xc0004000000-0xc0103fffffe window]
[    6.208001] pci_bus 0000:80: root bus resource [bus 80-bf]
[    6.304001] ACPI: PCI Root Bridge [PCI6] (domain 0000 [bus c0-df])
[    6.384001] acpi HWP0002:05: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.492001] acpi HWP0002:05: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    6.592001] PCI host bridge to bus 0000:c0
[    6.644001] pci_bus 0000:c0: root bus resource [io  0xc000-0xdfff window]
[    6.732001] pci_bus 0000:c0: root bus resource [mem 0xe0000000-0xefffffff window]
[    6.832001] pci_bus 0000:c0: root bus resource [mem 0xe0004000000-0xe0103fffffe window]
[    6.940001] pci_bus 0000:c0: root bus resource [bus c0-df]
[    7.024001] ia64_handle_unaligned: 4 callbacks suppressed
[    7.024001] kernel unaligned access to 0xc0000000ff5c1016, ip=0xa00000010059b1e0
[    7.024001] kernel unaligned access to 0xc0000000ff5c1016, ip=0xa00000010059b1e0
[    7.024001] kernel unaligned access to 0xc0000000ff5c1016, ip=0xa00000010061da70
[    7.024001] ACPI: Enabled 1 GPEs in block 10 to 1F
[    7.448001] vgaarb: loaded
[    7.484001] SCSI subsystem initialized
[    7.536001] ACPI: bus type USB registered
[    7.588001] usbcore: registered new interface driver usbfs
[    7.660001] usbcore: registered new interface driver hub
[    7.728001] usbcore: registered new device driver usb
[    7.800001] IOC: zx1 2.3 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
[    7.936001] clocksource: Switched to clocksource itc
[    8.005385] VFS: Disk quotas dquot_6.6.0
[    8.057154] VFS: Dquot-cache hash table entries: 2048 (order 0, 16384 bytes)
[    8.150083] pnp: PnP ACPI init
[    8.190381] GSI 34 (level, low) -> CPU 0 (0x0000) vector 50
[    8.266957] GSI 35 (level, low) -> CPU 0 (0x0000) vector 51
[    8.382737] pnp: PnP ACPI: found 2 devices
[    8.439035] NET: Registered protocol family 2
[    8.498935] TCP established hash table entries: 8192 (order: 2, 65536 bytes)
[    8.592072] TCP bind hash table entries: 8192 (order: 3, 131072 bytes)
[    8.678109] TCP: Hash tables configured (established 8192 bind 8192)
[    8.761965] UDP hash table entries: 512 (order: 0, 16384 bytes)
[    8.839985] UDP-Lite hash table entries: 512 (order: 0, 16384 bytes)
[    8.923737] NET: Registered protocol family 1
[    8.981126] GSI 16 (level, low) -> CPU 0 (0x0000) vector 52
[    9.056135] GSI 16 (level, low) -> CPU 0 (0x0000) vector 52 unregistered
[    9.146035] GSI 17 (level, low) -> CPU 0 (0x0000) vector 52
[    9.221032] GSI 17 (level, low) -> CPU 0 (0x0000) vector 52 unregistered
[    9.310934] GSI 18 (level, low) -> CPU 0 (0x0000) vector 52
[    9.385929] GSI 18 (level, low) -> CPU 0 (0x0000) vector 52 unregistered
[    9.475832] Unpacking initramfs...
[   10.230738] Freeing initrd memory: 16688kB freed
[   10.294377] perfmon: version 2.0 IRQ 238
[   10.346357] perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
[   10.447206] perfmon: added sampling format default_format
[   10.518758] perfmon_default_smpl: default_format v2.0 registered
[   10.597825] futex hash table entries: 256 (order: 1, 32768 bytes)
[   10.678242] audit: initializing netlink subsys (disabled)
[   10.749386] audit: type=2000 audit(1464856926.744:1): initialized
[   10.829702] workingset: timestamp_bits=52 max_order=16 bucket_order=0
[   10.918740] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[   11.016274] io scheduler noop registered
[   11.067929] io scheduler deadline registered
[   11.124077] io scheduler cfq registered (default)
[   11.186057] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   11.283778] ACPI: Power Button [PWRF]
[   11.331993] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[   11.429508] ACPI: Sleep Button [SLPF]
[   11.477619] thermal LNXTHERM:00: registered as thermal_zone0
[   11.552527] ACPI: Thermal Zone [THM0] (27 C)
[   11.608667] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   11.711595] 00:00: ttyS0 at MMIO 0xff5e0000 (irq = 50, base_baud = 115200) is a 16550A
[   11.815907] console [ttyS0] enabled
[   11.815907] console [ttyS0] enabled
[   11.903612] bootconsole [uart8250] disabled
[   11.903612] bootconsole [uart8250] disabled
[   12.029184] 00:01: ttyS1 at MMIO 0xff5e2000 (irq = 51, base_baud = 115200) is a 16550A
[   12.124137] Linux agpgart interface v0.103
[   12.190737] loop: module loaded
[   12.230478] Uniform Multi-Platform E-IDE driver
[   12.284858] ide-cd driver 5.00
[   12.321519] GSI 21 (level, low) -> CPU 0 (0x0000) vector 52
[   12.390071] pata_cmd64x 0000:00:02.0: Secondary port is disabled
[   12.462264] scsi host0: pata_cmd64x
[   12.504649] scsi host1: pata_cmd64x
[   12.546629] ata1: PATA max UDMA/100 cmd 0xd18 ctl 0xd24 bmdma 0xd00 irq 55
[   12.629141] ata2: DUMMY
[   12.658395] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   12.743000] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   12.811953] GSI 29 (level, low) -> CPU 0 (0x0000) vector 53
[   12.982737] ata1.00: ATAPI: DV-28E-N, E.6A, max UDMA/33
[   13.122737] ata1.00: configured for UDMA/33
[   13.230737] scsi 0:0:0:0: CD-ROM            TEAC     DV-28E-N         E.6A PQ: 0 ANSI: 5
[   13.386740] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[   13.475091] cdrom: Uniform CD-ROM driver Revision: 3.20
[   13.546746] e1000 0000:20:02.0 eth0: (PCI-X:66MHz:64-bit) 00:17:08:7c:18:20
[   13.631138] e1000 0000:20:02.0 eth0: Intel(R) PRO/1000 Network Connection
[   13.712595] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   13.776550] GSI 30 (level, low) -> CPU 0 (0x0000) vector 54
[   14.154741] e1000 0000:20:02.1 eth1: (PCI-X:66MHz:64-bit) 00:17:08:7c:18:21
[   14.240104] e1000 0000:20:02.1 eth1: Intel(R) PRO/1000 Network Connection
[   14.321559] Fusion MPT base driver 3.04.20
[   14.370719] Copyright (c) 1999-2008 LSI Corporation
[   14.429161] Fusion MPT SPI Host driver 3.04.20
[   14.482388] GSI 27 (level, low) -> CPU 0 (0x0000) vector 55
[   14.550625] mptbase: ioc0: Initiating bringup
[   15.082739] ioc0: LSI53C1030 C0: Capabilities={Initiator,Target}
[   15.826739] scsi host2: ioc0: LSI53C1030 C0, FwRev=01032341h, Ports=1, MaxQ=255, IRQ=58
[   16.558739] GSI 28 (level, low) -> CPU 0 (0x0000) vector 56
[   16.628260] mptbase: ioc1: Initiating bringup
[   17.158739] ioc1: LSI53C1030 C0: Capabilities={Initiator,Target}
[   17.902739] scsi host3: ioc1: LSI53C1030 C0, FwRev=01032341h, Ports=1, MaxQ=255, IRQ=59
[   18.001207] scsi 2:0:0:0: Direct-Access     HP 73.4G ST373454LC       HPC2 PQ: 0 ANSI: 3
[   18.099853] scsi target2:0:0: Beginning Domain Validation
[   18.782739] Fusion MPT FC Host driver 3.04.20
[   18.836205] Fusion MPT SAS Host driver 3.04.20
[   18.889538] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   18.967884] ehci-pci: EHCI PCI platform driver
[   19.021207] GSI 18 (level, low) -> CPU 0 (0x0000) vector 57
[   19.089650] ehci-pci 0000:00:01.2: EHCI Host Controller
[   19.152462] ehci-pci 0000:00:01.2: new USB bus registered, assigned bus number 1
[   19.241220] ehci-pci 0000:00:01.2: irq 54, io mem 0x80000000
[   19.314741] scsi target2:0:0: Ending Domain Validation
[   19.378402] ehci-pci 0000:00:01.2: USB 2.0 started, EHCI 0.95
[   19.447367] scsi target2:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI WRFLOW PCOMP (6.25 ns, offset 63)
[   19.564259] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   19.645707] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.732378] usb usb1: Product: EHCI Host Controller
[   19.790910] usb usb1: Manufacturer: Linux 4.7.0-rc1.jcm_tomasz_pciv8_test+ ehci_hcd
[   19.882692] usb usb1: SerialNumber: 0000:00:01.2
[   19.938098] hub 1-0:1.0: USB hub found
[   19.983304] hub 1-0:1.0: 5 ports detected
[   20.031429] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   20.105814] mousedev: PS/2 mouse device common for all mice
[   20.172792] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[   20.248314] EFI Variables Facility v0.08 2004-May-17
[   20.308105] NET: Registered protocol family 10
[   20.362164] NET: Registered protocol family 17
[   20.415919] registered taskstats version 1
[   20.465289] rtc-efi rtc-efi: setting system clock to 2016-06-02 08:42:17 UTC (1464856937)
[   23.666739] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   23.732532] sd 2:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.4 GiB)
[   23.824829] sd 2:0:0:0: [sda] Write Protect is off
[   23.883778] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   24.010740]  sda: sda1 sda2 sda3
[   24.052839] sd 2:0:0:0: [sda] Attached SCSI disk
[   24.113158] Freeing unused kernel memory: 816K (e000000004e74000 - e000000004f40000)
[   24.206089] This architecture does not have kernel memory protection.
Loading, please wait...
[   24.302743] udev[112]: starting version 164
FATAL: Could not[   24.646740] EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
 load /lib/modul[   24.750740] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
es/4.7.0-rc1.jcm_tomasz_pciv8_test+/modules.dep: No such file or directory
Begin: Loading essential drivers ... FATAL: Could not load /lib/modules/4.7.0-rc1.jcm_tomasz_pciv8_test+/modules.dep: No such file or directory
done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... done.
FATAL: Could not load /lib/modules/4.7.0-rc1.jcm_tomasz_pciv8_test+/modules.dep: No such file or directory
Begin: Running /scripts/local-bottom ... done.
done.
Begin: Running /scripts/init-bottom ... done.
modprobe: FATAL: Could not load /lib/modules/4.7.0-rc1.jcm_tomasz_pciv8_test+/modules.dep: No such file or directory



INIT: version 2.88 booting

[   25.718740] random: nonblocking pool is initialized
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd[   26.114739] udev[261]: starting version 164
.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap...[   26.894740] Adding 2000784k swap on /dev/sda3.  Priority:-1 extents:1 across:2000784k 
done.
[   26.993208] EXT4-fs (sda2): re-mounted. Opts: (null)
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/sda2: clean[   27.194743] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
, 95298/4349952 files, 1091056/17397216 blocks
done.
Cleaning up ifupdown....
Loading kernel modules...done.
Setting up networking....
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
done.
Mounting local filesystems...done.
Activating swapfile swap...done.
Cleaning up temporary files....
Configuring network interfaces...done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Cleaning up temporary files....
Setting console screen modes and fonts.
cannot (un)set powersave mode
[9;30][14;30]Setting kernel variables ...done.

INIT: Entering runlevel: 2

Using makefile-style concurrent boot in runlevel 2.
Starting portmap daemon...Already running..
Starting NFS common utilities: statd.
Starting enhanced syslogd: rsyslogd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.
Starting ACPI services....
Starting MTA:[   28.750744] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   28.824281] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   28.922747] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
 exim4.
Starting mpt-status monitor: mpt-statusd.
Starting OpenBSD Secure Shell server: sshd[   30.010739] sshd (1079): /proc/1079/oom_adj is deprecated, please use /proc/1079/oom_score_adj instead.
.

Debian GNU/Linux 6.0 hamartia ttyS0

hamartia login: root
Password: 
Last login: Thu Jun  2 04:30:46 EDT 2016 on ttyS0
Linux hamartia 4.7.0-rc1.jcm_tomasz_pciv8_test+ #3 SMP Thu Jun 2 04:34:49 EDT 2016 ia64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root at hamartia:~# ping www.intel.com
PING a961.g.akamai.net (104.96.210.229) 56(84) bytes of data.
64 bytes from a104-96-210-229.deploy.static.akamaitechnologies.com (104.96.210.229): icmp_req=1 ttl=58 time=11.9 ms
64 bytes from a104-96-210-229.deploy.static.akamaitechnologies.com (104.96.210.229): icmp_req=2 ttl=58 time=10.2 ms
64 bytes from a104-96-210-229.deploy.static.akamaitechnologies.com (104.96.210.229): icmp_req=3 ttl=58 time=10.6 ms
^C
--- a961.g.akamai.net ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 10.272/10.971/11.944/0.719 ms
