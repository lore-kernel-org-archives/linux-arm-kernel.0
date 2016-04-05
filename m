From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 5 Apr 2016 14:23:41 +0900
Subject: Help needed with kexec on arm64
In-Reply-To: <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
References: <DB5PR04MB168845795D86B4CE5BA5656FE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <1458230896.3391.18.camel@infradead.org>
 <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
Message-ID: <20160405052341.GA19476@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 10:49:01AM +0000, Harninder Rai wrote:
> Hello Takahiro Akashi/Geoff,
> 
> With memblock option added to bootargs, I get the following
> Any pointers as to what could be going wrong here?
> 
> [    0.000000] Linux version 4.5.0-rc6-00038-gae2804a-dirty (hrai at nmglablinux22) (gcc version 4.8.3 20140401 (prerelease) (Linaro GCC 4.8-2014.04) ) #2 SMP PREEMPT Fri Mar 11 14:45:30 IST 2016
> [    0.000000] Boot CPU: AArch64 Processor [411fd071]
> [    0.000000] Ignoring memory range 0x80000000 - 0x8c000000
> [    0.000000] earlycon: Early serial console at MMIO 0x21c0600 (options '')
> [    0.000000] bootconsole [uart0] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.
> [    0.000000] memblock_reserve: [0x0000008c080000-0x0000008cc40fff] flags 0x0 arm64_memblock_init+0x98/0x26c
> [    0.000000] memblock_reserve: [0x0000008cc41000-0x0000008e79ffd4] flags 0x0 arm64_memblock_init+0xc0/0x26c
> [    0.000000] memblock_reserve: [0x0000008ffff000-0x0000008ffff3ff] flags 0x0 arm64_memblock_init+0x1f8/0x26c
> [    0.000000] Reserving 1KB of memory at 0x8ffff000 for elfcorehdr
> [    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 0000000080000000, 0000000000010000
> [    0.000000] memblock_reserve: [0x00000080000000-0x0000008000ffff] flags 0x0 early_init_dt_reserve_memory_arch+0x1c/0x24
> [    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 00000000fff09e90, 0000000000000578
> [    0.000000] memblock_reserve: [0x000000fff09e90-0x000000fff0a407] flags 0x0 early_init_dt_reserve_memory_arch+0x1c/0x24
> [    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 000000009fff9000, 0000000000004000
> [    0.000000] memblock_reserve: [0x0000009fff9000-0x0000009fffcfff] flags 0x0 early_init_dt_reserve_memory_arch+0x1c/0x24
> [    0.000000] early_init_fdt_scan_reserved_mem: ERROR: /memreserve/ field not compatible with kexec: 00000000a0515e2c, 0000000001a64530
> [    0.000000] memblock_reserve: [0x000000a0515e2c-0x000000a1f7a35b] flags 0x0 early_init_dt_reserve_memory_arch+0x1c/0x24
> [    0.000000] memblock_reserve: [0x0000008ec00000-0x0000008fbfffff] flags 0x0 memblock_alloc_range_nid+0x64/0x78
> [    0.000000] cma: Reserved 16 MiB at 0x000000008ec00000
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x4000000 reserved size = 0x519d181
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000008c000000-0x0000008fffffff], 0x4000000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x8
> [    0.000000]  reserved[0x0]   [0x00000080000000-0x0000008000ffff], 0x10000 bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x0000008c080000-0x0000008e79ffd4], 0x271ffd5 bytes flags: 0x0
> [    0.000000]  reserved[0x2]   [0x0000008e7a0000-0x0000008e7a4303], 0x4304 bytes flags: 0x0
> [    0.000000]  reserved[0x3]   [0x0000008ec00000-0x0000008fbfffff], 0x1000000 bytes flags: 0x0
> [    0.000000]  reserved[0x4]   [0x0000008ffff000-0x0000008ffff3ff], 0x400 bytes flags: 0x0
> [    0.000000]  reserved[0x5]   [0x0000009fff9000-0x0000009fffcfff], 0x4000 bytes flags: 0x0
> [    0.000000]  reserved[0x6]   [0x000000a0515e2c-0x000000a1f7a35b], 0x1a64530 bytes flags: 0x0
> [    0.000000]  reserved[0x7]   [0x000000fff09e90-0x000000fff0a407], 0x578 bytes flags: 0x0
> [    0.000000] memblock_reserve: [0x0000008fffe000-0x0000008fffefff] flags 0x0 memblock_alloc_range_nid+0x64/0x78
> [    0.000000] memblock_virt_alloc_try_nid: 4096 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 sparse_index_alloc+0x4c/0x58
> [    0.000000] memblock_reserve: [0x0000008fffd000-0x0000008fffdfff] flags 0x0 memblock_virt_alloc_internal+0x18c/0x1e4
> [    0.000000] memblock_virt_alloc_try_nid: 2097152 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 sparse_init+0x38/0x1f4
> [    0.000000] memblock_reserve: [0x0000008fdfd000-0x0000008fffcfff] flags 0x0 memblock_virt_alloc_internal+0x18c/0x1e4
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 256 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 sparse_early_usemaps_alloc_node+0x38/0xac
> [    0.000000] memblock_reserve: [0x0000008fffff00-0x0000008fffffff] flags 0x0 memblock_virt_alloc_internal+0x18c/0x1e4
> [    0.000000] memblock_virt_alloc_try_nid: 4096 bytes align=0x1000 nid=0 from=0x8c000000 max_addr=0x0 __earlyonly_bootmem_alloc+0x20/0x28
> [    0.000000] memblock_reserve: [0x0000008fdfc000-0x0000008fdfcfff] flags 0x0 memblock_virt_alloc_internal+0x18c/0x1e4
> [    0.000000] memblock_virt_alloc_try_nid: 4096 bytes align=0x1000 nid=0 from=0x8c000000 max_addr=0x0 __earlyonly_bootmem_alloc+0x20/0x28
> [    0.000000] memblock_reserve: [0x0000008fdfb000-0x0000008fdfbfff] flags 0x0 memblock_virt_alloc_internal+0x18c/0x1e4
> [    0.000000] memblock_virt_alloc_try_nid: 2097152 bytes align=0x200000 nid=0 from=0x8c000000 max_addr=0x0 __earlyonly_bootmem_alloc+0x20/0x28
> [    0.000000] memblock_reserve: [0x0000008ea00000-0x0000008ebfffff] flags 0x0 memblock_virt_alloc_internal+0x18c/0x1e4
> [    0.000000] memblock_virt_alloc_try_nid: 2097152 bytes align=0x200000 nid=0 from=0x8c000000 max_addr=0x0 __earlyonly_bootmem_alloc+0x20/0x28
> [    0.000000] memblock_reserve: [0x0000008e800000-0x0000008e9fffff] flags 0x0 memblock_virt_alloc_internal+0x18c/0x1e4
> [    0.000000] memblock_virt_alloc_try_nid: 2097152 bytes align=0x200000 nid=0 from=0x8c000000 max_addr=0x0 __earlyonly_bootmem_alloc+0x20/0x28
> [    0.000000] Kernel panic - not syncing: memblock_virt_alloc_try_nid: Failed to allocate 2097152 bytes align=0x200000 nid=0 from=0x8c000000 max_addr=0x0

This means that there is no enough space left at this point.
I guess that you are using too big initramfs against 64MB of total memory.
Just increase the memory size for crash dump kernel.

-Takahiro AKASHI

> 
> Thanks and Regards
> Harry++
