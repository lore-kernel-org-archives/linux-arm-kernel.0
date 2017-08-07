From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 7 Aug 2017 16:27:32 +0100
Subject: next-20170804 boot failure
In-Reply-To: <a68cf4be-6490-b1cd-dbeb-66b355c8c031@riken.jp>
References: <a68cf4be-6490-b1cd-dbeb-66b355c8c031@riken.jp>
Message-ID: <20170807152732.GA27381@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Itaru,

On Mon, Aug 07, 2017 at 12:21:40PM +0900, Itaru Kitayama wrote:
> Hi,
> 
> The latest linux-next fails to boot on Mustang. Has anyone seen it on
> other arm64 machines?

No, do you mind sending the config file you are using please ?

Thanks,
Lorenzo

> EFI stub: Booting Linux Kernel...
> EFI stub: EFI_RNG_PROTOCOL unavailable, no randomness supplied
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> L3C: 8MB
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.13.0-rc3-next-20170804
> (itaru.kitayama at r2-a21) (gcc version 7.1.1 20170622 (Red Hat
> 7.1.1-3) (GCC)) #25 SMP PREEMPT Sun Aug 6 20:58:38 CDT 2017
> [    0.000000] Boot CPU: AArch64 Processor [500f0001]
> [    0.000000] Machine model: APM X-Gene Mustang board
> [    0.000000] earlycon: uart8250 at MMIO32 0x000000001c020000 (options '')
> [    0.000000] bootconsole [uart8250] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.40 by X-Gene Mustang Board EFI Oct 17
> 2016 13:54:05
> [    0.000000] efi:  ACPI=0x47fa700000  ACPI 2.0=0x47fa700014
> SMBIOS 3.0=0x47fa9db000  ESRT=0x47ff006d18
> [    0.000000] esrt: Reserving ESRT space from 0x00000047ff006d18 to
> 0x00000047ff006d78.
> [    0.000000] cma: Reserved 512 MiB at 0x00000040e0000000
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000047FA700014 000024 (v02 APM   )
> [    0.000000] ACPI: XSDT 0x00000047FA6F00E8 000084 (v01 APM
> XGENE 00000003      01000013)
> [    0.000000] ACPI: FACP 0x00000047FA6C0000 00010C (v05 APM
> XGENE 00000003 INTL 20140724)
> [    0.000000] ACPI: DSDT 0x00000047FA6D0000 005922 (v05 APM
> APM88xxx 00000001 INTL 20140724)
> [    0.000000] ACPI: DBG2 0x00000047FA6E0000 0000AA (v00 APMC0D
> XGENEDBG 00000000 INTL 20140724)
> [    0.000000] ACPI: GTDT 0x00000047FA6A0000 000060 (v02 APM
> XGENE 00000001 INTL 20140724)
> [    0.000000] ACPI: MCFG 0x00000047FA690000 00003C (v01 APM
> XGENE 00000002 INTL 20140724)
> [    0.000000] ACPI: SPCR 0x00000047FA680000 000050 (v02 APMC0D
> XGENESPC 00000000 INTL 20140724)
> [    0.000000] ACPI: SSDT 0x00000047FA670000 00002D (v02 APM
> XGENE 00000001 INTL 20140724)
> [    0.000000] ACPI: BERT 0x00000047FA660000 000030 (v01 APM
> XGENE 00000002 INTL 20140724)
> [    0.000000] ACPI: HEST 0x00000047FA650000 0002A8 (v01 APM
> XGENE 00000002 INTL 20140724)
> [    0.000000] ACPI: APIC 0x00000047FA640000 0002A4 (v03 APM
> XGENE 00000003      01000013)
> [    0.000000] ACPI: SSDT 0x00000047FA630000 000063 (v02 REDHAT
> MACADDRS 00000001      01000013)
> [    0.000000] ACPI: SSDT 0x00000047FA620000 000032 (v02 REDHAT
> UARTCLKS 00000001      01000013)
> [    0.000000] ACPI: PCCT 0x00000047FA610000 000300 (v01 APM
> XGENE 00000003      01000013)
> [    0.000000] ACPI: SPCR: console: uart,mmio32,0x1c020000,115200
> [    0.000000] ACPI: NUMA: Failed to initialise from firmware
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000000000000-0x00000047ffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x47ffffe500-0x47ffffffff]
> [    0.000000] kmemleak: Kernel memory leak detector disabled
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000004000000000-0x00000040ffffffff]
> [    0.000000]   Normal   [mem 0x0000004100000000-0x00000047ffffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000004000000000-0x00000040001fffff]
> [    0.000000]   node   0: [mem 0x0000004000200000-0x00000047fa59ffff]
> [    0.000000]   node   0: [mem 0x00000047fa5a0000-0x00000047fa9dffff]
> [    0.000000]   node   0: [mem 0x00000047fa9e0000-0x00000047ff99ffff]
> [    0.000000]   node   0: [mem 0x00000047ff9a0000-0x00000047ff9affff]
> [    0.000000]   node   0: [mem 0x00000047ff9b0000-0x00000047ff9bffff]
> [    0.000000]   node   0: [mem 0x00000047ff9c0000-0x00000047ff9effff]
> [    0.000000]   node   0: [mem 0x00000047ff9f0000-0x00000047ffffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000004000000000-0x00000047ffffffff]
> [    0.000000] On node 0 totalpages: 524288
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 65536 pages, LIFO batch:1
> [    0.000000]   Normal zone: 448 pages used for memmap
> [    0.000000]   Normal zone: 458752 pages, LIFO batch:1
> [    0.000000] kasan: KernelAddressSanitizer initialized
> [    0.000000] psci: is not implemented in ACPI.
> [    0.000000] Unsupported ACPI enable-method
> [    0.000000] Unsupported ACPI enable-method
> [    0.000000] Unsupported ACPI enable-method
> [    0.000000] Unsupported ACPI enable-method
> [    0.000000] Unsupported ACPI enable-method
> [    0.000000] Unsupported ACPI enable-method
> [    0.000000] Unsupported ACPI enable-method
> [    0.000000] percpu: Embedded 3 pages/cpu @ffff8006faff0000
> s135320 r8192 d53096 u196608
> [    0.000000] pcpu-alloc: s135320 r8192 d53096 u196608 alloc=3*65536
> [    0.000000] pcpu-alloc: [0] 0
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 523776
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line:
> BOOT_IMAGE=/vmlinuz-4.13.0-rc3-next-20170804
> root=UUID=0e305934-49d5-4f66-b10b-23ec6029fab9 ro acpi=force
> earlycon=uart8250,mmio32,0x1c020000 console=ttyS0,115200 loglevel=8
> LANG=en_US.UTF-8
> [    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
> [    0.000000] software IO TLB [mem 0x40dbff0000-0x40dfff0000]
> (64MB) mapped at [ffff8000dbff0000-ffff8000dffeffff]
> [    0.000000] Memory: 28621504K/33554432K available (27452K kernel
> code, 5930K rwdata, 6592K rodata, 12288K init, 10141K bss, 4408640K
> reserved, 524288K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     kasan   : 0xffff000000000000 - 0xffff200000000000
> ( 32768 GB)
> [    0.000000]     modules : 0xffff200000000000 - 0xffff200008000000
> (   128 MB)
> [    0.000000]     vmalloc : 0xffff200008000000 - 0xffff7bdfffff0000
> ( 94079 GB)
> [    0.000000]       .text : 0xffff200008130000 - 0xffff200009c00000
> ( 27456 KB)
> [    0.000000]     .rodata : 0xffff200009c00000 - 0xffff20000a400000
> (  8192 KB)
> [    0.000000]       .init : 0xffff20000a400000 - 0xffff20000b000000
> ( 12288 KB)
> [    0.000000]       .data : 0xffff20000b000000 - 0xffff20000b5caa00
> (  5931 KB)
> [    0.000000]        .bss : 0xffff20000b5caa00 - 0xffff20000bfb1fc0
> ( 10142 KB)
> [    0.000000]     fixed   : 0xffff7fdffe7d0000 - 0xffff7fdffec00000
> (  4288 KB)
> [    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000
> (    16 MB)
> [    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000
> (   128 GB maximum)
> [    0.000000]               0xffff7fe000000000 - 0xffff7fe002000000
> (    32 MB actual)
> [    0.000000]     memory  : 0xffff800000000000 - 0xffff800800000000
> ( 32768 MB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] ftrace: allocating 32229 entries in 8 pages
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
> [    0.000000] 	Tasks RCU enabled.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: No distributor detected at @ffff200008050000,
> giving up
> [    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> [    0.000004] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
> every 4398046511100ns
> [    0.008446] Console: colour dummy device 80x25
> [    0.013072] kmemleak: Early log buffer exceeded (67903), please
> increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> [    0.022776] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 100.00 BogoMIPS (lpj=50000)
> [    0.033509] pid_max: default: 32768 minimum: 301
> [    0.038289] ACPI: Core revision 20170629
> [    0.042582] Unable to handle kernel paging request at virtual
> address ffff040001808000
> [    0.050742] swapper pgtable: 64k pages, 48-bit VAs, pgd =
> ffff20000bff0000
> [    0.057814] [ffff040001808000] *pgd=00000047ff990003,
> *pud=00000047ff990003, *pmd=00000047ff980003, *pte=0000000000000000
> [    0.069182] Internal error: Oops: 96000007 [#1] PREEMPT SMP
> [    0.074968] Modules linked in:
> [    0.078149] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.13.0-rc3-next-20170804 #25
> [    0.085963] Hardware name: APM X-Gene Mustang board (DT)
> [    0.091430] task: ffff20000b02d680 task.stack: ffff20000b000000
> [    0.097556] PC is at acpi_tb_verify_checksum+0x28/0xe0
> [    0.102857] LR is at acpi_tb_verify_temp_table+0x27c/0x698
> [    0.108608] pc : [<ffff200008ec9630>] lr : [<ffff200008ec5a50>]
> pstate: 10400045
> [    0.116310] sp : ffff20000b003c80
> [    0.119804] x29: ffff20000b003c80 x28: 1fffe400017eecfc
> [    0.125325] x27: ffff20000a518f60 x26: ffff20000b003ec0
> [    0.130828] x25: ffff20000bf767e0 x24: ffff200009e347c0
> [    0.136356] x23: ffff200009e346c0 x22: ffff20000c040000
> [    0.141824] x21: ffff200009e34000 x20: 000000000000002d
> [    0.147275] x19: ffff20000c040000 x18: 1ffff000ffffac04
> [    0.152718] x17: 0000000000000000 x16: ffff20000b02d680
> [    0.158168] x15: 0000000000000249 x14: ffff20000b02a000
> [    0.163688] x13: ffff200008ec58ac x12: ffff20000a016000
> [    0.169182] x11: ffff20000a217000 x10: 0400000000000001
> [    0.174694] x9 : 00e8000000000713 x8 : 0000000000000008
> [    0.180188] x7 : ffff24000c040000 x6 : ffff8007fffe0008
> [    0.185673] x5 : 0000e047ee630000 x4 : 0000000000000000
> [    0.191167] x3 : 0000000000000000 x2 : 0000000000000000
> [    0.196712] x1 : 1fffe40001808000 x0 : dfff200000000000
> [    0.202251] Process swapper/0 (pid: 0, stack limit = 0xffff20000b000000)
> [    0.209220] Stack: (0xffff20000b003c80 to 0xffff20000b004000)
> [    0.215206] 3c80: ffff20000b003ca0 ffff200008ec5a50
> ffff20000a518f60 dfff200000000000
> [    0.223290] 3ca0: ffff20000b003e30 ffff20000a467d54
> ffff20000bf76000 ffff200009e35000
> [    0.231470] 3cc0: ffff20000bf76000 1fffe400016007d4
> ffff20000bf767e8 0000000000000006
> [    0.239615] 3ce0: ffff20000bf767e0 dfff200000000000
> ffff20000a518f60 1fffe400017eecfc
> [    0.247716] 3d00: ffff0400017eecfd ffff20000a518f70
> ffff20000a518f68 1fffe400016007be
> [    0.255818] 3d20: 1fffe400014a31ee 1fffe400014a31ed
> ffff20000bf767e8 ffff2000080f0000
> [    0.263885] 3d40: 0000000000000180 1fffe400016007aa
> 0000000041b58ab3 ffff20000a1de4d8
> [    0.272004] 3d60: ffff200008ec57d4 ffff200008eceed8
> ffff20000bf75005 0000000000000008
> [    0.280028] 3d80: 00000000000000ad ffff200009e35f60
> 0000000041b58ab3 ffff20000a1de883
> [    0.288095] 3da0: ffff200008eced3c ffff2000086b75cc
> ffff20000000003c ffff2000085fa778
> [    0.296162] 3dc0: ffff20000b003df0 ffff200008ed5d9c
> 0000000000000002 ffff20000bf76000
> [    0.304176] 3de0: 0000000000000002 ffff20000b116720
> ffff2000080f0000 ffff20000a467b60
> [    0.312243] 3e00: ffff20000bf76000 ffff200009e35000
> ffff20000bf76000 1fffe400016007d4
> [    0.320337] 3e20: ffff20000bf76000 0000000000000000
> ffff20000b003f00 ffff20000a464130
> [    0.328352] 3e40: ffff200009e08000 ffff20000b040000
> ffff20000bf72000 1fffe400016007f2
> [    0.336453] 3e60: ffff20000b630000 ffff20000b713000
> ffff7fe000000000 ffff8007ffffe100
> [    0.344564] 3e80: ffff20000a500028 0000004002600018
> ffff20000b003ec0 ffff0400017eecfd
> [    0.352570] 3ea0: 0000000041b58ab3 ffff20000a1de6b0
> ffff20000a467a28 ffff200009cb5b00
> [    0.360646] 3ec0: 000000000047f858 0000000020170629
> ffff20000b003f00 ffff20000a46412c
> [    0.368782] 3ee0: ffff200009e08000 ffff8006faff0000
> ffff20000bf72000 0000000000000000
> [    0.376866] 3f00: ffff20000b003f30 ffff20000a401240
> ffff200009c00000 ffff7fdff0000000
> [    0.384924] 3f20: 000000000047f858 ffff7fdff0000000
> ffff20000b003ff0 ffff20000a4001fc
> [    0.393060] 3f40: 0000000034d5d91d 0000000030d00800
> 00000047fc800000 00000047f7fa29e8
> [    0.401135] 3f60: 0000000000000000 00000047f7fa29e8
> 00000047f7f61000 00000047f7ed5ae0
> [    0.409185] 3f80: 0000000000000000 ffff20000a4001e8
> 0000000041b58ab3 ffff20000a180b58
> [    0.417295] 3fa0: ffff20000a400dcc 00000047f7fa29e8
> ffff20000a500028 00000047f7fa29e8
> [    0.425371] 3fc0: 00000047f7f61000 00000047f7ed5ae0
> 0000000000000000 0000004002600018
> [    0.433472] 3fe0: 0000000000000000 ffff20000b600000
> 0000000000000000 0000004001c652d0
> [    0.441591] Call trace:
> [    0.444136] Exception stack(0xffff20000b003a40 to 0xffff20000b003b70)
> [    0.450830] 3a40: ffff20000c040000 0001000000000000
> 0000004004220000 ffff200008ec9630
> [    0.458906] 3a60: 0000000010400045 0000000000000025
> ffff20000bf767e0 ffff20000b003ec0
> [    0.467016] 3a80: ffff20000a518f60 1fffe400017eecfc
> 0000000041b58ab3 ffff20000a181220
> [    0.475066] 3aa0: ffff200008131550 ffff20000a185880
> ffff200009a4cf10 ffff20000b003df0
> [    0.483133] 3ac0: ffff8006faf9c300 0000000000000001
> 1fffe400014a31e7 dfff200000000000
> [    0.491217] 3ae0: 00000047fa690000 1fffe400016007ae
> ffff20000b003c90 ffff20000b68b000
> [    0.499284] 3b00: ffff8006faf9c300 ffff20000a185880
> ffff200009a4cf10 0000000000000000
> [    0.507351] 3b20: ffff20000b003b40 ffff200009a4d6b0
> ffff8006faf9bd00 0000004002600018
> [    0.515435] 3b40: ffff8006faf9b100 ffff200009a4d7c8
> dfff200000000000 1fffe40001808000
> [    0.523500] 3b60: 0000000000000000 0000000000000000
> [    0.528518] [<ffff200008ec9630>] acpi_tb_verify_checksum+0x28/0xe0
> [    0.534892] [<ffff200008ec5a50>] acpi_tb_verify_temp_table+0x27c/0x698
> [    0.541614] [<ffff20000a467d54>] acpi_reallocate_root_table+0x32c/0x340
> [    0.548462] [<ffff20000a464130>] acpi_early_init+0xb0/0x21c
> [    0.554223] [<ffff20000a401240>] start_kernel+0x474/0x51c
> [    0.559802] [<ffff20000a4001fc>] __primary_switched+0x80/0x94
> [    0.565780] Code: d503201f d343fe61 d2c40000 f2fbffe0 (38e06821)
> [    0.572093] random: get_random_bytes called from
> print_oops_end_marker+0x54/0x78 with crng_init=0
> [    0.581244] ---[ end trace 0000000000000000 ]---
> [    0.585998] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.592912] ---[ end Kernel panic - not syncing: Attempted to
> kill the idle task!
