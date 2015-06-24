From: achandran@mvista.com (Arun Chandran)
Date: Wed, 24 Jun 2015 18:43:37 +0530
Subject: BUG: Bad page state in process swapper pfn:XXXXX
In-Reply-To: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
References: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
Message-ID: <CAFdej00-ibedz6s280VGWnPji42BqX2z4+oSj6AgHk99WEC4uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 8:04 PM, Arun Chandran <achandran@mvista.com> wrote:
> Hi,
>
> I am booting the latest linus tree on altera cyclone5 soc development kit.
> (https://www.altera.com/products/boards_and_kits/dev-kits/altera/kit-cyclone-v-soc.html)
> With the dtb file arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb.
>
> I get these BUGS (page dumped because: non-NULL mapping) randomly; occurs
> around 1 in 5 times during cold boots.
>
> The entire bootlog with 'memblock=debug' is below.
>
> ##################
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Linux version 4.1.0 (arun at arun-OptiPlex-9010) (gcc
> version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11) ) #87 SMP Mon
> Jun 22 19:47:47 IST 2015
> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] Machine model: Altera SOCFPGA Cyclone V SoC Development Kit
> [    0.000000] memblock_reserve: [0x00000000008280-0x000000009a4b6b]
> flags 0x0 arm_memblock_init+0x28/0x194
> [    0.000000] memblock_reserve: [0x00000000004000-0x00000000007fff]
> flags 0x0 arm_memblock_init+0x148/0x194
> [    0.000000] memblock_reserve: [0x00000003ff9000-0x00000003fffc8f]
> flags 0x0 early_init_fdt_scan_reserved_mem+0x38/0x8c
> [    0.000000] memblock_reserve: [0x00000000000000-0x00000000000fff]
> flags 0x0 early_init_fdt_scan_reserved_mem+0x6c/0x8c
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x20000000 reserved size = 0x9a857c
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x00000000000000-0x0000001fffffff],
> 0x20000000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x4
> [    0.000000]  reserved[0x0]   [0x00000000000000-0x00000000000fff],
> 0x1000 bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x00000000004000-0x00000000007fff],
> 0x4000 bytes flags: 0x0
> [    0.000000]  reserved[0x2]   [0x00000000008280-0x000000009a4b6b],
> 0x99c8ec bytes flags: 0x0
> [    0.000000]  reserved[0x3]   [0x00000003ff9000-0x00000003fffc8f],
> 0x6c90 bytes flags: 0x0
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] memblock_reserve: [0x0000001fffe000-0x0000001fffffff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffd000-0x0000001fffdfff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffcfd8-0x0000001fffcfff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffb000-0x0000001fffbfff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffcfb0-0x0000001fffcfd7]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffa000-0x0000001fffafff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fff9000-0x0000001fff9fff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fff8000-0x0000001fff8fff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] On node 0 totalpages: 131072
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 4194304 bytes
> align=0x0 nid=0 from=0x0 max_addr=0x0
> alloc_node_mem_map.constprop.88+0x68/0x90
> [    0.000000] memblock_reserve: [0x0000001fbf8000-0x0000001fff7fff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] free_area_init_node: node 0, pgdat c097fbc0,
> node_mem_map dfbf8000
> [    0.000000]   Normal zone: 1024 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 131072 pages, LIFO batch:31
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 64 bytes align=0x0
> nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x290/0x310
> [    0.000000] memblock_reserve: [0x0000001fffcf40-0x0000001fffcf7f]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 6144 bytes
> align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x78/0xe4
> [    0.000000] memblock_reserve: [0x0000001fbf6800-0x0000001fbf7fff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 28 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 setup_arch+0x618/0x968
> [    0.000000] memblock_reserve: [0x0000001fffcf80-0x0000001fffcf9b]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_reserve: [0x0000001fbeaa18-0x0000001fbf67ff]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffcf20-0x0000001fffcf3c]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffcf00-0x0000001fffcf1c]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffcee4-0x0000001fffcefe]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffcec8-0x0000001fffcee2]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffceac-0x0000001fffcec5]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffce90-0x0000001fffcea9]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffce74-0x0000001fffce8d]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_reserve: [0x0000001fffce58-0x0000001fffce71]
> flags 0x0 memblock_alloc_range_nid+0x38/0x4c
> [    0.000000] memblock_virt_alloc_try_nid: 78 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 start_kernel+0xd0/0x3b0
> [    0.000000] memblock_reserve: [0x0000001fffce00-0x0000001fffce4d]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 78 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 start_kernel+0xf4/0x3b0
> [    0.000000] memblock_reserve: [0x0000001fffcd80-0x0000001fffcdcd]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 78 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 start_kernel+0x118/0x3b0
> [    0.000000] memblock_reserve: [0x0000001fffcd00-0x0000001fffcd4d]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes
> align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x4c/0x88
> [    0.000000] memblock_reserve: [0x0000001fbe9a00-0x0000001fbea9ff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes
> align=0x0 nid=-1 from=0x0 max_addr=0x0
> pcpu_embed_first_chunk+0x4d8/0x784
> [    0.000000] memblock_reserve: [0x0000001fbe8a00-0x0000001fbe99ff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 98304 bytes
> align=0x1000 nid=-1 from=0x3fffffff max_addr=0x0
> pcpu_dfl_fc_alloc+0x24/0x2c
> [    0.000000] memblock_reserve: [0x0000001fbd0000-0x0000001fbe7fff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] __memblock_free_early:
> [0x0000001fbdc000-0x0000001fbdbfff] pcpu_embed_first_chunk+0x624/0x784
> [    0.000000] __memblock_free_early:
> [0x0000001fbe8000-0x0000001fbe7fff] pcpu_embed_first_chunk+0x624/0x784
> [    0.000000] PERCPU: Embedded 12 pages/cpu @dfbd0000 s19648 r8192
> d21312 u49152
> [    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x324/0x9fc
> [    0.000000] memblock_reserve: [0x0000001fffccc0-0x0000001fffccc3]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x344/0x9fc
> [    0.000000] memblock_reserve: [0x0000001fffcc80-0x0000001fffcc83]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x364/0x9fc
> [    0.000000] memblock_reserve: [0x0000001fffcc40-0x0000001fffcc47]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x384/0x9fc
> [    0.000000] memblock_reserve: [0x0000001fffcc00-0x0000001fffcc07]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] pcpu-alloc: s19648 r8192 d21312 u49152 alloc=12*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1
> [    0.000000] memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x760/0x9fc
> [    0.000000] memblock_reserve: [0x0000001fffcb80-0x0000001fffcbf7]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x7a8/0x9fc
> [    0.000000] memblock_reserve: [0x0000001fffcb00-0x0000001fffcb43]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1
> from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x8ec/0x9fc
> [    0.000000] memblock_reserve: [0x0000001fffca80-0x0000001fffcac3]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] __memblock_free_early:
> [0x0000001fbe9a00-0x0000001fbea9ff] pcpu_embed_first_chunk+0x754/0x784
> [    0.000000] __memblock_free_early:
> [0x0000001fbe8a00-0x0000001fbe99ff] pcpu_embed_first_chunk+0x76c/0x784
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 130048
> [    0.000000] Kernel command line: root= rw console=ttyS0,115200
> earlyprintk debug log_buf_len=1M memblock=debug
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 1048576 bytes
> align=0x4 nid=-1 from=0x0 max_addr=0x0 setup_log_buf+0x110/0x1d0
> [    0.000000] memblock_reserve: [0x0000001fad0000-0x0000001fbcffff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] log_buf_len: 1048576 bytes
> [    0.000000] early log buf free: 7100(43%)
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 8192 bytes
> align=0x0 nid=-1 from=0x0 max_addr=0x0
> alloc_large_system_hash+0x14c/0x254
> [    0.000000] memblock_reserve: [0x0000001fbe8a00-0x0000001fbea9ff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 262144 bytes
> align=0x0 nid=-1 from=0x0 max_addr=0x0
> alloc_large_system_hash+0x14c/0x254
> [    0.000000] memblock_reserve: [0x0000001fa90000-0x0000001facffff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 131072 bytes
> align=0x0 nid=-1 from=0x0 max_addr=0x0
> alloc_large_system_hash+0x14c/0x254
> [    0.000000] memblock_reserve: [0x0000001fa70000-0x0000001fa8ffff]
> flags 0x0 memblock_virt_alloc_internal+0x120/0x15c
> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] BUG: Bad page state in process swapper  pfn:1a171
> [    0.000000] page:dff3ae20 count:0 mapcount:0 mapping:00400320 index:0x0
> [    0.000000] flags: 0x0()
> [    0.000000] page dumped because: non-NULL mapping
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.0 #87
> [    0.000000] Hardware name: Altera SOCFPGA
> [    0.000000] [<c001630c>] (unwind_backtrace) from [<c0012c74>]
> (show_stack+0x10/0x14)
> [    0.000000] [<c0012c74>] (show_stack) from [<c0484674>]
> (dump_stack+0x88/0x98)
> [    0.000000] [<c0484674>] (dump_stack) from [<c00bdf1c>] (bad_page+0xcc/0x11c)
> [    0.000000] [<c00bdf1c>] (bad_page) from [<c00be0d0>]
> (free_pages_prepare+0x164/0x2ac)
> [    0.000000] [<c00be0d0>] (free_pages_prepare) from [<c00bfcb8>]
> (__free_pages_ok+0x2c/0x358)
> [    0.000000] [<c00bfcb8>] (__free_pages_ok) from [<c060d244>]
> (free_all_bootmem+0x100/0x170)
> [    0.000000] [<c060d244>] (free_all_bootmem) from [<c05fe034>]
> (mem_init+0x104/0x2a0)
> [    0.000000] [<c05fe034>] (mem_init) from [<c05f8ac0>]
> (start_kernel+0x200/0x3b0)
> [    0.000000] [<c05f8ac0>] (start_kernel) from [<0000807c>] (0x807c)
> [    0.000000] Disabling lock debugging due to kernel taint
> [    0.000000] BUG: Bad page state in process swapper  pfn:1a579
> [    0.000000] page:dff42f20 count:0 mapcount:1464651863
> mapping:ffffffff index:0xb1f8ffff
> [    0.000000] flags: 0x0()
> [    0.000000] page dumped because: non-NULL mapping
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B           4.1.0 #87
> [    0.000000] Hardware name: Altera SOCFPGA
> [    0.000000] [<c001630c>] (unwind_backtrace) from [<c0012c74>]
> (show_stack+0x10/0x14)
> [    0.000000] [<c0012c74>] (show_stack) from [<c0484674>]
> (dump_stack+0x88/0x98)
> [    0.000000] [<c0484674>] (dump_stack) from [<c00bdf1c>] (bad_page+0xcc/0x11c)
> [    0.000000] [<c00bdf1c>] (bad_page) from [<c00be0d0>]
> (free_pages_prepare+0x164/0x2ac)
> [    0.000000] [<c00be0d0>] (free_pages_prepare) from [<c00bfcb8>]
> (__free_pages_ok+0x2c/0x358)
> [    0.000000] [<c00bfcb8>] (__free_pages_ok) from [<c060d244>]
> (free_all_bootmem+0x100/0x170)
> [    0.000000] [<c060d244>] (free_all_bootmem) from [<c05fe034>]
> (mem_init+0x104/0x2a0)
> [    0.000000] [<c05fe034>] (mem_init) from [<c05f8ac0>]
> (start_kernel+0x200/0x3b0)
> [    0.000000] [<c05f8ac0>] (start_kernel) from [<0000807c>] (0x807c)
> [    0.000000] BUG: Bad page state in process swapper  pfn:1a57a
> [    0.000000] page:dff42f40 count:0 mapcount:36968 mapping:  (null)
> index:0xa20a0000
> [    0.000000] flags:
> 0x8367a20a(error|uptodate|arch_1|writeback|tail|swapcache|mappedtodisk|reclaim|mlocked)
> [    0.000000] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [    0.000000] bad because of flags:
> [    0.000000] flags: 0x212000(writeback|swapcache|mlocked)
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B           4.1.0 #87
> [    0.000000] Hardware name: Altera SOCFPGA
> [    0.000000] [<c001630c>] (unwind_backtrace) from [<c0012c74>]
> (show_stack+0x10/0x14)
> [    0.000000] [<c0012c74>] (show_stack) from [<c0484674>]
> (dump_stack+0x88/0x98)
> [    0.000000] [<c0484674>] (dump_stack) from [<c00bdf1c>] (bad_page+0xcc/0x11c)
> [    0.000000] [<c00bdf1c>] (bad_page) from [<c00be0d0>]
> (free_pages_prepare+0x164/0x2ac)
> [    0.000000] [<c00be0d0>] (free_pages_prepare) from [<c00bfcb8>]
> (__free_pages_ok+0x2c/0x358)
> [    0.000000] [<c00bfcb8>] (__free_pages_ok) from [<c060d244>]
> (free_all_bootmem+0x100/0x170)
> [    0.000000] [<c060d244>] (free_all_bootmem) from [<c05fe034>]
> (mem_init+0x104/0x2a0)
> [    0.000000] [<c05fe034>] (mem_init) from [<c05f8ac0>]
> (start_kernel+0x200/0x3b0)
> [    0.000000] [<c05f8ac0>] (start_kernel) from [<0000807c>] (0x807c)
> [    0.000000] BUG: Bad page state in process swapper  pfn:1a57b
> [    0.000000] page:dff42f60 count:0 mapcount:0 mapping:  (null) index:0x0
> [    0.000000] flags:
> 0x70532850(dirty|active|private|writeback|swapcache|mappedtodisk|unevictable)
> [    0.000000] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [    0.000000] bad because of flags:
> [    0.000000] flags: 0x112840(active|private|writeback|swapcache|unevictable)
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B           4.1.0 #87
> [    0.000000] Hardware name: Altera SOCFPGA
> [    0.000000] [<c001630c>] (unwind_backtrace) from [<c0012c74>]
> (show_stack+0x10/0x14)
> [    0.000000] [<c0012c74>] (show_stack) from [<c0484674>]
> (dump_stack+0x88/0x98)
> [    0.000000] [<c0484674>] (dump_stack) from [<c00bdf1c>] (bad_page+0xcc/0x11c)
> [    0.000000] [<c00bdf1c>] (bad_page) from [<c00be0d0>]
> (free_pages_prepare+0x164/0x2ac)
> [    0.000000] [<c00be0d0>] (free_pages_prepare) from [<c00bfcb8>]
> (__free_pages_ok+0x2c/0x358)
> [    0.000000] [<c00bfcb8>] (__free_pages_ok) from [<c060d244>]
> (free_all_bootmem+0x100/0x170)
> [    0.000000] [<c060d244>] (free_all_bootmem) from [<c05fe034>]
> (mem_init+0x104/0x2a0)
> [    0.000000] [<c05fe034>] (mem_init) from [<c05f8ac0>]
> (start_kernel+0x200/0x3b0)
> [    0.000000] [<c05f8ac0>] (start_kernel) from [<0000807c>] (0x807c)
> [    0.000000] Memory: 500508K/524288K available (4749K kernel code,
> 283K rwdata, 1328K rodata, 3352K init, 127K bss, 15588K reserved, 0K
> cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc05f7804   (6079 kB)
> [    0.000000]       .init : 0xc05f8000 - 0xc093e000   (3352 kB)
> [    0.000000]       .data : 0xc093e000 - 0xc0984e48   ( 284 kB)
> [    0.000000]        .bss : 0xc0984e48 - 0xc09a4b6c   ( 128 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  Additional per-CPU info printed with stalls.
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
> [    0.000000] L2C-310: CACHE_ID 0x410030c9, AUX_CTRL 0x46060001
> [    0.000000] clocksource timer1: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604467 ns
> [    0.000006] sched_clock: 32 bits at 100MHz, resolution 10ns, wraps
> every 21474836475ns
> [    0.000129] Console: colour dummy device 80x30
> [    0.000145] Calibrating delay loop... 1836.64 BogoMIPS (lpj=9183232)
> [    0.059872] pid_max: default: 32768 minimum: 301
> [    0.059950] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.059959] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.060400] CPU: Testing write buffer coherency: ok
> [    0.060565] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.060644] Setting up static identity map for 0x8280 - 0x82d8
> [    0.119900] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.119957] Brought up 2 CPUs
> [    0.119970] SMP: Total of 2 processors activated (3679.84 BogoMIPS).
> [    0.119975] CPU: All CPU(s) started in SVC mode.
> [    0.120292] devtmpfs: initialized
> [    0.123483] VFP support v0.3: implementor 41 architecture 3 part 30
> variant 9 rev 4
> [    0.123715] clocksource jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.124781] NET: Registered protocol family 16
> [    0.125502] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.128999] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
> watchpoint registers.
> [    0.129010] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.161711] SCSI subsystem initialized
> [    0.161968] usbcore: registered new interface driver usbfs
> [    0.162027] usbcore: registered new interface driver hub
> [    0.162079] usbcore: registered new device driver usb
> [    0.162677] pps_core: LinuxPPS API ver. 1 registered
> [    0.162686] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    0.162714] PTP clock support registered
> [    0.163485] Switched to clocksource timer1
> [    0.189725] NET: Registered protocol family 2
> [    0.190253] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.190293] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.190350] TCP: Hash tables configured (established 4096 bind 4096)
> [    0.190403] UDP hash table entries: 256 (order: 1, 8192 bytes)
> [    0.190429] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
> [    0.190570] NET: Registered protocol family 1
> [    0.190869] RPC: Registered named UNIX socket transport module.
> [    0.190878] RPC: Registered udp transport module.
> [    0.190884] RPC: Registered tcp transport module.
> [    0.190889] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.209283] futex hash table entries: 512 (order: 3, 32768 bytes)
> [    0.218433] ntfs: driver 2.1.32 [Flags: R/W].
> [    0.225056] io scheduler noop registered (default)
> [    0.228675] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> [    0.229522] console [ttyS0] disabled
> [    0.229555] ffc02000.serial0: ttyS0 at MMIO 0xffc02000 (irq = 34,
> base_baud = 6250000) is a 16550A
> [    1.955216] console [ttyS0] enabled
> [    1.960676] brd: module loaded
> [    1.964207] CAN device driver interface
> [    1.968395] stmmac - user ID: 0x10, Synopsys ID: 0x37
> [    1.973423]  Ring mode enabled
> [    1.976511]  DMA HW capability register supported
> [    1.981022]  Enhanced/Alternate descriptors
> [    1.985388]  Enabled extended descriptors
> [    1.989379]  RX Checksum Offload Engine supported (type 2)
> [    1.994853]  TX Checksum insertion supported
> [    1.999103]  Enable RX Mitigation via HW Watchdog Timer
> [    2.012789] libphy: stmmac: probed
> [    2.016212] eth0: PHY ID 00221611 at 4 IRQ POLL (stmmac-0:04) active
> [    2.873586] dwc2 ffb40000.usb: DWC OTG Controller
> [    2.878294] dwc2 ffb40000.usb: new USB bus registered, assigned bus number 1
> [    2.885349] dwc2 ffb40000.usb: irq 36, io mem 0x00000000
> [    2.891255] hub 1-0:1.0: USB hub found
> [    2.895034] hub 1-0:1.0: 1 port detected
> [    2.899521] mousedev: PS/2 mouse device common for all mice
> [    2.905297] i2c /dev entries driver
> [    2.909298] Synopsys Designware Multimedia Card Interface Driver
> [    2.915519] dw_mmc ff704000.dwmmc0: IDMAC supports 32-bit address mode.
> [    2.922131] dw_mmc ff704000.dwmmc0: Using PIO mode.
> [    2.927007] dw_mmc ff704000.dwmmc0: Version ID is 240a
> [    2.932153] dw_mmc ff704000.dwmmc0: DW MMC controller at irq 30, 32
> bit host data width, 1024 deep fifo
> [    2.941637] dw_mmc ff704000.dwmmc0: Got CD GPIO
> [    2.983516] dw_mmc ff704000.dwmmc0: 1 slots initialized
> [    2.988968] usbcore: registered new interface driver usbhid
> [    2.994546] usbhid: USB HID core driver
> [    2.998510] oprofile: no performance counters
> [    3.002925] oprofile: using timer interrupt.
> [    3.008048] NET: Registered protocol family 10
> [    3.013296] sit: IPv6 over IPv4 tunneling driver
> [    3.018454] NET: Registered protocol family 17
> [    3.022912] NET: Registered protocol family 15
> [    3.027368] can: controller area network core (rev 20120528 abi 9)
> [    3.033582] NET: Registered protocol family 29
> [    3.038012] can: raw protocol (rev 20120528)
> [    3.042266] can: broadcast manager protocol (rev 20120528 t)
> [    3.047928] can: netlink gateway (rev 20130117) max_hops=1
> [    3.053578] 8021q: 802.1Q VLAN Support v1.8
> [    3.057860] ThumbEE CPU extension supported.
> [    3.062130] Registering SWP/SWPB emulation handler
> [    3.069415] ttyS0 - failed to request DMA
> [    3.075857] Freeing unused kernel memory: 3352K (c05f8000 - c093e000)
> Starting logging: OK
> Initializing random number generator... [    3.127024] mmc_host mmc0:
> Bus speed (slot 0) = 200000000Hz (slot req 50000000Hz, actual
> 50000000HZ div = 2)
> [    3.138973] mmc0: new high speed SDHC card at address 0007
> [    3.144975] mmcblk0: mmc0:0007 SD4GB 3.70 GiB
> [    3.147371] random: dd urandom read with 0 bits of entropy available
> done.
> [    3.157824]  mmcblk0: p1 p2 p3
> Starting network...
>
> Welcome to Buildroot
> buildroot login: [  276.153516] random: nonblocking pool is initialized
> root
> # cat /proc/cmdline
> root= rw console=ttyS0,115200 earlyprintk debug log_buf_len=1M memblock=debug
> ########
>
> Has anyone seen the issue?  What could be the problem?
>
> --Arun

