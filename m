From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Wed, 8 Jun 2016 19:07:26 +0900
Subject: v4.7-rc2 kernel fails to boot when acpi=force
In-Reply-To: <20160608094733.GA14506@leverpostej>
References: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
 <20160607102317.GC2633@leverpostej>
 <7faf36bf-00d9-fb37-381a-6324d1dba977@riken.jp>
 <20160607110540.GD2633@leverpostej>
 <70463161-1d59-a7ad-09c4-c4c7dd68d1ab@riken.jp>
 <20160608094733.GA14506@leverpostej>
Message-ID: <38f33112-e65f-85f0-d6ab-a0af12444fb0@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 6/8/16 6:47 PM, Mark Rutland wrote:
>
> It looks like the we're failing to find the console (judging by the fact
> the kernel opted to use a dummy device). The other messages look largely
> fine. It may be worth also passing "keep_bootcon" to try to get a few
> more lines of messages, though that may or may not be helpful.

I tried that and actually I obtained a lot longer boot log, I will past 
it below after answering your questions.

>
> I was under the impression that SPCR told us the console to use, but
> from grepping the kernel source code, it looks like mainline doesn't
> support that yet. Given that, I'm at a loss as to how this could have
> worked for v4.6.
>
> I take it you've used the exactly same command line for v4.6 and
> v4.7-rc2? i.e. you weren't previously passing something like
> "console=ttyAMA0,115200"?

I doubt I was, but as I've reinstalled the system there's no way
to confirm.

>
> Were you using a vanilla v4.6? Or some distro derivative?

It was a vanilla v4.6.

