From: jcm@jonmasters.org (Jon Masters)
Date: Fri, 20 May 2016 03:46:21 -0400
Subject: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Message-ID: <e6525c52-9cdc-aa0b-dea3-d29ab14cc39b@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 11:19 AM, Tomasz Nowicki wrote:

> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.

Boot log from Intel Itanium 2 system attached.

Jon.

-------------- next part --------------
[    0.000000] Linux version 4.6.0-rc7.jcm_tomasz_pciv7_test+ (jcm at hamartia) (gcc version 4.4.5 (Debian 4.4.5-8) ) #2 SMP Fri May 20 03:24:58 EDT 2016
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
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 32/16 (20160108/tbfadt-623)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe1Block: 32/16 (20160108/tbfadt-623)
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
[    0.000000] Initial ramdisk at: 0xe00000003d4ac000 (17110715 bytes)
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
[    0.000000] Memory: 989904K/1037488K available (12139K kernel code, 1118K rwdata, 1432K rodata, 880K init, 807K bss, 47584K reserved, 0K cma-reserved)
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
[    0.348000] ACPI: Core revision 20160108
[    0.404000] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.488000] 
[    0.504000] Security Framework initialized
[    0.560000] SELinux:  Disabled at boot.
[    0.608000] Dentry cache hash table entries: 131072 (order: 6, 1048576 bytes)
[    0.704000] Inode-cache hash table entries: 65536 (order: 5, 524288 bytes)
[    0.796000] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.884000] Mountpoint-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.980000] Boot processor id 0x0/0x0
[    1.028000] Brought up 1 CPUs
[    1.068000] Total of 1 processors activated (2390.01 BogoMIPS).
[    1.144000] devtmpfs: initialized
[    1.188000] SMBIOS 2.3 present.
[    1.232000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.360000] NET: Registered protocol family 16
[    1.420000] ACPI: bus type PCI registered
[    1.472000] HugeTLB registered 256 MB page size, pre-allocated 0 pages
[    1.560000] ACPI: Added _OSI(Module Device)
[    1.616000] ACPI: Added _OSI(Processor Device)
[    1.672000] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.736000] ACPI: Added _OSI(Processor Aggregator Device)
[    1.828000] ACPI: Interpreter enabled
[    1.876000] ACPI: (supports S0 S5)
[    1.920000] ACPI: Using IOSAPIC for interrupt routing
[    2.128000] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    2.212000] acpi HWP0002:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.320000] acpi HWP0002:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    2.416000] PCI host bridge to bus 0000:00
[    2.472000] pci_bus 0000:00: root bus resource [io  0x0000-0x1fff window]
[    2.560000] pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff window]
[    2.660000] pci_bus 0000:00: root bus resource [mem 0x80004000000-0x80103fffffe window]
[    2.764000] pci_bus 0000:00: root bus resource [bus 00-1f]
[    2.876000] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 20-3f])
[    2.960000] acpi HWP0002:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.068000] acpi HWP0002:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    3.168000] PCI host bridge to bus 0000:20
[    3.224000] pci_bus 0000:20: root bus resource [io  0x2000-0x2fff window]
[    3.312000] pci_bus 0000:20: root bus resource [mem 0x90000000-0x97ffffff window]
[    3.412000] pci_bus 0000:20: root bus resource [mem 0x90004000000-0x90103fffffe window]
[    3.516000] pci_bus 0000:20: root bus resource [bus 20-3f]
[    3.632000] ACPI: PCI Root Bridge [PCI2] (domain 0000 [bus 40-5f])
[    3.712000] acpi HWP0002:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.820000] acpi HWP0002:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    3.920000] PCI host bridge to bus 0000:40
[    3.972000] pci_bus 0000:40: root bus resource [io  0x3000-0x5fff window]
[    4.064001] pci_bus 0000:40: root bus resource [mem 0x98000000-0xafffffff window]
[    4.160001] pci_bus 0000:40: root bus resource [mem 0xa0004000000-0xa0103fffffe window]
[    4.268001] pci_bus 0000:40: root bus resource [bus 40-5f]
[    4.364001] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 60-7f])
[    4.444001] acpi HWP0002:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.552001] acpi HWP0002:03: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    4.652001] PCI host bridge to bus 0000:60
[    4.704001] pci_bus 0000:60: root bus resource [io  0x6000-0x7fff window]
[    4.796001] pci_bus 0000:60: root bus resource [mem 0xb0000000-0xc7ffffff window]
[    4.892001] pci_bus 0000:60: root bus resource [mem 0xb0004000000-0xb0103fffffe window]
[    5.000001] pci_bus 0000:60: root bus resource [bus 60-7f]
[    5.096001] ACPI: PCI Root Bridge [PCI4] (domain 0000 [bus 80-bf])
[    5.176001] acpi HWP0002:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    5.284001] acpi HWP0002:04: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    5.384001] PCI host bridge to bus 0000:80
[    5.436001] pci_bus 0000:80: root bus resource [io  0x8000-0xbfff window]
[    5.524001] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xdfffffff window]
[    5.624001] pci_bus 0000:80: root bus resource [mem 0xc0004000000-0xc0103fffffe window]
[    5.728001] pci_bus 0000:80: root bus resource [bus 80-bf]
[    5.828001] ACPI: PCI Root Bridge [PCI6] (domain 0000 [bus c0-df])
[    5.908001] acpi HWP0002:05: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.016001] acpi HWP0002:05: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    6.112001] PCI host bridge to bus 0000:c0
[    6.168001] pci_bus 0000:c0: root bus resource [io  0xc000-0xdfff window]
[    6.256001] pci_bus 0000:c0: root bus resource [mem 0xe0000000-0xefffffff window]
[    6.356001] pci_bus 0000:c0: root bus resource [mem 0xe0004000000-0xe0103fffffe window]
[    6.460001] pci_bus 0000:c0: root bus resource [bus c0-df]
[    6.548001] ACPI: Enabled 1 GPEs in block 10 to 1F
[    6.608001] vgaarb: loaded
[    6.644001] SCSI subsystem initialized
[    6.696001] ACPI: bus type USB registered
[    6.748001] usbcore: registered new interface driver usbfs
[    6.820001] usbcore: registered new interface driver hub
[    6.888001] usbcore: registered new device driver usb
[    6.960001] IOC: zx1 2.3 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
[    7.096001] clocksource: Switched to clocksource itc
[    7.165391] VFS: Disk quotas dquot_6.6.0
[    7.217160] VFS: Dquot-cache hash table entries: 2048 (order 0, 16384 bytes)
[    7.310088] pnp: PnP ACPI init
[    7.350492] GSI 34 (level, low) -> CPU 0 (0x0000) vector 50
[    7.427065] GSI 35 (level, low) -> CPU 0 (0x0000) vector 51
[    7.542336] pnp: PnP ACPI: found 2 devices
[    7.599353] NET: Registered protocol family 2
[    7.659252] TCP established hash table entries: 8192 (order: 2, 65536 bytes)
[    7.752389] TCP bind hash table entries: 8192 (order: 3, 131072 bytes)
[    7.838429] TCP: Hash tables configured (established 8192 bind 8192)
[    7.922282] UDP hash table entries: 512 (order: 0, 16384 bytes)
[    8.000304] UDP-Lite hash table entries: 512 (order: 0, 16384 bytes)
[    8.084056] NET: Registered protocol family 1
[    8.141446] GSI 16 (level, low) -> CPU 0 (0x0000) vector 52
[    8.216452] GSI 16 (level, low) -> CPU 0 (0x0000) vector 52 unregistered
[    8.306355] GSI 17 (level, low) -> CPU 0 (0x0000) vector 52
[    8.381350] GSI 17 (level, low) -> CPU 0 (0x0000) vector 52 unregistered
[    8.471253] GSI 18 (level, low) -> CPU 0 (0x0000) vector 52
[    8.546247] GSI 18 (level, low) -> CPU 0 (0x0000) vector 52 unregistered
[    8.636151] Unpacking initramfs...
[    9.390337] Freeing initrd memory: 16704kB freed
[    9.452092] perfmon: version 2.0 IRQ 238
[    9.504173] perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
[    9.605023] perfmon: added sampling format default_format
[    9.676576] perfmon_default_smpl: default_format v2.0 registered
[    9.755645] futex hash table entries: 256 (order: 1, 32768 bytes)
[    9.836164] audit: initializing netlink subsys (disabled)
[    9.907310] audit: type=2000 audit(1463729949.900:1): initialized
[    9.987625] workingset: timestamp_bits=52 max_order=16 bucket_order=0
[   10.072633] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[   10.174301] io scheduler noop registered
[   10.225953] io scheduler deadline registered
[   10.282101] io scheduler cfq registered (default)
[   10.344189] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   10.441907] ACPI: Power Button [PWRF]
[   10.490124] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[   10.587641] ACPI: Sleep Button [SLPF]
[   10.635751] thermal LNXTHERM:00: registered as thermal_zone0
[   10.710659] ACPI: Thermal Zone [THM0] (27 C)
[   10.766799] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   10.869739] 00:00: ttyS0 at MMIO 0xff5e0000 (irq = 50, base_baud = 115200) is a 16550A
[   10.974038] console [ttyS0] enabled
[   10.974038] console [ttyS0] enabled
[   11.061742] bootconsole [uart8250] disabled
[   11.061742] bootconsole [uart8250] disabled
[   11.187308] 00:01: ttyS1 at MMIO 0xff5e2000 (irq = 51, base_baud = 115200) is a 16550A
[   11.282265] Linux agpgart interface v0.103
[   11.350337] loop: module loaded
[   11.388606] Uniform Multi-Platform E-IDE driver
[   11.442986] ide-cd driver 5.00
[   11.479646] GSI 21 (level, low) -> CPU 0 (0x0000) vector 52
[   11.548304] pata_cmd64x 0000:00:02.0: Secondary port is disabled
[   11.620496] scsi host0: pata_cmd64x
[   11.662883] scsi host1: pata_cmd64x
[   11.704862] ata1: PATA max UDMA/100 cmd 0xd18 ctl 0xd24 bmdma 0xd00 irq 55
[   11.787375] ata2: DUMMY
[   11.816629] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   11.901233] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   11.970186] GSI 29 (level, low) -> CPU 0 (0x0000) vector 53
[   12.138336] ata1.00: ATAPI: DV-28E-N, E.6A, max UDMA/33
[   12.278336] ata1.00: configured for UDMA/33
[   12.386336] scsi 0:0:0:0: CD-ROM            TEAC     DV-28E-N         E.6A PQ: 0 ANSI: 5
[   12.542338] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[   12.633847] cdrom: Uniform CD-ROM driver Revision: 3.20
[   12.706336] e1000 0000:20:02.0 eth0: (PCI-X:66MHz:64-bit) 00:17:08:7c:18:20
[   12.789892] e1000 0000:20:02.0 eth0: Intel(R) PRO/1000 Network Connection
[   12.871351] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   12.935306] GSI 30 (level, low) -> CPU 0 (0x0000) vector 54
[   13.314340] e1000 0000:20:02.1 eth1: (PCI-X:66MHz:64-bit) 00:17:08:7c:18:21
[   13.399691] e1000 0000:20:02.1 eth1: Intel(R) PRO/1000 Network Connection
[   13.481044] Fusion MPT base driver 3.04.20
[   13.530204] Copyright (c) 1999-2008 LSI Corporation
[   13.588646] Fusion MPT SPI Host driver 3.04.20
[   13.641872] GSI 27 (level, low) -> CPU 0 (0x0000) vector 55
[   13.710213] mptbase: ioc0: Initiating bringup
[   14.242338] ioc0: LSI53C1030 C0: Capabilities={Initiator,Target}
[   14.986338] scsi host2: ioc0: LSI53C1030 C0, FwRev=01032341h, Ports=1, MaxQ=255, IRQ=58
[   15.718338] GSI 28 (level, low) -> CPU 0 (0x0000) vector 56
[   15.787849] mptbase: ioc1: Initiating bringup
[   16.318338] ioc1: LSI53C1030 C0: Capabilities={Initiator,Target}
[   17.062338] scsi host3: ioc1: LSI53C1030 C0, FwRev=01032341h, Ports=1, MaxQ=255, IRQ=59
[   17.160901] scsi 2:0:0:0: Direct-Access     HP 73.4G ST373454LC       HPC2 PQ: 0 ANSI: 3
[   17.259548] scsi target2:0:0: Beginning Domain Validation
[   17.942338] Fusion MPT FC Host driver 3.04.20
[   17.995796] Fusion MPT SAS Host driver 3.04.20
[   18.049128] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   18.127474] ehci-pci: EHCI PCI platform driver
[   18.180798] GSI 18 (level, low) -> CPU 0 (0x0000) vector 57
[   18.249240] ehci-pci 0000:00:01.2: EHCI Host Controller
[   18.312052] ehci-pci 0000:00:01.2: new USB bus registered, assigned bus number 1
[   18.400810] ehci-pci 0000:00:01.2: irq 54, io mem 0x80000000
[   18.474340] scsi target2:0:0: Ending Domain Validation
[   18.537887] ehci-pci 0000:00:01.2: USB 2.0 started, EHCI 0.95
[   18.606851] scsi target2:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI WRFLOW PCOMP (6.25 ns, offset 63)
[   18.723742] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   18.805192] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.891860] usb usb1: Product: EHCI Host Controller
[   18.950394] usb usb1: Manufacturer: Linux 4.6.0-rc7.jcm_tomasz_pciv7_test+ ehci_hcd
[   19.042175] usb usb1: SerialNumber: 0000:00:01.2
[   19.097584] hub 1-0:1.0: USB hub found
[   19.142790] hub 1-0:1.0: 5 ports detected
[   19.190915] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   19.265300] mousedev: PS/2 mouse device common for all mice
[   19.334336] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[   19.407799] EFI Variables Facility v0.08 2004-May-17
[   19.467590] NET: Registered protocol family 10
[   19.521650] NET: Registered protocol family 17
[   19.575405] registered taskstats version 1
[   19.624776] rtc-efi rtc-efi: setting system clock to 2016-05-20 07:39:20 UTC (1463729960)
[   22.826338] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   22.892021] sd 2:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.4 GiB)
[   22.984321] sd 2:0:0:0: [sda] Write Protect is off
[   23.043271] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   23.174340]  sda: sda1 sda2 sda3
[   23.218340] sd 2:0:0:0: [sda] Attached SCSI disk
[   23.273689] Freeing unused kernel memory: 880K (e000000004e64000 - e000000004f40000)
[   23.366620] This architecture does not have kernel memory protection.
Loading, please wait...
[   23.462341] udev[112]: starting version 164
FATAL: Could not[   23.806340] EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
 load /lib/modules/4.6.0-rc7.jcm[   23.914337] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