When I was debugging I saw that multi_v7_defconfig don't
have the above issue. So I tried to enable(add) the options
that are set in 'multi_v7_defconfig' in 'socfpga_defconfig'.

Then found that enabe CONFIG_CMA and CONFIG_DMA_CMA;
problem is gone [This is verified by more than 100 cold boots].

Working and non working config diff:
#############
diff -ru .config /tmp/socfpga_defconfig_not_working
--- .config 2015-06-24 17:56:06.831176461 +0530
+++ /tmp/socfpga_defconfig_not_working 2015-06-24 18:27:17.563154911 +0530
@@ -466,7 +466,6 @@
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_HAVE_MEMBLOCK=y
 CONFIG_NO_BOOTMEM=y
-CONFIG_MEMORY_ISOLATION=y
 # CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
@@ -478,10 +477,7 @@
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 # CONFIG_CLEANCACHE is not set
 # CONFIG_FRONTSWAP is not set
-CONFIG_CMA=y
-# CONFIG_CMA_DEBUG is not set
-# CONFIG_CMA_DEBUGFS is not set
-CONFIG_CMA_AREAS=7
+# CONFIG_CMA is not set
 # CONFIG_ZPOOL is not set
 # CONFIG_ZBUD is not set
 # CONFIG_ZSMALLOC is not set
