From: zql@glomationinc.com (zql at glomationinc.com)
Date: Tue, 25 Aug 2009 16:05:12 -0500 (CDT)
Subject: Kernel bug or hardware problem 
Message-ID: <58554.72.76.4.145.1251234312.squirrel@webmail.hostgator.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atmel 9G20 based custom board with 32MB SDRAM.  Experiencing "random"
segmentation faults.  The following is an example,

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c1edc000
[00000000] *pgd=21ddc031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27.4 #4)
PC is at __bug+0x20/0x2c
LR is at check_preempt_wakeup+0x118/0x130
pc : [<c002dc38>]    lr : [<c003ca3c>]    psr: 60000093
sp : c1eb7ba8  ip : c0356690  fp : c1eb7bb4
r10: 00000032  r9 : 00000050  r8 : c1cd53c0
r7 : c1cf03f0  r6 : c1caa000  r5 : c1cf03e0  r4 : c1cf03e8
r3 : 00000000  r2 : 60000093  r1 : 00000001  r0 : 00000021
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 21edc000  DAC: 00000015
Process wget (pid: 476, stack limit = 0xc1eb6268)
Stack: (0xc1eb7ba8 to 0xc1eb8000)
7ba0:                   c1eb7bf4 c1eb7bb8 c0080be8 c002dc28 c00a5cc4 00000050
7bc0: 00000050 00000000 00000000 40000013 00000000 c1cd53c0 00000050 c0377c7c
7be0: 00001000 c18523c8 c1eb7c14 c1eb7bf8 c0080a80 c0080ac8 c1859710 00000000
7c00: c0377c78 c03573d0 c1eb7c3c c1eb7c18 c00da3cc c0080a40 c1859710 c1859710
7c20: c1859710 c18523c8 c1dd45c0 00000000 c1eb7c64 c1eb7c40 c00d7338 c00da3a0
7c40: c18540e8 c1859710 c1859710 c18523c8 000002a9 00000000 c1eb7c8c c1eb7c68
7c60: c00c8314 c00d7308 c00c8e7c 000002a9 01fa2000 c1859710 00001000 c1859710
7c80: c1eb7cbc c1eb7c90 c00c7498 c00c8308 c1eb7d04 000002a9 000002a9 01fa2000
7ca0: 00000000 c18540e8 c1cdece0 c0398b40 c1eb7d04 c1eb7cc0 c00ca078 c00c7430
7cc0: 00000000 c00c82f8 00000000 c1eb6000 c1854180 c18523c8 000002a9 000002a9
7ce0: 000002a9 01fa2000 00000000 c1eb6000 c1eb7d50 00000000 c1eb7d94 c1eb7d08
7d00: c0065818 c00ca000 000002a9 000002a9 c0398b40 c0097ddc c1854180 c1eb7e90
7d20: c1cdece0 c1854180 c02a2884 c18540e8 000002f7 00001000 00000000 c02a2884
7d40: 00000241 0989298b c009b454 c1eb7d68 c1eb7f20 00000001 000002f7 000002a9
7d60: c0097ddc c0398b40 00000241 c1854154 c18540e8 01fa1d09 00000000 c18540e8
7d80: 00000000 000005a0 c1eb7e1c c1eb7d98 c0066318 c0065698 01fa1d09 00000000
7da0: c1eb7ee0 000005a0 00000000 c1eb6000 c0374a68 c1eb7ee0 c1eb7f20 c1eb7e90
7dc0: c1eb7dfc c036b860 c1cdece0 c1854180 00000000 00000001 c1eb6000 fffffdee
7de0: c1eb7e1c c1eb7df0 c020c2c4 000005a0 00000000 c1854154 c18540e8 c1eb7e90
7e00: c1eb7f20 01fa1d09 00000000 00000001 c1eb7e5c c1eb7e20 c00663e0 c0065f10
7e20: 00000000 6221bca6 c1cdece0 c1854180 ee6b2800 01fa1d09 00000000 c18540e8
7e40: c1cdece0 c1eb7f78 c1eb6000 fffffdee c1eb7e84 c1eb7e60 c00c6390 c0066378
7e60: 01fa1d09 00000000 c1eb7e90 c1cdece0 c1eb7e90 c1eb7f20 c1eb7f4c c1eb7e88
7e80: c0083d8c c00c6378 01fa1d09 00000000 47cb50de 00000406 00000000 00000001
7ea0: ffffffff c1cdece0 00000000 00000000 00000000 00000000 c1de3060 c1eb7f75
7ec0: 00000000 00000000 79999999 c1de3060 c00529ac c1eb7ed4 c1eb7ed4 00000000
7ee0: 01fa1d09 00000000 c1eb7f2c c1eb7ef8 c003670c c0035c10 000005a0 00000000
7f00: 00000000 29800000 37b14735 4071f2d4 00000000 00000000 c1eb6120 00000000
7f20: 4001e000 000005a0 c1cdece0 4001e000 c1eb7f78 000005a0 c002a40c 00900004
7f40: c1eb7f74 c1eb7f50 c0084678 c0083ce0 00000007 00000002 01fa1d09 00000000
7f60: c1cdece0 00000004 c1eb7fa4 c1eb7f78 c0084b30 c00845d0 01fa1d09 00000000
7f80: ee00f180 00000000 00000100 000005a0 4001e000 0004de88 00000000 c1eb7fa8
7fa0: c0029be0 c0084afc 000005a0 4001e000 00000004 4001e000 000005a0 00000000
7fc0: 000005a0 4001e000 0004de88 000005a0 000005a0 00000000 0004c720 beec9778
7fe0: 00000000 beec96e8 4021db28 4026d2a4 60000010 00000004 00000000 00000000
Backtrace:
[<c002dc18>] (__bug+0x0/0x2c) from [<c0080be8>]
(cache_alloc_refill+0x130/0x580)
[<c0080ab8>] (cache_alloc_refill+0x0/0x580) from [<c0080a80>]
(kmem_cache_alloc)
[<c0080a30>] (kmem_cache_alloc+0x0/0x88) from [<c00da3cc>]
(journal_add_journal)
 r7:c03573d0 r6:c0377c78 r5:00000000 r4:c1859710