_tomasz_pciv7_test+/modules.dep: No such file or directory
Begin: Loading essential drivers ... FATAL: Could not load /lib/modules/4.6.0-rc7.jcm_tomasz_pciv7_test+/modules.dep: No such file or directory
done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... done.
FATAL: Could not load /lib/modules/4.6.0-rc7.jcm_tomasz_pciv7_test+/modules.dep: No such file or directory
Begin: Running /scripts/local-bottom ... done.
done.
Begin: Running /scripts/init-bottom ... done.
modprobe: FATAL: Could not load /lib/modules/4.6.0-rc7.jcm_tomasz_pciv7_test+/modules.dep: No such file or directory



INIT: version 2.88 booting

Using makefile-s[   24.982338] random: nonblocking pool is initialized
tyle concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd[   25.330336] udev[267]: starting version 164
.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap...[   25.998339] Adding 2000784k swap on /dev/sda3.  Priority:-1 extents:1 across:2000784k 
done.
[   26.098340] EXT4-fs (sda2): re-mounted. Opts: (null)
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/sda2: clean[   26.262343] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
, 93785/4349952 files, 1074005/17397216 blocks
done.
Loading kernel modules...done.
Cleaning up ifupdown....
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
[   27.090342] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   27.162611] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   27.249590] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Setting console screen modes and fonts.
cannot (un)set powersave mode
[9;30][14;30]Setting kernel variables ...done.

INIT: Entering runlevel: 2

Using makefile-style concurrent boot in runlevel 2.
Starting portmap daemon...Already running..
Starting NFS common utilities: statd.
Starting enhanced syslogd: rsyslogd.
Starting ACPI services....
Starting deferred execution scheduler: atd.
Starting mpt-status monitor: mpt-statusd.
Starting periodic command scheduler: cron.
Starting MTA: exim4.
Starting O[   28.750341] sshd (1082): /proc/1082/oom_adj is deprecated, please use /proc/1082/oom_score_adj instead.
penBSD Secure Shell server: sshd.

Debian GNU/Linux 6.0 hamartia ttyS0

hamartia login: root
Password: 
Last login: Fri May 20 03:35:54 EDT 2016 on ttyS0
Linux hamartia 4.6.0-rc7.jcm_tomasz_pciv7_test+ #2 SMP Fri May 20 03:24:58 EDT 2016 ia64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root at hamartia:~# uname -a
Linux hamartia 4.6.0-rc7.jcm_tomasz_pciv7_test+ #2 SMP Fri May 20 03:24:58 EDT 2016 ia64 GNU/Linux
root at hamartia:~# 