Here's the log file, the v4.7-rc2 kernel is built with defconfig this time

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.7.0-rc2+ (admin at r2-a30) (gcc version 
5.3.1 20160406 (Red Hat 5.3.1-6) (GCC) ) #2 SMP PREEMPT Wed Jun 8 
04:51:08 CDT 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd072]
[    0.000000] debug: skip boot console de-registration.
[    0.000000] earlycon: pl11 at MMIO 0x00000000e1010000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi:   System Table: 0x00000083ff357f18
[    0.000000] efi:   MemMap Address: 0x00000083fb2ef618
[    0.000000] efi:   MemMap Size: 0x00000540
[    0.000000] efi:   MemMap Desc. Size: 0x00000030
[    0.000000] efi:   MemMap Desc. Version: 0x00000001
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0x83ff1d9000  SMBIOS 3.0=0x83ff353898
[    0.000000] efi: Processing EFI memory map:
[    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped I/O 
|RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped I/O 
|RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped I/O 
|RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x008000000000-0x008000ffffff [Runtime Data 
|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x008001000000-0x008001cdffff [Loader Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x008001ce0000-0x00801fdfffff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x00801fe00000-0x00801fe0ffff [Loader Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x00801fe10000-0x00801fffbfff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x00801fffc000-0x00801fffffff [Boot Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x008020000000-0x00802fffffff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x008030000000-0x008030007fff [Runtime Code 
|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x008030008000-0x00838cffffff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x00838d000000-0x0083f0ffffff [Loader Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083f1000000-0x0083f101ffff [Boot Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083f1020000-0x0083fb2eefff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083fb2ef000-0x0083fcadefff [Loader Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083fcadf000-0x0083fcba8fff [Loader Code 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083fcba9000-0x0083feafafff [Boot Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083feafb000-0x0083fec4dfff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083fec4e000-0x0083ff19cfff [Boot Code 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083ff19d000-0x0083ff1d8fff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083ff1d9000-0x0083ff1dafff [ACPI Reclaim 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0083ff1db000-0x0083ff21ffff [Conventional 
Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083ff220000-0x0083ff23bfff [Loader Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0083ff23c000-0x0083ff23cfff [ACPI Memory NVS 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0083ff23d000-0x0083ff357fff [Runtime Data 
|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0083ff358000-0x0083ffe42fff [Runtime Code 
|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0083ffe43000-0x0083ffffffff [Boot Data 
|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] cma: Reserved 16 MiB at 0x00000080ff000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000083FF1D9000 000024 (v02 AMDINC)
[    0.000000] ACPI: XSDT 0x00000083FF1D9028 000064 (v01 AMDINC SEATTLE 
00000000 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000083FF1D9090 00010C (v05 AMDINC SEATTLE 
00000000 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000083FF1D91A0 000D68 (v02 AMDINC SEATTLE 
00000003 INTL 20140926)
[    0.000000] ACPI: MCFG 0x00000083FF1D9F08 00003C (v01 AMDINC SEATTLE 
00000000 MSFT 00000097)
[    0.000000] ACPI: DBG2 0x00000083FF1D9F48 00005A (v00 AMDINC SEATTLE 
00000000 AMI  00000000)
[    0.000000] ACPI: GTDT 0x00000083FF1D9FA8 000060 (v02 AMDINC SEATTLE 
00000000 AMI  00000000)
[    0.000000] ACPI: APIC 0x00000083FF1DA008 0002BC (v03 AMDINC SEATTLE 
00000000 AMI  00000000)
[    0.000000] ACPI: CSRT 0x00000083FF1DA2C8 000060 (v00 AMDINC 
00000000 AMI  00000000)
[    0.000000] ACPI: SSDT 0x00000083FF1DA328 00011B (v02 AMDINC CPUSSDT 
00000000 AMI  00000000)
[    0.000000] ACPI: SPCR 0x00000083FF1DA448 000050 (v02 A M I  APTIO V 
00000000 AMI. 00000005)
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] percpu: Embedded 20 pages/cpu @ffff8003fff1a000 s42752 
r8192 d30976 u81920
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 832075
[    0.000000] CPU features: enabling workaround for ARM erratum 834220
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 4128768
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.7.0-rc2+ 
root=UUID=0b5caf4f-3f72-429d-8924-76b74d6fb528 ro keep_bootcon 
earlycon=pl011,0xe1010000 acpi=force efi=debug LANG=en_US.UTF-8
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 28672 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 65536 bytes
[    0.000000] early log buf free: 9628(58%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes)
[    0.000000] software IO TLB [mem 0x80fafff000-0x80fefff000] (64MB) 
mapped at [ffff8000fafff000-ffff8000feffefff]
[    0.000000] Memory: 16355276K/16777216K available (7564K kernel code, 
647K rwdata, 3184K rodata, 960K init, 259K bss, 405556K reserved, 16384K 
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   ( 
   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000 
(129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000087e0000   ( 
  7552 KB)
[    0.000000]     .rodata : 0xffff0000087e0000 - 0xffff000008b00000   ( 
  3200 KB)
[    0.000000]       .init : 0xffff000008b00000 - 0xffff000008bf0000   ( 
   960 KB)
[    0.000000]       .data : 0xffff000008bf0000 - 0xffff000008c91e00   ( 
   648 KB)
[    0.000000]        .bss : 0xffff000008c91e00 - 0xffff000008cd2ab8   ( 
   260 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   ( 
  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   ( 
    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   ( 
  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0010000000   ( 
   256 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800400000000   ( 
16384 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] GICv2m: range[mem 0xe1180000-0xe1180fff], SPI[64:319]
[    0.000000] Architected cp15 timer(s) running at 250.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x7350b89c29, max_idle_ns: 881590431910 ns
[    0.000001] sched_clock: 56 bits at 250MHz, resolution 4ns, wraps 
every 4398046511102ns
[    0.008134] Console: colour dummy device 80x25
[    0.012618] console [tty0] enabled
[    0.016053] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 500.00 BogoMIPS (lpj=1000000)
[    0.026685] pid_max: default: 32768 minimum: 301
[    0.031349] ACPI: Core revision 20160422
[    0.035356] Security Framework initialized
[    0.039498] Mount-cache hash table entries: 32768 (order: 6, 262144 
bytes)
[    0.046442] Mountpoint-cache hash table entries: 32768 (order: 6, 
262144 bytes)
[    0.054265] ASID allocator initialised with 65536 entries
[    0.079777] Remapping and enabling EFI services.
[    0.084450]   EFI remap 0x00000000e1050000 => 0000000020000000
[    0.090341]   EFI remap 0x00000000e1300000 => 0000000020010000
[    0.096239]   EFI remap 0x00000000e8200000 => 0000000020020000
[    0.102127]   EFI remap 0x0000008000000000 => 0000000020200000
[    0.108019]   EFI remap 0x0000008030000000 => 0000000021200000
[    0.113928]   EFI remap 0x00000083ff23d000 => 000000002121d000
[    0.120004]   EFI remap 0x00000083ff358000 => 0000000021338000
[    0.189822] Detected PIPT I-cache on CPU1
[    0.189839] CPU1: Booted secondary processor [411fd072]
[    0.308944] Detected PIPT I-cache on CPU2
[    0.308961] CPU2: Booted secondary processor [411fd072]
[    0.428059] Detected PIPT I-cache on CPU3
[    0.428071] CPU3: Booted secondary processor [411fd072]
[    0.547194] Detected PIPT I-cache on CPU4
[    0.547209] CPU4: Booted secondary processor [411fd072]
[    0.666311] Detected PIPT I-cache on CPU5
[    0.666323] CPU5: Booted secondary processor [411fd072]
[    0.785438] Detected PIPT I-cache on CPU6
[    0.785453] CPU6: Booted secondary processor [411fd072]
[    0.904560] Detected PIPT I-cache on CPU7
[    0.904571] CPU7: Booted secondary processor [411fd072]
[    0.904598] Brought up 8 CPUs
[    0.972805] SMP: Total of 8 processors activated.
[    0.977554] CPU features: detected feature: 32-bit EL0 Support
[    0.983447] CPU: All CPU(s) started at EL2
[    0.987596] alternatives: patching kernel code
[    0.995032] devtmpfs: initialized
[    0.998653] SMBIOS 3.0.0 present.
[    1.002062] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.012066] pinctrl core: initialized pinctrl subsystem
[    1.017666] NET: Registered protocol family 16
[    1.038165] cpuidle: using governor menu
[    1.042167] vdso: 2 pages (1 code @ ffff0000087e6000, 1 data @ 
ffff000008bf4000)
[    1.049634] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.056756] DMA: preallocated 256 KiB pool for atomic allocations
[    1.062922] ACPI: bus type PCI registered
[    1.066995] Serial: AMBA PL011 UART driver
[    1.087256] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.093935] ACPI: Added _OSI(Module Device)
[    1.098153] ACPI: Added _OSI(Processor Device)
[    1.102632] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.107377] ACPI: Added _OSI(Processor Aggregator Device)
[    1.113261] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    1.119671]
[    1.121818] ACPI: Interpreter enabled
[    1.125509] ACPI: Using GIC for interrupt routing
[    1.132495] AMDI0511:00: ttyAMA0 at MMIO 0xe1010000 (irq = 21, 
base_baud = 0) is a SBSA
[    1.140730] acpi AMDI0400:01: amba_handler_attach(): 
amba_device_add() failed (-19)
[    1.148769] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-0f])
[    1.155010] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI]
[    1.163469] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME 
AER PCIeCapability]
[    1.171547] acpi PNP0A08:00: Bus 0000:00 not present in PCI namespace
[    1.178269] vgaarb: loaded
[    1.181069] SCSI subsystem initialized
[    1.184958] ACPI: bus type USB registered
[    1.189032] usbcore: registered new interface driver usbfs
[    1.194580] usbcore: registered new interface driver hub
[    1.199962] usbcore: registered new device driver usb
[    1.609270] i2c_designware AMDI0510:00: timeout in disabling adapter
[    1.615690] ------------[ cut here ]------------
[    1.620346] WARNING: CPU: 1 PID: 1 at 
drivers/i2c/busses/i2c-designware-core.c:280 i2c_dw_clk_rate+0x3c/0x48
[    1.630258] Modules linked in:
[    1.633330]
[    1.634829] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc2+ #2
[    1.641145] Hardware name: Default string Default string/Default 
string, BIOS ROD0084E 09/03/2015
[    1.650092] task: ffff8003ec088000 ti: ffff8003ec090000 task.ti: 
ffff8003ec090000
[    1.657638] PC is at i2c_dw_clk_rate+0x3c/0x48
[    1.662114] LR is at i2c_dw_init+0xf8/0x340
[    1.666326] pc : [<ffff000008627c14>] lr : [<ffff000008627e80>] 
pstate: 60000045
[    1.673784] sp : ffff8003ec093bb0
[    1.677119] x29: ffff8003ec093bb0 x28: 0000000000000000
[    1.682475] x27: ffff000008bb3d78 x26: ffff000008b00470
[    1.687830] x25: ffff000008b4dbd8 x24: ffff000008af9030
[    1.693183] x23: 00000000431bde83 x22: ffff8003ebcfbc00
[    1.698535] x21: 000000000000012c x20: 000000000000012c
[    1.703889] x19: ffff8003eb8a9818 x18: 0000000000000006
[    1.709239] x17: 00000000000000bf x16: ffffffffffffffff
[    1.714591] x15: ffff000008c9bc95 x14: 0000000000010000
[    1.719943] x13: ffff000008c9e0a8 x12: 0000000005f5e0ff
[    1.725296] x11: 00000000000000b1 x10: 0000000000094bf6
[    1.730647] x9 : ffff8003ec0937c0 x8 : 00000000000000b2
[    1.736000] x7 : 6261736964206e69 x6 : ffff000008c9bccf
[    1.741353] x5 : 0000000000000000 x4 : 0000000000000000
[    1.746706] x3 : 0000000000000000 x2 : 0000000000000000
[    1.752058] x1 : 0000000000000001 x0 : ffff000008c90000
[    1.757411]
[    1.758910] ---[ end trace 8f08a3f38c8bc1ad ]---
[    1.763557] Call trace:
[    1.766016] Exception stack(0xffff8003ec0939f0 to 0xffff8003ec093b10)
[    1.772509] 39e0:                                   ffff8003eb8a9818 
000000000000012c
[    1.780402] 3a00: ffff8003ec093bb0 ffff000008627c14 4349564544006d72 
6674616c702b3d45
[    1.788297] 3a20: 49444d413a6d726f 0030303a30313530 ffff8003ec093a70 
ffff0000087c636c
[    1.796191] 3a40: ffff000008c0f520 ffff8003ec0e8c80 ffff8003fff37380 
ffff8003ec088000
[    1.804085] 3a60: ffff0000087c67b4 ffff8003ec088548 ffff8003ec093ad0 
ffff0000087c67b4
[    1.811979] 3a80: ffff8003ec093b00 ffff0000084959c8 ffff000008c90000 
0000000000000001
[    1.819876] 3aa0: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    1.827772] 3ac0: ffff000008c9bccf 6261736964206e69 00000000000000b2 
ffff8003ec0937c0
[    1.835666] 3ae0: 0000000000094bf6 00000000000000b1 0000000005f5e0ff 
ffff000008c9e0a8
[    1.843560] 3b00: 0000000000010000 ffff000008c9bc95
[    1.848474] [<ffff000008627c14>] i2c_dw_clk_rate+0x3c/0x48
[    1.854003] [<ffff000008628100>] i2c_dw_probe+0x38/0x210
[    1.859355] [<ffff0000086290b8>] dw_i2c_plat_probe+0x188/0x3b8
[    1.865235] [<ffff00000849b098>] platform_drv_probe+0x50/0xb8
[    1.871025] [<ffff00000849957c>] driver_probe_device+0x204/0x2b0
[    1.877077] [<ffff0000084996d4>] __driver_attach+0xac/0xb0
[    1.882606] [<ffff000008497528>] bus_for_each_dev+0x60/0xa0
[    1.888221] [<ffff000008498d08>] driver_attach+0x20/0x28
[    1.893572] [<ffff0000084988f8>] bus_add_driver+0x1d0/0x238
[    1.899190] [<ffff000008499e98>] driver_register+0x60/0xf8
[    1.904718] [<ffff00000849afd8>] __platform_driver_register+0x40/0x48
[    1.911209] [<ffff000008b2e6d4>] dw_i2c_init_driver+0x18/0x20
[    1.917000] [<ffff000008081a10>] do_one_initcall+0x38/0x128
[    1.922617] [<ffff000008b00cb0>] kernel_init_freeable+0x14c/0x1f0
[    1.928760] [<ffff0000087c3e60>] kernel_init+0x10/0x100
[    1.934024] [<ffff000008084e10>] ret_from_fork+0x10/0x40
[    1.939824] pps_core: LinuxPPS API ver. 1 registered
[    1.944839] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    1.954077] PTP clock support registered
[    1.958131] Advanced Linux Sound Architecture Driver Initialized.
[    1.964544] clocksource: Switched to clocksource arch_sys_counter
[    1.970716] VFS: Disk quotas dquot_6.6.0
[    1.974689] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    1.981707] pnp: PnP ACPI init
[    1.984854] pnp: PnP ACPI: found 0 devices
[    1.991436] NET: Registered protocol family 2
[    1.992652] i2c_designware AMDI0510:00: timeout in disabling adapter
[    2.002428] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes)
[    2.010161] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.017246] TCP: Hash tables configured (established 131072 bind 65536)
[    2.023962] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    2.030159] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    2.036843] NET: Registered protocol family 1
[    2.041330] RPC: Registered named UNIX socket transport module.
[    2.047304] RPC: Registered udp transport module.
[    2.052044] RPC: Registered tcp transport module.
[    2.056785] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.063348] Unpacking initramfs...
[    2.301843] Freeing initrd memory: 10464K (ffff8003fb2f5000 - 
ffff8003fbd2d000)
[    2.309644] kvm [1]: 8-bit VMID
[    2.312824] kvm [1]: Hyp mode initialized successfully
[    2.318037] kvm [1]: vgic-v2 at e1140000
[    2.321764] kvm [1]: vgic interrupt IRQ1
[    2.325781] kvm [1]: virtual timer IRQ4
[    2.330819] futex hash table entries: 2048 (order: 6, 262144 bytes)
[    2.337194] audit: initializing netlink subsys (disabled)
[    2.342654] audit: type=2000 audit(1.632:1): initialized
[    2.348165] workingset: timestamp_bits=44 max_order=22 bucket_order=0
[    2.357993] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.364147] NFS: Registering the id_resolver key type
[    2.369252] Key type id_resolver registered
[    2.373468] Key type id_legacy registered
[    2.377569] fuse init (API version 7.24)
[    2.381684] 9p: Installing v9fs 9p2000 file system support
[    2.388073] io scheduler noop registered
[    2.392078] io scheduler cfq registered (default)
[    2.397272] pl061_gpio AMDI0400:00: PL061 GPIO chip 
@0x00000000e1050000 registered
[    2.405031] pl061_gpio AMDI0400:02: PL061 GPIO chip 
@0x00000000e0030000 registered
[    2.412833] pl061_gpio AMDI0400:03: PL061 GPIO chip 
@0x00000000e0080000 registered
[    2.421015] xenfs: not registering filesystem on non-xen platform
[    2.428252] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.435048] SuperH (H)SCI(F) driver initialized
[    2.439671] msm_serial: driver initialized
[    2.443930] Failed to find cpu0 device node
[    2.448148] Unable to detect cache hierarchy from DT for CPU 0
[    2.455877] loop: module loaded
[    2.459222] ahci AMDI0600:00: SSS flag set, parallel bus scan disabled
[    2.465842] ahci AMDI0600:00: AHCI 0001.0300 32 slots 8 ports 6 Gbps 
0xff impl platform mode
[    2.474359] ahci AMDI0600:00: flags: 64bit ncq sntf stag led clo only 
pmp pio ccc apst
[    2.483817] scsi host0: ahci
[    2.486856] scsi host1: ahci
[    2.489866] scsi host2: ahci
[    2.492892] scsi host3: ahci
[    2.495900] scsi host4: ahci
[    2.498919] scsi host5: ahci
[    2.501934] scsi host6: ahci
[    2.504949] scsi host7: ahci
[    2.507919] ata1: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x100 irq 6
[    2.515819] ata2: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x180 irq 6
[    2.523721] ata3: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x200 irq 6
[    2.531620] ata4: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x280 irq 6
[    2.539520] ata5: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x300 irq 6
[    2.547419] ata6: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x380 irq 6
[    2.555318] ata7: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x400 irq 6
[    2.563217] ata8: SATA max UDMA/133 mmio [mem 0xe0300000-0xe030ffff] 
port 0x480 irq 6
[    2.571462] tun: Universal TUN/TAP device driver, 1.6
[    2.576555] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.583310] amd-xgbe AMDI8001:00 eth0: net device enabled
[    2.589146] amd-xgbe AMDI8001:01 eth1: net device enabled
[    2.594633] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.600519] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.606506] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.3.0-k
[    2.613528] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.619163] igbvf: Intel(R) Gigabit Virtual Function Network Driver - 
version 2.0.2-k
[    2.627065] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.633050] sky2: driver version 1.30
[    2.636843] VFIO - User Level meta-driver version: 0.3
[    2.642514] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.649101] ehci-pci: EHCI PCI platform driver
[    2.653594] ehci-platform: EHCI generic platform driver
[    2.658876] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    2.664509] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.670744] ohci-pci: OHCI PCI platform driver
[    2.675235] ohci-platform: OHCI generic platform driver
[    2.680552] usbcore: registered new interface driver usb-storage
[    2.686804] mousedev: PS/2 mouse device common for all mice
[    2.787510] ------------[ cut here ]------------
[    2.792173] WARNING: CPU: 0 PID: 1 at 
drivers/firmware/efi/runtime-wrappers.c:32 
efi_call_virt_check_flags+0x84/0xb0
[    2.802786] Modules linked in:
[    2.805860]
[    2.807356] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W 
4.7.0-rc2+ #2
[    2.814900] Hardware name: Default string Default string/Default 
string, BIOS ROD0084E 09/03/2015
[    2.823847] task: ffff8003ec088000 ti: ffff8003ec090000 task.ti: 
ffff8003ec090000
[    2.831393] PC is at efi_call_virt_check_flags+0x84/0xb0
[    2.836745] LR is at virt_efi_get_time+0x68/0x90
[    2.841396] pc : [<ffff0000086746f4>] lr : [<ffff000008674c78>] 
pstate: 000000c5
[    2.848852] sp : ffff8003ec0939e0
[    2.852187] x29: ffff8003ec0939e0 x28: 0000000000000000
[    2.857541] x27: 0000000000000001 x26: ffff000008cc4dd8
[    2.862895] x25: 0000000000000000 x24: ffff0000088b56c8
[    2.868247] x23: ffff8003ec093bc8 x22: ffff8003ec093a60
[    2.873598] x21: 0000000000000040 x20: 00000000000000c0
[    2.878950] x19: ffff000008cc5780 x18: ffffffffffffffff
[    2.884301] x17: 000000000000023f x16: ffffffffffffffff
[    2.889654] x15: ffff8003ebdcd904 x14: 000000000c7e7000
[    2.895006] x13: ffff000008c9b280 x12: 00000000707fe07a
[    2.900359] x11: 0000000000000000 x10: 0000000000000004
[    2.905713] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f
[    2.911066] x7 : ffffffffffffffff x6 : 000000000a200023
[    2.916419] x5 : 000000000000001c x4 : 000000000000000f
[    2.921774] x3 : 0000000000000001 x2 : ffff000008c90000
[    2.927126] x1 : ffff000008a70c38 x0 : 0000000000000040
[    2.932479]
[    2.933974] ---[ end trace 8f08a3f38c8bc1ae ]---
[    2.938623] Call trace:
[    2.941082] Exception stack(0xffff8003ec093820 to 0xffff8003ec093940)
[    2.947572] 3820: ffff000008cc5780 00000000000000c0 ffff8003ec0939e0 
ffff0000086746f4
[    2.955467] 3840: ffff8003ec0938b8 ffff8003ec0939e0 ffff8003ec093880 
0000000021e00f0c
[    2.963363] 3860: ffff8003ec093880 000000000000000c ffff8003ec0938b0 
ffff8003ec0939d8
[    2.971260] 3880: ffff8003ec0939b0 0000000021dc99cc ffff8003ec0939d8 
0000000021e08fb8
[    2.979155] 38a0: ffff8003ec0939e0 0c000f084b435452 080607e000000001 
ffff00000223000a
[    2.987050] 38c0: 0000000000000040 ffff000008a70c38 ffff000008c90000 
0000000000000001
[    2.994946] 38e0: 000000000000000f 000000000000001c 000000000a200023 
ffffffffffffffff
[    3.002842] 3900: 7f7f7f7f7f7f7f7f ffffffffffffffff 0000000000000004 
0000000000000000
[    3.010739] 3920: 00000000707fe07a ffff000008c9b280 000000000c7e7000 
ffff8003ebdcd904
[    3.018634] [<ffff0000086746f4>] efi_call_virt_check_flags+0x84/0xb0
[    3.025037] [<ffff000008674c78>] virt_efi_get_time+0x68/0x90
[    3.030741] [<ffff00000861e7c8>] efi_read_time+0x28/0x78
[    3.036093] [<ffff00000861b49c>] __rtc_read_time.isra.1+0x44/0x70
[    3.042233] [<ffff00000861b500>] rtc_read_time+0x38/0x58
[    3.047585] [<ffff00000861bd3c>] __rtc_read_alarm+0x24/0x388
[    3.053286] [<ffff00000861abc8>] rtc_device_register+0x1a8/0x2e8
[    3.059340] [<ffff00000861add4>] devm_rtc_device_register+0x5c/0xb8
[    3.065656] [<ffff000008b2e354>] efi_rtc_probe+0x2c/0x50
[    3.071009] [<ffff00000849b098>] platform_drv_probe+0x50/0xb8
[    3.076799] [<ffff00000849957c>] driver_probe_device+0x204/0x2b0
[    3.082850] [<ffff0000084996d4>] __driver_attach+0xac/0xb0
[    3.088377] [<ffff000008497528>] bus_for_each_dev+0x60/0xa0
[    3.093994] [<ffff000008498d08>] driver_attach+0x20/0x28
[    3.099349] [<ffff0000084988f8>] bus_add_driver+0x1d0/0x238
[    3.104964] [<ffff000008499e98>] driver_register+0x60/0xf8
[    3.110492] [<ffff00000849b56c>] __platform_driver_probe+0x74/0x128
[    3.116808] [<ffff000008b2e320>] efi_rtc_driver_init+0x20/0x28
[    3.122686] [<ffff000008081a10>] do_one_initcall+0x38/0x128
[    3.128301] [<ffff000008b00cb0>] kernel_init_freeable+0x14c/0x1f0
[    3.134443] [<ffff0000087c3e60>] kernel_init+0x10/0x100
[    3.139707] [<ffff000008084e10>] ret_from_fork+0x10/0x40
[    3.145059] Disabling lock debugging due to kernel taint
[    3.150411] [Firmware Bug]: IRQ flags corrupted 
(0x00000040=>0x000000c0) by EFI get_time
[    3.158654] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    3.164859] i2c /dev entries driver
[    3.168706] sdhci: Secure Digital Host Controller Interface driver
[    3.174939] sdhci: Copyright(c) Pierre Ossman
[    3.179340] Synopsys Designware Multimedia Card Interface Driver
[    3.185447] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.191241] ledtrig-cpu: registered to indicate activity on CPUs
[    3.197482] usbcore: registered new interface driver usbhid
[    3.203101] usbhid: USB HID core driver
[    3.207362] NET: Registered protocol family 17
[    3.211874] 9pnet: Installing 9P2000 support
[    3.216204] Key type dns_resolver registered
[    3.220734] registered taskstats version 1
[    3.294010] [Firmware Bug]: IRQ flags corrupted 
(0x00000040=>0x000000c0) by EFI get_time
[    3.302196] rtc-efi rtc-efi: setting system clock to 2016-06-08 
10:00:36 UTC (1465380036)
[    3.310506] ALSA device list:
[    3.313496]   No soundcards found.
[    4.773842] ata1: SATA link down (SStatus 1 SControl 300)
[    5.244552] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.251799] ata2.00: ATA-8: WDC WD5000AAKX-08U6AA0, 19.01H19, max 
UDMA/100
[    5.258765] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    5.266703] ata2.00: configured for UDMA/100
[    5.271167] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKX-0 
1H19 PQ: 0 ANSI: 5
[    5.300757] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 
GB/466 GiB)
[    5.308352] sd 1:0:0:0: [sda] Write Protect is off
[    5.313205] sd 1:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.372120]  sda: sda1 sda2 sda3 sda4
[    5.376205] sd 1:0:0:0: [sda] Attached SCSI disk
[    5.610698] ata3: SATA link down (SStatus 0 SControl 300)
[    5.926701] ata4: SATA link down (SStatus 0 SControl 300)
[    6.242700] ata5: SATA link down (SStatus 0 SControl 300)
[    6.558698] ata6: SATA link down (SStatus 0 SControl 300)
[    6.874699] ata7: SATA link down (SStatus 0 SControl 300)
[    7.190697] ata8: SATA link down (SStatus 0 SControl 300)
[    7.196384] Freeing unused kernel memory: 960K (ffff800001b00000 - 
ffff800001bf0000)
[    7.209422] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_next_variable
[    7.218384] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_variable
[    7.226884] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_next_variable
[    7.235828] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_variable
[    7.244325] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_next_variable
[    7.253272] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_variable
[    7.261767] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_next_variable
[    7.270703] [Firmware Bug]: IRQ flags corrupted 
(0x000001c0=>0x00000100) by EFI get_variable
[    7.280288] random: systemd urandom read with 14 bits of entropy 
available
[    7.301029] systemd[1]: systemd 222 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP 
+GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    7.319236] systemd[1]: Detected architecture arm64.
[    7.324235] systemd[1]: Running in initial RAM disk.
[    7.329348] systemd[1]: Set hostname to <r2-a30>.
[    7.395733] systemd[1]: Reached target Swap.
[    7.400067] systemd[1]: Starting Swap.
[    7.404129] systemd[1]: Created slice -.slice.
[    7.408628] systemd[1]: Starting -.slice.
[    7.412801] systemd[1]: Listening on udev Kernel Socket.
[    7.418174] systemd[1]: Starting udev Kernel Socket.
[    7.423284] systemd[1]: Listening on Journal Socket.
[    7.428310] systemd[1]: Starting Journal Socket.
[    7.433049] systemd[1]: Listening on udev Control Socket.
[    7.438510] systemd[1]: Starting udev Control Socket.
[    7.443749] systemd[1]: Listening on Journal Audit Socket.
[    7.449297] systemd[1]: Starting Journal Audit Socket.
[    7.454602] systemd[1]: Created slice System Slice.
[    7.459540] systemd[1]: Starting System Slice.
[    7.464164] systemd[1]: Started Load Kernel Modules.
[    7.480669] systemd[1]: Starting Create list of required static 
device nodes for the current kernel...
[    7.490177] systemd[1]: Reached target Slices.
[    7.494679] systemd[1]: Starting Slices.
[    7.499134] systemd[1]: Starting Setup Virtual Console...
[    7.504659] systemd[1]: Reached target Timers.
[    7.509158] systemd[1]: Starting Timers.
[    7.513654] systemd[1]: Starting Apply Kernel Variables...
[    7.519306] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.525296] systemd[1]: Starting Journal Socket (/dev/log).
[    7.531424] systemd[1]: Starting Journal Service...
[    7.536411] systemd[1]: Reached target Sockets.
[    7.540994] systemd[1]: Starting Sockets.
[    7.545087] systemd[1]: Started dracut ask for additional cmdline 
parameters.
[    7.552429] systemd[1]: Started dracut cmdline hook.
[    7.557577] systemd[1]: Started dracut pre-udev hook.
[    7.562725] systemd[1]: Reached target Local File Systems.
[    7.568268] systemd[1]: Starting Local File Systems.
[    7.573636] systemd[1]: Started Journal Service.
[    7.578417] audit: type=1130 audit(1465380040.772:2): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.597915] audit: type=1130 audit(1465380040.792:3): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[    7.617291] audit: type=1130 audit(1465380040.812:4): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-vconsole-setup 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[    7.637083] audit: type=1130 audit(1465380040.832:5): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.665065] audit: type=1130 audit(1465380040.860:6): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[    7.692082] audit: type=1130 audit(1465380040.884:7): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.784695] audit: type=1130 audit(1465380040.980:8): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-udev-trigger 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[    8.341316] audit: type=1130 audit(1465380041.536:9): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=plymouth-start comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.360585] audit: type=1130 audit(1465380041.556:10): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-fsck-root 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[    8.426608] EXT4-fs (sda4): mounted filesystem with ordered data 
mode. Opts: (null)
[    8.543480] audit: type=1130 audit(1465380041.736:11): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=initrd-parse-etc comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.687290] systemd-journald[1161]: Received SIGTERM from PID 1 
(systemd).
[    9.670747] random: nonblocking pool is initialized
[   10.625747] EXT4-fs (sda4): re-mounted. Opts: (null)
[   10.799154] systemd-journald[1985]: Received request to flush runtime 
journal from PID 1
[   11.119332] systemd-journald[1985]: File 
/var/log/journal/4093f4c1222643beb64d09dc8741b6a9/system.journal 
corrupted or uncleanly shut down, renaming and replacing.
[   12.417349] Unable to find swap-space signature
[   12.549307] Unable to find swap-space signature
[   12.780816] audit_printk_skb: 102 callbacks suppressed
[   12.786016] audit: type=1130 audit(1465380045.976:46): pid=1 uid=0 
auid=4294967295 ses=4294967295 
msg='unit=systemd-fsck at dev-disk-by\x2duuid-f9c7bb47\x2dfd26\x2d4d45\x2d879f\x2d448c5f59bc49 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[   12.877796] audit: type=1130 audit(1465380046.072:47): pid=1 uid=0 
auid=4294967295 ses=4294967295 
msg='unit=systemd-fsck at dev-disk-by\x2duuid-1A10\x2dF85E comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   12.923032] EXT4-fs (sda2): mounted filesystem with ordered data 
mode. Opts: (null)
[   13.078144] audit: type=1130 audit(1465380046.272:48): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[   13.114018] audit: type=1130 audit(1465380046.308:49): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   13.133713] audit: type=1130 audit(1465380046.328:50): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[   13.153022] audit: type=1131 audit(1465380046.348:51): pid=1 uid=0 
auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write 
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? 
terminal=? res=success'
[   13.376667] audit: type=1305 audit(1465380046.572:52): 
audit_enabled=1 old=1 auid=4294967295 ses=4294967295 res=1
[   13.387064] audit: type=1305 audit(1465380046.580:53): audit_pid=2788 
old=0 auid=4294967295 ses=4294967295 res=1
[   14.812410] Unable to find swap-space signature
[   14.949220] Unable to find swap-space signature
[   15.001335] polkitd[2853]: unhandled level 0 translation fault (11) 
at 0x7fff8d10c040, esr 0x92000004
[   15.010665] pgd = ffff8003ea5f3000
[   15.014123] [7fff8d10c040] *pgd=0000000000000000
[   15.018806]
[   15.020320] CPU: 0 PID: 2853 Comm: polkitd Tainted: G        W I 
4.7.0-rc2+ #2
[   15.027985] Hardware name: Default string Default string/Default 
string, BIOS ROD0084E 09/03/2015
[   15.036966] task: ffff8003ea7c3200 ti: ffff8003ea108000 task.ti: 
ffff8003ea108000
[   15.044545] PC is at 0xffff90160930
[   15.048088] LR is at 0xffff900f59a0
[   15.051608] pc : [<0000ffff90160930>] lr : [<0000ffff900f59a0>] 
pstate: 80000000
[   15.059069] sp : 0000fffff59a6f90
[   15.062406] x29: 0000fffff59a7380 x28: 0000aaaae12ece70
[   15.067773] x27: 0000fffff59a7070 x26: 0000000000000000
[   15.073167] x25: 00007fff8d10c040 x24: 0000aaaae12ed3f8
[   15.078524] x23: 0000000000000000 x22: 0000000000000000
[   15.083913] x21: 0000000000000008 x20: 0000ffff90306000
[   15.089280] x19: 0000ffff90306000 x18: 0000ffff8fe8e758
[   15.094642] x17: 0000ffff90124608 x16: 0000ffff90306240
[   15.099997] x15: 0000000000000020 x14: 0000000000000000
[   15.105356] x13: 0000000000000000 x12: 0000000000000000
[   15.110710] x11: 0000000000000000 x10: 0000ffff90306000
[   15.116069] x9 : 0000ffff90306000 x8 : 0000ffff90306000
[   15.121440] x7 : 0000000000000005 x6 : 0000ffff90306000
[   15.126819] x5 : 0000ffff9028a340 x4 : 0000000000000000
[   15.132180] x3 : 0000000000000001 x2 : 0000ffff907c0c60
[   15.137540] x1 : 0000aaaae12e8bc0 x0 : 00007fff8d10c040
[   15.142898]
[   15.664622] amd-xgbe AMDI8001:00 eth0: Link is Up - 1Gbps/Full - flow 
control off
[   16.112422] Unable to find swap-space signature
[   16.165231] Unable to find swap-space signature
[   22.418657] efi_call_virt_check_flags: 41 callbacks suppressed
[   22.424539] [Firmware Bug]: IRQ flags corrupted 
(0x00000140=>0x000001c0) by EFI set_time
[   22.523765] [Firmware Bug]: IRQ flags corrupted 
(0x00000140=>0x000001c0) by EFI get_time