[<c00da390>] (journal_add_journal_head+0x0/0x170) from [<c00d7338>]
(journal_di)
 r8:00000000 r7:c1dd45c0 r6:c18523c8 r5:c1859710 r4:c1859710
[<c00d72f8>] (journal_dirty_data+0x0/0x170) from [<c00c8314>]
(ext3_journal_dir)
 r8:00000000 r7:000002a9 r6:c18523c8 r5:c1859710 r4:c1859710
[<c00c82f8>] (ext3_journal_dirty_data+0x0/0x4c) from [<c00c7498>]
(walk_page_bu)
 r6:c1859710 r5:00001000 r4:c1859710
[<c00c7420>] (walk_page_buffers+0x0/0xac) from [<c00ca078>]
(ext3_ordered_write)
[<c00c9ff0>] (ext3_ordered_write_end+0x0/0x12c) from [<c0065818>]
(generic_file)
[<c0065688>] (generic_file_buffered_write+0x0/0x634) from [<c0066318>]
(__gener)
[<c0065f00>] (__generic_file_aio_write_nolock+0x0/0x468) from [<c00663e0>]
(gen)
[<c0066368>] (generic_file_aio_write+0x0/0xf4) from [<c00c6390>]
(ext3_file_wri)
[<c00c6368>] (ext3_file_write+0x0/0xa8) from [<c0083d8c>]
(do_sync_write+0xbc/0)
 r7:c1eb7f20 r6:c1eb7e90 r5:c1cdece0 r4:c1eb7e90
[<c0083cd0>] (do_sync_write+0x0/0x10c) from [<c0084678>]
(vfs_write+0xb8/0x148)
[<c00845c0>] (vfs_write+0x0/0x148) from [<c0084b30>] (sys_write+0x44/0x70)
 r7:00000004 r6:c1cdece0 r5:00000000 r4:01fa1d09
[<c0084aec>] (sys_write+0x0/0x70) from [<c0029be0>]
(ret_fast_syscall+0x0/0x2c)
 r6:0004de88 r5:4001e000 r4:000005a0
Code: e1a01000 e59f000c eb0048bd e3a03000 (e5833000)
---[ end trace 1880fb840361b0a2 ]---
Segmentation fault


Any pointers would be very much appreciated.

ZL
