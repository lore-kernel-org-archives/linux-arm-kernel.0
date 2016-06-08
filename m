From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Jun 2016 10:47:33 +0100
Subject: v4.7-rc2 kernel fails to boot when acpi=force
In-Reply-To: <70463161-1d59-a7ad-09c4-c4c7dd68d1ab@riken.jp>
References: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
 <20160607102317.GC2633@leverpostej>
 <7faf36bf-00d9-fb37-381a-6324d1dba977@riken.jp>
 <20160607110540.GD2633@leverpostej>
 <70463161-1d59-a7ad-09c4-c4c7dd68d1ab@riken.jp>
Message-ID: <20160608094733.GA14506@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 06:28:23PM +0900, Itaru Kitayama wrote:
> Hi Mark,
> 
> Thanks for the recovery suggestions. EFI edit couldn't read the
> grub.cfg for some reason, so I decided to do a clean installation.
> 
> Here's the v4.7-rc2+ kernel boot log (earlycon=pl011,0xe1010000
> acpi=force efi=debug):
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.7.0-rc2+ (admin at r2-a30) (gcc version
> 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC) ) #1 SMP Wed Jun 8 04:10:35
> CDT 2016
> [    0.000000] Boot CPU: AArch64 Processor [411fd072]
> [    0.000000] earlycon: pl11 at MMIO 0x00000000e1010000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi:   System Table: 0x00000083ff357f18
> [    0.000000] efi:   MemMap Address: 0x00000083fb19d618
> [    0.000000] efi:   MemMap Size: 0x00000540
> [    0.000000] efi:   MemMap Desc. Size: 0x00000030
> [    0.000000] efi:   MemMap Desc. Version: 0x00000001
> [    0.000000] efi: EFI v2.40 by American Megatrends
> [    0.000000] efi:  ACPI 2.0=0x83ff1d9000  SMBIOS 3.0=0x83ff353898
> [    0.000000] efi: Processing EFI memory map:
> [    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped
> I/O |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped
> I/O |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped
> I/O |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x008000000000-0x008000ffffff [Runtime Data
> |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] efi:   0x008001000000-0x008001f9ffff [Loader Data |
> |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x008001fa0000-0x00801fdfffff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x00801fe00000-0x00801fe0ffff [Loader Data |
> |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x00801fe10000-0x00801fffbfff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x00801fffc000-0x00801fffffff [Boot Data |   |
> |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x008020000000-0x00802fffffff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x008030000000-0x008030007fff [Runtime Code
> |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] efi:   0x008030008000-0x00838cffffff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x00838d000000-0x0083f0ffffff [Loader Data |
> |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083f1000000-0x0083f101ffff [Boot Data |   |
> |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083f1020000-0x0083fb19cfff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083fb19d000-0x0083fcadefff [Loader Data |
> |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083fcadf000-0x0083fcba8fff [Loader Code |
> |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083fcba9000-0x0083feafafff [Boot Data |   |
> |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083feafb000-0x0083fec4dfff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083fec4e000-0x0083ff19cfff [Boot Code |   |
> |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083ff19d000-0x0083ff1d8fff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083ff1d9000-0x0083ff1dafff [ACPI Reclaim
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] efi:   0x0083ff1db000-0x0083ff21ffff [Conventional
> Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083ff220000-0x0083ff23bfff [Loader Data |
> |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] efi:   0x0083ff23c000-0x0083ff23cfff [ACPI Memory NVS
> |   |  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] efi:   0x0083ff23d000-0x0083ff357fff [Runtime Data
> |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] efi:   0x0083ff358000-0x0083ffe42fff [Runtime Code
> |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] efi:   0x0083ffe43000-0x0083ffffffff [Boot Data |   |
> |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] cma: Reserved 512 MiB at 0x00000080e0000000
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000083FF1D9000 000024 (v02 AMDINC)
> [    0.000000] ACPI: XSDT 0x00000083FF1D9028 000064 (v01 AMDINC
> SEATTLE 00000000 AMI  00010013)
> [    0.000000] ACPI: FACP 0x00000083FF1D9090 00010C (v05 AMDINC
> SEATTLE 00000000 AMI  00010013)
> [    0.000000] ACPI: DSDT 0x00000083FF1D91A0 000D68 (v02 AMDINC
> SEATTLE 00000003 INTL 20140926)
> [    0.000000] ACPI: MCFG 0x00000083FF1D9F08 00003C (v01 AMDINC
> SEATTLE 00000000 MSFT 00000097)
> [    0.000000] ACPI: DBG2 0x00000083FF1D9F48 00005A (v00 AMDINC
> SEATTLE 00000000 AMI  00000000)
> [    0.000000] ACPI: GTDT 0x00000083FF1D9FA8 000060 (v02 AMDINC
> SEATTLE 00000000 AMI  00000000)
> [    0.000000] ACPI: APIC 0x00000083FF1DA008 0002BC (v03 AMDINC
> SEATTLE 00000000 AMI  00000000)
> [    0.000000] ACPI: CSRT 0x00000083FF1DA2C8 000060 (v00 AMDINC
> 00000000 AMI  00000000)
> [    0.000000] ACPI: SSDT 0x00000083FF1DA328 00011B (v02 AMDINC
> CPUSSDT 00000000 AMI  00000000)
> [    0.000000] ACPI: SPCR 0x00000083FF1DA448 000050 (v02 A M I
> APTIO V 00000000 AMI. 00000005)
> [    0.000000] psci: probing for conduit method from ACPI.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] percpu: Embedded 3 pages/cpu @fffffe03ff030000
> s108160 r8192 d80256 u196608
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] CPU features: enabling workaround for ARM erratum 832075
> [    0.000000] CPU features: enabling workaround for ARM erratum 834220
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping
> on. Total pages: 261888
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.7.0-rc2+
> root=UUID=0b5caf4f-3f72-429d-8924-76b74d6fb528 ro
> earlycon=pl011,0xe1010000 acpi=force efi=debug
> [    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
> [    0.000000] Dentry cache hash table entries: 2097152 (order: 8,
> 16777216 bytes)
> [    0.000000] Inode-cache hash table entries: 1048576 (order: 7,
> 8388608 bytes)
> [    0.000000] software IO TLB [mem 0x80dbff0000-0x80dfff0000]
> (64MB) mapped at [fffffe00dbff0000-fffffe00dffeffff]
> [    0.000000] Memory: 16088896K/16777216K available (8124K kernel
> code, 1216K rwdata, 3328K rodata, 960K init, 1493K bss, 164032K
> reserved, 524288K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     modules : 0xfffffc0000000000 - 0xfffffc0008000000
> (   128 MB)
> [    0.000000]     vmalloc : 0xfffffc0008000000 - 0xfffffdff5fff0000
> (  2045 GB)
> [    0.000000]       .text : 0xfffffc0008080000 - 0xfffffc0008860000
> (  8064 KB)
> [    0.000000]     .rodata : 0xfffffc0008860000 - 0xfffffc0008bb0000
> (  3392 KB)
> [    0.000000]       .init : 0xfffffc0008bb0000 - 0xfffffc0008ca0000
> (   960 KB)
> [    0.000000]       .data : 0xfffffc0008ca0000 - 0xfffffc0008dd0200
> (  1217 KB)
> [    0.000000]        .bss : 0xfffffc0008dd0200 - 0xfffffc0008f457f0
> (  1494 KB)
> [    0.000000]     fixed   : 0xfffffdff7e7d0000 - 0xfffffdff7ec00000
> (  4288 KB)
> [    0.000000]     PCI I/O : 0xfffffdff7ee00000 - 0xfffffdff7fe00000
> (    16 MB)
> [    0.000000]     vmemmap : 0xfffffdff80000000 - 0xfffffe0000000000
> (     2 GB maximum)
> [    0.000000]               0xfffffdff80000000 - 0xfffffdff81000000
> (    16 MB actual)
> [    0.000000]     memory  : 0xfffffe0000000000 - 0xfffffe0400000000
> ( 16384 MB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	Build-time adjustment of leaf fanout to 64.
> [    0.000000] NR_IRQS:64 nr_irqs:64 0
> [    0.000000] GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv2m: range[mem 0xe1180000-0xe1180fff], SPI[64:319]
> [    0.000000] Architected cp15 timer(s) running at 250.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x7350b89c29, max_idle_ns: 881590431910 ns
> [    0.000002] sched_clock: 56 bits at 250MHz, resolution 4ns, wraps
> every 4398046511102ns
> [    0.008142] Console: colour dummy device 80x25
> [    0.012626] console [tty0] enabled
> [    0.016055] bootconsole [pl11] disabled

It looks like the we're failing to find the console (judging by the fact
the kernel opted to use a dummy device). The other messages look largely
fine. It may be worth also passing "keep_bootcon" to try to get a few
more lines of messages, though that may or may not be helpful.

I was under the impression that SPCR told us the console to use, but
from grepping the kernel source code, it looks like mainline doesn't
support that yet. Given that, I'm at a loss as to how this could have
worked for v4.6.

I take it you've used the exactly same command line for v4.6 and
v4.7-rc2? i.e. you weren't previously passing something like
"console=ttyAMA0,115200"?

Were you using a vanilla v4.6? Or some distro derivative?

Thanks,
Mark.
