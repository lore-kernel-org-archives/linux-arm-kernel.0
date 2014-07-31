From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Jul 2014 16:26:11 +0200
Subject: [PATCH] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <53DA509A.8070304@linaro.org>
References: <1406810830-6099-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9hwupNAxuOTNnsY8Spxkh3J6DwYF7Ym493PuZ-6phzXA@mail.gmail.com>
 <53DA509A.8070304@linaro.org>
Message-ID: <CAKv+Gu8Nq7-mhFPRqRw6sxDxZAz5kyLvDBwC_0E3qZp9ZpxPig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2014 16:20, Yi Li <yi.li@linaro.org> wrote:
> Hi Ard,
>
>     The patch works well on FVP model, and here are the boot log and
> dmidecode+lshw result:
>

Thanks Yi!

Can we help Will out if he wants to test this himself?

-- 
Ard.


>
> FS2:\> Image dtb=dtb/fvp.dtb console=ttyAMA0 earlyprintk=pl011,0x1c090000
> debug ignore_loglevel uefi_debug rootwait root=/dev/vda2 ext4 rw
> EFI stub: Booting Linux Kernel...
> Initializing cgroup subsys cpu
> Linux version 3.15.0-rc1+ (liyi at liyi-T530) (gcc version 4.8.3 20140203
> (prerelease) (crosstool-NG linaro-1.13.1-4.8-2014.02 - Linaro GCC 2014.02) )
> #26 SMP PREEMPT Thu Jul 31 22:04:47 HKT 2014
> CPU: AArch64 Processor [410fd0f0] revision 0
> bootconsole [earlycon0] enabled
> debug: ignoring loglevel setting.
> efi: Getting parameters from FDT:
> efi:   System Table: 0x00000000ffb66f18
> efi:   MemMap Address: 0x00000000f71de698
> efi:   MemMap Size: 0x000005a0
> efi:   MemMap Desc. Size: 0x00000030
> efi:   MemMap Desc. Version: 0x00000001
> EFI v2.40 by ARM Fixed Virtual Platform EFI May  9 2014 07:14:49
> efi:  ACPI=0xf71df000  ACPI 2.0=0xf71df014  SMBIOS=0xffb49000
> Processing EFI memory map:
>   0x000080000000-0x000080000fff [Loader Data]
>   0x000080001000-0x00008007ffff [Conventional Memory]
>   0x000080080000-0x000080654fff [Loader Data]
>   0x000080655000-0x00009fdfffff [Conventional Memory]
>   0x00009fe00000-0x00009fe03fff [Loader Data]
>   0x00009fe04000-0x0000f69d0fff [Conventional Memory]
>   0x0000f69d1000-0x0000f709ffff [Loader Code]
>   0x0000f70a0000-0x0000f71c5fff [Boot Code]*
>   0x0000f71c6000-0x0000f71c6fff [ACPI Reclaim Memory]*
>   0x0000f71c7000-0x0000f71c7fff [ACPI Memory NVS]
>   0x0000f71c8000-0x0000f71d4fff [ACPI Reclaim Memory]*
>   0x0000f71d5000-0x0000f71d5fff [ACPI Memory NVS]
>   0x0000f71d6000-0x0000f71ddfff [ACPI Reclaim Memory]*
>   0x0000f71de000-0x0000f71defff [Loader Data]
>   0x0000f71df000-0x0000f71dffff [ACPI Reclaim Memory]*
>   0x0000f71e0000-0x0000f80e7fff [Conventional Memory]
>   0x0000f80e8000-0x0000f820dfff [Boot Data]*
>   0x0000f820e000-0x0000f829efff [Conventional Memory]
>   0x0000f829f000-0x0000fc01ffff [Boot Data]*
>   0x0000fc020000-0x0000ffa21fff [Conventional Memory]
>   0x0000ffa22000-0x0000ffb06fff [Boot Code]*
>   0x0000ffb07000-0x0000ffb1afff [Runtime Code]*
>   0x0000ffb1b000-0x0000ffb4cfff [Runtime Data]*
>   0x0000ffb4d000-0x0000ffb4dfff [Boot Data]*
>   0x0000ffb4e000-0x0000ffb4efff [Runtime Data]*
>   0x0000ffb4f000-0x0000ffb5ffff [Conventional Memory]
>   0x0000ffb60000-0x0000ffb62fff [Loader Data]
>   0x0000ffb63000-0x0000ffb65fff [Boot Data]*
>   0x0000ffb66000-0x0000ffb66fff [Runtime Data]*
>   0x0000ffb67000-0x0000ffffffff [Boot Data]*
> cma: CMA: reserved 16 MiB at fe800000
> On node 0 totalpages: 524288
>   DMA zone: 7168 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 524288 pages, LIFO batch:31
> psci: probing function IDs from device-tree
> PERCPU: Embedded 10 pages/cpu @ffffffc07cdb0000 s12096 r8192 d20672 u40960
> pcpu-alloc: s12096 r8192 d20672 u40960 alloc=10*4096
> pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 517120
> Kernel command line: Image dtb=dtb/fvp.dtb console=ttyAMA0
> earlyprintk=pl011,0x1c090000 debug ignore_loglevel uefi_debug rootwait
> root=/dev/vda2 ext4 rw
> PID hash table entries: 4096 (order: 3, 32768 bytes)
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Memory: 1971124K/2097152K available (3907K kernel code, 264K rwdata, 1404K
> rodata, 211K init, 177K bss, 126028K reserved)
> Virtual kernel memory layout:
>     vmalloc : 0xffffff8000000000 - 0xffffffbbffff0000   (245759 MB)
>     vmemmap : 0xffffffbc01c00000 - 0xffffffbc03800000   (    28 MB)
>     modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
>     memory  : 0xffffffc000000000 - 0xffffffc080000000   (  2048 MB)
>       .init : 0xffffffc0005b1000 - 0xffffffc0005e5f40   (   212 kB)
>       .text : 0xffffffc000080000 - 0xffffffc0005b0fe4   (  5316 kB)
>       .data : 0xffffffc0005e6000 - 0xffffffc0006281a0   (   265 kB)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> Preemptible hierarchical RCU implementation.
> NR_IRQS:64 nr_irqs:64 0
> Architected cp15 and mmio timer(s) running at 100.00MHz (phys/phys).
> sched_clock: 56 bits at 100MHz, resolution 10ns, wraps every 2748779069440ns
> Console: colour dummy device 80x25
> Calibrating delay loop (skipped), value calculated using timer frequency..
> 200.00 BogoMIPS (lpj=1000000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
> hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 9 counters available
> Remapping and enabling EFI services.
>   EFI remap 0x0000ffb07000 => ffffffc07fb07000
>   EFI remap 0x0000ffb1b000 => ffffffc07fb1b000
>   EFI remap 0x0000ffb4e000 => ffffffc07fb4e000
>   EFI remap 0x0000ffb66000 => ffffffc07fb66000
>   EFI freeing: 0x0000f70a0000-0x0000f71c5fff
>   EFI freeing: 0x0000f80e8000-0x0000f820dfff
>   EFI freeing: 0x0000f829f000-0x0000fc01ffff
>   EFI freeing: 0x0000ffa22000-0x0000ffb06fff
>   EFI freeing: 0x0000ffb4d000-0x0000ffb4dfff
>   EFI freeing: 0x0000ffb63000-0x0000ffb65fff
>   EFI freeing: 0x0000ffb67000-0x0000ffffffff
> Freed 0x454f000 bytes of EFI boot services memory
> CPU1: Booted secondary processor
> CPU2: Booted secondary processor
> CPU3: Booted secondary processor
> CPU4: Booted secondary processor
> CPU5: Booted secondary processor
> CPU6: Booted secondary processor
> CPU7: Booted secondary processor
> Brought up 8 CPUs
> SMP: Total of 8 processors activated.
> devtmpfs: initialized
> atomic64 test passed
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> of_amba_device_create(): amba_device_add() failed (-19) for
> /smb/motherboard/iofpga at 3,00000000/sysctl at 020000
> SMBIOS 2.7 present.
> DMI: ARM Arm Versatile Express/Arm Versatile Express, BIOS 22:20:20 Apr 14
> 2014
> vdso: 2 pages (1 code, 1 data) at base ffffffc0005ed000
> hw-breakpoint: found 16 breakpoint and 16 watchpoint registers.
> Serial: AMBA PL011 UART driver
> 1c090000.uart: ttyAMA0 at MMIO 0x1c090000 (irq = 37, base_baud = 0) is a
> PL011 rev2
> console [ttyAMA0] enabled
> console [ttyAMA0] enabled
> bootconsole [earlycon0] disabled
> bootconsole [earlycon0] disabled
> 1c0a0000.uart: ttyAMA1 at MMIO 0x1c0a0000 (irq = 38, base_baud = 0) is a
> PL011 rev2
> 1c0b0000.uart: ttyAMA2 at MMIO 0x1c0b0000 (irq = 39, base_baud = 0) is a
> PL011 rev2
> 1c0c0000.uart: ttyAMA3 at MMIO 0x1c0c0000 (irq = 40, base_baud = 0) is a
> PL011 rev2
> software IO TLB [mem 0xfc000000-0xfc400000] (4MB) mapped at
> [ffffffc07c000000-ffffffc07c3fffff]
> 3V3: 3300 mV
> SCSI subsystem initialized
> libata version 3.00 loaded.
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Switched to clocksource arch_sys_counter
> NET: Registered protocol family 2
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP: reno registered
> UDP hash table entries: 1024 (order: 3, 32768 bytes)
> UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> futex hash table entries: 2048 (order: 5, 131072 bytes)
> fuse init (API version 7.23)
> msgmni has been set to 4020
> io scheduler noop registered
> io scheduler cfq registered (default)
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>  vda: vda1 vda2
> smc91x 1a000000.ethernet (unregistered net_device): smc91x: IOADDR
> ffffff8000066000 doesn't match configuration (300).
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
> smc91x 1a000000.ethernet eth0: SMC91C11xFD (rev 1) at ffffff8000066000 IRQ
> 47
>
> smc91x 1a000000.ethernet eth0: Ethernet addr: 00:02:f7:ef:34:54
> usbcore: registered new interface driver usb-storage
> mousedev: PS/2 mouse device common for all mice
> mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 41,42
> (pio)
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> mmc0: new MMC card at address 0001
> TCP: cubic registered
> NET: Registered protocol family 17
> mmcblk0: mmc0:0001 ARMmmc 2.00 GiB
>  mmcblk0: p1 p2
> EXT3-fs (vda2): error: couldn't mount because of unsupported optional
> features (240)
> EXT2-fs (vda2): error: couldn't mount because of unsupported optional
> features (244)
> EXT4-fs (vda2): warning: mounting fs with errors, running e2fsck is
> recommended
> EXT4-fs (vda2): recovery complete
> EXT4-fs (vda2): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext4 filesystem) on device 254:2.
> Freeing unused kernel memory: 208K (ffffffc0005b1000 - ffffffc0005e5000)
> INIT: version 2.88 booting
> Starting udev
> udevd[579]: starting version 182
> mmcblk0: error -110 sending stop command, original cmd response 0x900, card
> status 0x80400900
> mmcblk0: error -110 sending stop command, original cmd response 0x900, card
> status 0x80400900
> Starting Bootlog daemon: bootlogd.
> EXT4-fs (vda2): re-mounted. Opts: (null)
> random: dd urandom read with 30 bits of entropy available
> Populating dev cache
> Configuring network interfaces... smc91x 1a000000.ethernet eth0: link up,
> 10Mbps, half-duplex, lpa 0x0000
> udhcpc (v1.21.1) started
> Sending discover...
> Sending select for 172.20.51.1...
> Lease of 172.20.51.1 obtained, lease time 86400
> /etc/udhcpc.d/50default: Adding DNS 172.20.51.254
> done.
> Starting rpcbind daemon...rpcbind: cannot create socket for udp6
> rpcbind: cannot create socket for tcp6
> done.
> hwclock: can't open '/dev/misc/rtc': No such file or directory
> Thu Sep 12 10:59:00 UTC 2013
> hwclock: can't open '/dev/misc/rtc': No such file or directory
> INIT: Entering runlevel: 5
> Starting syslogd/klogd: done
> Starting auto-serial-console: done
>
> Stopping Bootlog daemon: Last login: Thu Sep 12 10:59:00 UTC 2013 on tty1
> bootlogd.
> INIT: no more processes left in this runlevel
> root at genericarmv8:~# cd dmidecode-2.12
> root at genericarmv8:~/dmidecode-2.12# ./dmidecode
> random: nonblocking pool is initialized
> # dmidecode 2.12
> # SMBIOS entry point at 0xffb49000
> SMBIOS 2.7 present.
> 12 structures occupying 604 bytes.
> Table at 0xFFB48000.
>
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>     Vendor: edk2.sourceforge.net
>     Version: 22:20:20
>     Release Date: Apr 14 2014
>     Address: 0xE0000
>     Runtime Size: 128 kB
>     ROM Size: 8192 kB
>     Characteristics:
>         BIOS is upgradeable
>         BIOS shadowing is allowed
>         Selectable boot is supported
>         ACPI is supported
>         Smart battery is supported
>         Function key-initiated network boot is supported
>         UEFI is supported
>     BIOS Revision: 0.1
>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>     Manufacturer: ARM
>     Product Name: Arm Versatile Express
>     Version: 1.0
>     Serial Number: System Serial#
>     UUID: 25EF0280-EC82-42B0-8FB6-10ADCCC67C02
>     Wake-up Type: Power Switch
>     SKU Number: System SKU#
>     Family: edk2
>
> Handle 0x0002, DMI type 2, 17 bytes
> Base Board Information
>     Manufacturer: ARM
>     Product Name: Arm Versatile Express
>     Version: 1.0
>     Serial Number: Base Board Serial#
>     Asset Tag: Base Board Asset Tag#
>     Features:
>         Board is a hosting board
>     Location In Chassis: Part Component
>     Chassis Handle: 0x0000
>     Type: Motherboard
>     Contained Object Handles: 0
>
> Handle 0x0003, DMI type 3, 24 bytes
> Chassis Information
>     Manufacturer: ARM
>     Type: Laptop
>     Lock: Not Present
>     Version: 1.0
>     Serial Number: Chassis Board Serial#
>     Asset Tag: Chassis Board Asset Tag#
>     Boot-up State: Safe
>     Power Supply State: Safe
>     Thermal State: Safe
>     Security Status: None
>     OEM Information: 0x00000000
>     Height: Unspecified
>     Number Of Power Cords: Unspecified
>     Contained Elements: 0
>     SKU Number: Not Specified
>
> Handle 0x0004, DMI type 4, 42 bytes
> Processor Information
>     Socket Designation: Socket
>     Type: Other
>     Family: ARM
>     Manufacturer: ARM
>     ID: 00 00 00 00 00 00 00 00
>     Version: v7
>     Voltage: 5.0 V 3.3 V 2.9 V
>     External Clock: Unknown
>     Max Speed: Unknown
>     Current Speed: Unknown
>     Status: Populated, Enabled
>     Upgrade: Other
>     L1 Cache Handle: 0x0000
>     L2 Cache Handle: 0x0000
>     L3 Cache Handle: 0x0000
>     Serial Number: 1.0
>     Asset Tag: 1.0
>     Part Number: 1.0
>     Core Count: 4
>     Core Enabled: 4
>     Thread Count: 4
>     Characteristics: None
>
> Handle 0x0005, DMI type 7, 19 bytes
> Cache Information
>     Socket Designation: Cache1
>     Configuration: Enabled, Socketed, Level 3
>     Operational Mode: Write Back
>     Location: Internal
>     Installed Size: 255 kB
>     Maximum Size: 255 kB
>     Supported SRAM Types:
>         Burst
>         Synchronous
>     Installed SRAM Type: Burst Synchronous
>     Speed: Unknown
>     Error Correction Type: Multi-bit ECC
>     System Type: Unknown
>     Associativity: 2-way Set-associative
>
> Handle 0x0006, DMI type 9, 17 bytes
> System Slot Information
>     Designation: SD Card
>     Type: Other
>     Current Usage: Available
>     Length: Other
>     Characteristics: Unknown
>     Bus Address: 0000:00:00.0
>
> Handle 0x0007, DMI type 16, 23 bytes
> Physical Memory Array
>     Location: System Board Or Motherboard
>     Use: System Memory
>     Error Correction Type: Unknown
>     Maximum Capacity: 4095 PB
>     Error Information Handle: Not Provided
>     Number Of Devices: 1
>
> Handle 0x0008, DMI type 17, 34 bytes
> Memory Device
>     Array Handle: 0x0000
>     Error Information Handle: Not Provided
>     Total Width: Unknown
>     Data Width: Unknown
>     Size: Unknown
>     Form Factor: Unknown
>     Set: Unknown
>     Locator: OS Virtual Memory
>     Bank Locator: malloc
>     Type: DRAM
>     Type Detail: Unknown
>     Speed: Unknown
>     Manufacturer: OSV
>     Serial Number: Not Specified
>     Asset Tag: Not Specified
>     Part Number: Not Specified
>     Rank: Unknown
>     Configured Clock Speed: Unknown
>
> Handle 0x0009, DMI type 19, 31 bytes
> Memory Array Mapped Address
>     Starting Address: 0x20000000000
>     Ending Address: 0x2FFFFFFFFFF
>     Range Size: 1 TB
>     Physical Array Handle: 0x0000
>     Partition Width: 1
>
> Handle 0x000A, DMI type 32, 11 bytes
> System Boot Information
>     Status: No errors detected
>
> Handle 0xFEFF, DMI type 127, 4 bytes
> End Of Table
>
> root at genericarmv8:~/dmidecode-2.12# ls /sys/class/dmi/id/
> bios_date     board_vendor        chassis_version  product_version
> bios_vendor     board_version        modalias         subsystem
> bios_version     chassis_asset_tag  power         sys_vendor
> board_asset_tag  chassis_serial     product_name     uevent
> board_name     chassis_type        product_serial
> board_serial     chassis_vendor     product_uuid
>
> root at genericarmv8:~/dmidecode-2.12# cd ..
> root at genericarmv8:~# cd lshw-B.02.17
> root at genericarmv8:~/lshw-B.02.17# cd src/
> root at genericarmv8:~/lshw-B.02.17/src# ./lshw
> genericarmv8
>     description: Laptop
>     product: FVP Base
>     vendor: ARM
>     version: 1.0
>     serial: System Serial#
>     width: 64 bits
>     capabilities: smbios-2.7 dmi-2.7
>     configuration: boot=normal chassis=laptop family=edk2 sku=System SKU#
> uuid=8002EF25-82EC-B042-8FB6-10ADCCC67C02
>   *-core
>        description: Motherboard
>        product: Arm Versatile Express
>        vendor: ARM
>        physical id: 0
>        version: 1.0
>        serial: Base Board Serial#
>        slot: Part Component
>        capabilities: arm_vfp-base arm_vexpress
>      *-firmware
>           description: BIOS
>           vendor: edk2.sourceforge.net
>           physical id: 0
>           version: 22:20:20
>           date: Apr 14 2014
>           size: 128KiB
>           capacity: 8128KiB
>           capabilities: upgrade shadowing bootselect acpi smartbattery
> netboot uefi
>      *-cpu:0
>           description: CPU
>           product: (1.0)
>           vendor: ARM
>           physical id: 4
>           bus info: cpu at 0
>           version: v7
>           serial: 1.0
>           slot: Socket
>           configuration: cores=4 enabledcores=4 threads=4
>      *-cache
>           description: L3 cache
>           physical id: 5
>           slot: Cache1
>           size: 255KiB
>           capacity: 255KiB
>           capabilities: burst synchronous internal write-back
>      *-memory:0
>           description: System Memory
>           physical id: 7
>           slot: System board or motherboard
>      *-memory:1 UNCLAIMED
>           physical id: 1
>         *-bank UNCLAIMED
>              description: DRAM [empty]
>              vendor: OSV
>              physical id: 0
>              slot: OS Virtual Memory
>      *-cpu:1 DISABLED
>           description: CPU
>           product: cpu
>           physical id: 2
>           bus info: cpu at 0
>      *-cpu:2 DISABLED
>           description: CPU
>           product: cpu
>           physical id: 3
>           bus info: cpu at 1
>      *-cpu:3 DISABLED
>           description: CPU
>           product: cpu
>           physical id: 6
>           bus info: cpu at 2
>      *-cpu:4 DISABLED
>           description: CPU
>           product: cpu
>           physical id: 8
>           bus info: cpu at 3
>      *-cpu:5 DISABLED
>           description: CPU
>           product: cpu
>           physical id: 9
>           bus info: cpu at 4
>      *-cpu:6 DISABLED
>           description: CPU
>           product: cpu
>           physical id: a
>           bus info: cpu at 5
>      *-cpu:7 DISABLED
>           description: CPU
>           product: cpu
>           physical id: b
>           bus info: cpu at 6
>      *-cpu:8 DISABLED
>           description: CPU
>           product: cpu
>           physical id: c
>           bus info: cpu at 7
>      *-memory:2 UNCLAIMED
>           physical id: d
>      *-memory:3 UNCLAIMED
>           physical id: e
>   *-network
>        description: Ethernet interface
>        physical id: 1
>        logical name: eth0
>        serial: 00:02:f7:ef:34:54
>        size: 10Mbit/s
>        capacity: 100Mbit/s
>        capabilities: ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd
> autonegotiation
>        configuration: autonegotiation=on broadcast=yes driver=smc91x
> driverversion=smc91x.c: v1.1, sep 22 2004 by duplex=half ip=172.20.51.1
> link=yes multicast=yes port=MII speed=10Mbit/s
> root at genericarmv8:~/lshw-B.02.17/src#
>
>
>
>
>
> On Thursday, July 31, 2014 08:48 PM, Ard Biesheuvel wrote:
>
> On 31 July 2014 14:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> From: Yi Li <yi.li@linaro.org>
>
> SMbios is important for server hardware vendors. It implements a spec for
> providing descriptive information about the platform. Things like serial
> numbers, physical layout of the ports, build configuration data, and the
> like.
>
> This has been tested by dmidecode and lshw tools.
>
> Signed-off-by: Yi Li <yi.li@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> It turns out that efi_lookup_mapped_addr() is not appropriate after all for
> remapping the address of the SMBIOS tables. The reason is that the UEFI spec
> forbids virtual mappings being requested for configuration tables (which is
> not
> currently honored by Tianocore/EDK2)
>
> @Yi: could you retest yet again, please?
>
> @Will; this superseded the patch that is already queued up in
> for-next/core, so perhaps you could drop that while we get this
> tested?
>
>  arch/arm64/Kconfig           | 11 +++++++++++
>  arch/arm64/include/asm/dmi.h | 33 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/setup.c    |  2 ++
>  3 files changed, 46 insertions(+)
>  create mode 100644 arch/arm64/include/asm/dmi.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 839f48c26ef0..0b2350470ac9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -308,6 +308,17 @@ config EFI
>           allow the kernel to be booted as an EFI application. This
>           is only useful on systems that have UEFI firmware.
>
> +config DMI
> +       bool "Enable support for SMBIOS (DMI) tables"
> +       depends on EFI
> +       default y
> +       help
> +         This enables SMBIOS/DMI feature for systems.
> +
> +         This option is only useful on systems that have UEFI firmware.
> +         However, even with this option, the resultant kernel should
> +         continue to boot on existing non-UEFI platforms.
> +
>  endmenu
>
>  menu "Userspace binary formats"
> diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
> new file mode 100644
> index 000000000000..0a07357bb776
> --- /dev/null
> +++ b/arch/arm64/include/asm/dmi.h
> @@ -0,0 +1,33 @@
> +/*
> + * arch/arm64/include/asm/dmi.h
> + *
> + * Copyright (C) 2013 Linaro Limited.
> + * Written by: Yi Li (yi.li at linaro.org)
> + *
> + * based on arch/ia64/include/asm/dmi.h
> + *
> + * This file is subject to the terms and conditions of the GNU General
> Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#ifndef __ASM_DMI_H
> +#define __ASM_DMI_H
> +
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +/*
> + * According to section 2.3.6 of the UEFI spec, the firmware must not
> request
> + * a virtual mapping for configuration tables such as SMBIOS. This means we
> have
> + * to map them before use. As SMBIOS tables are typed as
> EfiRuntimeServicesData,
> + * they should always reside in DRAM, so we can use ioremap_cache() here,
> which
> + * will give us the existing linear mapping if the address is covered by
> it.
> + */
> +#define dmi_early_remap(x, l)          ioremap_cache(x, l)
> +#define dmi_early_unmap(x, l)          iounmap(x)
> +#define dmi_remap(x, l)                        ioremap_cache(x, l)
> +#define dmi_unmap(x)                   iounmap(x)
> +#define dmi_alloc(l)                   kzalloc(l, GFP_KERNEL)
> +
> +#endif
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 46d1125571f6..4075e46282b1 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -43,6 +43,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
>  #include <linux/efi.h>
> +#include <linux/dmi.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/cputype.h>
> @@ -413,6 +414,7 @@ void __init setup_arch(char **cmdline_p)
>  static int __init arm64_device_init(void)
>  {
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +       dmi_scan_machine();
>         return 0;
>  }
>  arch_initcall_sync(arm64_device_init);
> --
> 1.8.3.2
>
>
