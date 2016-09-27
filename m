From: vikas.cha.sajjan@hpe.com (Sajjan, Vikas C)
Date: Tue, 27 Sep 2016 07:03:17 +0000
Subject: ARM juno R2 board USB Issue (EHCI probe failed)
Message-ID: <AT5PR84MB005284C92DEA45ADF67A4F55D9CC0@AT5PR84MB0052.NAMPRD84.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I working on ARM juno R2 board, with latest kernel 4.8.rc7 and I get below USB EHCI probe error while booting with acpi=force. 

EFI stub: Booting Linux Kernel...
ConvertPages: Incompatible memory types
EFI stub: Using DTB from command line
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x100
[    0.000000] Linux version 4.8.0-rc7-00142-gb1f2beb (vikas at dctxvm241) (gcc version 4.8.3 20140401 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2014.04 - Linaro GCC 4.8-2014.04) ) #48 SMP PREEMPT Mon Sep 26 15:31:48 IST 2016
[    0.000000] Boot CPU: AArch64 Processor [410fd033]
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.50 by ARM Juno EFI Oct 15 2015 14:16:39
[    0.000000] efi:  ACPI=0xfe750000  ACPI 2.0=0xfe750014  PROP=0xfe794370 
[    0.000000] cma: Reserved 16 MiB at 0x00000000fd400000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000FE750014 000024 (v02 ARMLTD)
[    0.000000] ACPI: XSDT 0x00000000FE7400E8 00003C (v01 ARMLTD ARM-JUNO 20140727      01000013)
[    0.000000] ACPI: FACP 0x00000000FE720000 00010C (v05 ARMLTD ARM-JUNO 20140727 ARM  00000099)
[    0.000000] ACPI: DSDT 0x00000000FE6F0000 000317 (v01 ARMLTD ARM-JUNO 20140727 INTL 20140214)
[    0.000000] ACPI: GTDT 0x00000000FE710000 000060 (v02 ARMLTD ARM-JUNO 20140727 ARM  00000099)
[    0.000000] ACPI: APIC 0x00000000FE700000 000224 (v01 ARMLTD ARM-JUNO 20140727 ARM  00000099)
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] percpu: Embedded 21 pages/cpu @ffff80097feb8000 s47488 r8192 d30336 u86016
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2060048
[    0.000000] Kernel command line: dtb=board.dtb initrd=ramdisk.img console=ttyAMA0,115200 acpi=force root=/dev/sda1
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 20480 bytes
. .  . . . .  . .
. .  . . . .  . .
. .  . . . .  . .
. .  . . . .  . .
[    1.223662] VFIO - User Level meta-driver version: 0.3
[    1.229335] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.235882] ehci-pci: EHCI PCI platform driver
[    1.240359] ehci-platform: EHCI generic platform driver
[    1.245619] ehci-platform ARMH0D20:00: Error: DMA mask configuration failed
[    1.272491] ehci-platform: probe of ARMH0D20:00 failed with error -5
[    1.278876] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.285071] ohci-pci: OHCI PCI platform driver
[    1.289548] ohci-platform: OHCI generic platform driver
[    1.294884] usbcore: registered new interface driver usb-storage
[    1.301231] mousedev: PS/2 mouse device common for all mice
[    1.307197] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
 
But this error goes off, if I don't force ACPI booting, i.e., if I remove acpi=force from kernel command line , USB is detected  and my RFS which is in the usb drive, gets mounted successfully. 

Thanks and Regards
Vikas Sajjan