@@ -766,17 +762,6 @@
 CONFIG_REGMAP=y
 CONFIG_REGMAP_MMIO=y
 # CONFIG_DMA_SHARED_BUFFER is not set
-CONFIG_DMA_CMA=y
-
-#
-# Default contiguous memory area size:
-#
-CONFIG_CMA_SIZE_MBYTES=16
-CONFIG_CMA_SIZE_SEL_MBYTES=y
-# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
-# CONFIG_CMA_SIZE_SEL_MIN is not set
-# CONFIG_CMA_SIZE_SEL_MAX is not set
-CONFIG_CMA_ALIGNMENT=8

 #
 # Bus devices
##############

Pasted below is the working bootlog.
~~~~~~~~~~~~~~~~~~~
Starting kernel ...

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpuset
Linux version 4.1.0 (arun at arun-OptiPlex-9010) (gcc version 4.9.3
20141031 (prerelease) (Linaro GCC 2014.11) ) #199 SMP Wed Jun 24
17:57:41 IST 2015
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Altera SOCFPGA Cyclone V SoC Development Kit
memblock_reserve: [0x00000000008280-0x000000009a902b] flags 0x0
arm_memblock_init+0x28/0x19c
memblock_reserve: [0x00000000004000-0x00000000007fff] flags 0x0
arm_memblock_init+0x148/0x19c
memblock_reserve: [0x00000003ff9000-0x00000003fffc8f] flags 0x0
early_init_fdt_scan_reserved_mem+0x38/0x8c
memblock_reserve: [0x00000000000000-0x00000000000fff] flags 0x0
early_init_fdt_scan_reserved_mem+0x6c/0x8c
memblock_reserve: [0x0000001f000000-0x0000001fffffff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
cma: Reserved 16 MiB at 0x1f000000
MEMBLOCK configuration:
 memory size = 0x20000000 reserved size = 0x19aca3c
 memory.cnt  = 0x1
 memory[0x0]     [0x00000000000000-0x0000001fffffff], 0x20000000 bytes
flags: 0x0
 reserved.cnt  = 0x5
 reserved[0x0]   [0x00000000000000-0x00000000000fff], 0x1000 bytes flags: 0x0
 reserved[0x1]   [0x00000000004000-0x00000000007fff], 0x4000 bytes flags: 0x0
 reserved[0x2]   [0x00000000008280-0x000000009a902b], 0x9a0dac bytes flags: 0x0
 reserved[0x3]   [0x00000003ff9000-0x00000003fffc8f], 0x6c90 bytes flags: 0x0
 reserved[0x4]   [0x0000001f000000-0x0000001fffffff], 0x1000000 bytes flags: 0x0
Memory policy: Data cache writealloc
memblock_reserve: [0x0000001effffd8-0x0000001effffff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effe000-0x0000001effefff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effd000-0x0000001effdfff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effc000-0x0000001effcfff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effb000-0x0000001effbfff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effa000-0x0000001effafff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff9000-0x0000001eff9fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff8000-0x0000001eff8fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff7000-0x0000001eff7fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff4000-0x0000001eff5fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff6000-0x0000001eff6fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effffb0-0x0000001effffd7] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff3000-0x0000001eff3fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effff88-0x0000001effffaf] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff2000-0x0000001eff2fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff1000-0x0000001eff1fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001eff0000-0x0000001eff0fff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
On node 0 totalpages: 131072
memblock_virt_alloc_try_nid_nopanic: 4194304 bytes align=0x0 nid=0
from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.85+0x68/0x90
memblock_reserve: [0x0000001ebf0000-0x0000001efeffff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
free_area_init_node: node 0, pgdat c0983d40, node_mem_map debf0000
  Normal zone: 1024 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 131072 pages, LIFO batch:31
memblock_virt_alloc_try_nid_nopanic: 64 bytes align=0x0 nid=0 from=0x0
max_addr=0x0 free_area_init_node+0x290/0x310
memblock_reserve: [0x0000001effff40-0x0000001effff7f] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid_nopanic: 6144 bytes align=0x0 nid=0
from=0x0 max_addr=0x0 zone_wait_table_init+0x78/0xe4
memblock_reserve: [0x0000001ebee800-0x0000001ebeffff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 28 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 setup_arch+0x618/0x968
memblock_reserve: [0x0000001effff00-0x0000001effff1b] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_reserve: [0x0000001ebe2a18-0x0000001ebee7ff] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001effff20-0x0000001effff3c] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001efffee0-0x0000001efffefc] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001efffec4-0x0000001efffede] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001efffea8-0x0000001efffec2] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001efffe8c-0x0000001efffea5] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001efffe70-0x0000001efffe89] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001efffe54-0x0000001efffe6d] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_reserve: [0x0000001efffe38-0x0000001efffe51] flags 0x0
memblock_alloc_range_nid+0x38/0x4c
memblock_virt_alloc_try_nid: 78 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 start_kernel+0xd0/0x3b0
memblock_reserve: [0x0000001efffdc0-0x0000001efffe0d] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 78 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 start_kernel+0xf4/0x3b0
memblock_reserve: [0x0000001efffd40-0x0000001efffd8d] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 78 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 start_kernel+0x118/0x3b0
memblock_reserve: [0x0000001efffcc0-0x0000001efffd0d] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x4c/0x88
memblock_reserve: [0x0000001ebe1a00-0x0000001ebe29ff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_embed_first_chunk+0x4d8/0x784
memblock_reserve: [0x0000001ebe0a00-0x0000001ebe19ff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid_nopanic: 98304 bytes align=0x1000 nid=-1
from=0x3fffffff max_addr=0x0 pcpu_dfl_fc_alloc+0x24/0x2c
memblock_reserve: [0x0000001ebc8000-0x0000001ebdffff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
__memblock_free_early: [0x0000001ebd4000-0x0000001ebd3fff]
pcpu_embed_first_chunk+0x624/0x784
__memblock_free_early: [0x0000001ebe0000-0x0000001ebdffff]
pcpu_embed_first_chunk+0x624/0x784
PERCPU: Embedded 12 pages/cpu @debc8000 s19648 r8192 d21312 u49152
memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 pcpu_setup_first_chunk+0x324/0x9fc
memblock_reserve: [0x0000001effff80-0x0000001effff83] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 pcpu_setup_first_chunk+0x344/0x9fc
memblock_reserve: [0x0000001efffc80-0x0000001efffc83] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 pcpu_setup_first_chunk+0x364/0x9fc
memblock_reserve: [0x0000001efffc40-0x0000001efffc47] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 pcpu_setup_first_chunk+0x384/0x9fc
memblock_reserve: [0x0000001efffc00-0x0000001efffc07] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
pcpu-alloc: s19648 r8192 d21312 u49152 alloc=12*4096
pcpu-alloc: [0] 0 [0] 1
memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 pcpu_setup_first_chunk+0x760/0x9fc
memblock_reserve: [0x0000001efffb80-0x0000001efffbf7] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 pcpu_setup_first_chunk+0x7a8/0x9fc
memblock_reserve: [0x0000001efffb00-0x0000001efffb43] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1 from=0x0
max_addr=0x0 pcpu_setup_first_chunk+0x8ec/0x9fc
memblock_reserve: [0x0000001efffa80-0x0000001efffac3] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
__memblock_free_early: [0x0000001ebe1a00-0x0000001ebe29ff]
pcpu_embed_first_chunk+0x754/0x784
__memblock_free_early: [0x0000001ebe0a00-0x0000001ebe19ff]
pcpu_embed_first_chunk+0x76c/0x784
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root= rw console=ttyS0,115200 earlyprintk debug
log_buf_len=1M memblock=debug
memblock_virt_alloc_try_nid_nopanic: 1048576 bytes align=0x4 nid=-1
from=0x0 max_addr=0x0 setup_log_buf+0x110/0x1d0
memblock_reserve: [0x0000001eac8000-0x0000001ebc7fff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
log_buf_len: 1048576 bytes
early log buf free: 5792(35%)
memblock_virt_alloc_try_nid_nopanic: 8192 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 alloc_large_system_hash+0x14c/0x254
memblock_reserve: [0x0000001ebe0a00-0x0000001ebe29ff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
PID hash table entries: 2048 (order: 1, 8192 bytes)
memblock_virt_alloc_try_nid_nopanic: 262144 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 alloc_large_system_hash+0x14c/0x254
memblock_reserve: [0x0000001ea88000-0x0000001eac7fff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
memblock_virt_alloc_try_nid_nopanic: 131072 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 alloc_large_system_hash+0x14c/0x254
memblock_reserve: [0x0000001ea68000-0x0000001ea87fff] flags 0x0
memblock_virt_alloc_internal+0x120/0x15c
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 492264K/524288K available (4757K kernel code, 284K rwdata,
1332K rodata, 3356K init, 127K bss, 15640K reserved, 16384K
cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc05fa8ec   (6091 kB)
      .init : 0xc05fb000 - 0xc0942000   (3356 kB)
      .data : 0xc0942000 - 0xc09891d0   ( 285 kB)
       .bss : 0xc09891d0 - 0xc09a902c   ( 128 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
 Additional per-CPU info printed with stalls.
NR_IRQS:16 nr_irqs:16 16
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 8 ways, 512 kB
L2C-310: CACHE_ID 0x410030c9, AUX_CTRL 0x46060001
clocksource timer1: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604467 ns
sched_clock: 32 bits at 100MHz, resolution 10ns, wraps every 21474836475ns
Console: colour dummy device 80x30
Calibrating delay loop... 1836.64 BogoMIPS (lpj=9183232)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x8280 - 0x82d8
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
Brought up 2 CPUs
SMP: Total of 2 processors activated (3679.84 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
Switched to clocksource timer1
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 512 (order: 3, 32768 bytes)
ntfs: driver 2.1.32 [Flags: R/W].
io scheduler noop registered (default)
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
console [ttyS0] disabled
ffc02000.serial0: ttyS0 at MMIO 0xffc02000 (irq = 34, base_baud =
6250000) is a 16550A
console [ttyS0] enabled
brd: module loaded
CAN device driver interface
stmmac - user ID: 0x10, Synopsys ID: 0x37
 Ring mode enabled
 DMA HW capability register supported
 Enhanced/Alternate descriptors
 Enabled extended descriptors
 RX Checksum Offload Engine supported (type 2)
 TX Checksum insertion supported
 Enable RX Mitigation via HW Watchdog Timer
libphy: stmmac: probed
eth0: PHY ID 00221611 at 4 IRQ POLL (stmmac-0:04) active
dwc2 ffb40000.usb: DWC OTG Controller
dwc2 ffb40000.usb: new USB bus registered, assigned bus number 1
dwc2 ffb40000.usb: irq 36, io mem 0x00000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
Synopsys Designware Multimedia Card Interface Driver
dw_mmc ff704000.dwmmc0: IDMAC supports 32-bit address mode.
dw_mmc ff704000.dwmmc0: Using PIO mode.
dw_mmc ff704000.dwmmc0: Version ID is 240a
dw_mmc ff704000.dwmmc0: DW MMC controller at irq 30, 32 bit host data
width, 1024 deep fifo
dw_mmc ff704000.dwmmc0: Got CD GPIO
dw_mmc ff704000.dwmmc0: 1 slots initialized
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: no performance counters
oprofile: using timer interrupt.
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
can: controller area network core (rev 20120528 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20120528)
can: broadcast manager protocol (rev 20120528 t)
can: netlink gateway (rev 20130117) max_hops=1
8021q: 802.1Q VLAN Support v1.8
ThumbEE CPU extension supported.
Registering SWP/SWPB emulation handler
ttyS0 - failed to request DMA
Freeing unused kernel memory: 3356K (c05fb000 - c0942000)
Starting logging: [    2.786837] mmc_host mmc0: Bus speed (slot 0) =
200000000Hz (slot req 50000000Hz, actual 50000000HZ div = 2)
OK
mmc0: new high speed SDHC card at address 0007
ndom number generator... [    2.804841] mmcblk0: mmc0:0007 SD4GB 3.70 GiB
 mmcblk0: p1 p2 p3
random: dd urandom read with 0 bits of entropy available
done.
Starting network...

Welcome to Buildroot
buildroot login:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Does this mean that my problem is not similar(faulty RAM)
to the one described here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/276373.html

--Arun
