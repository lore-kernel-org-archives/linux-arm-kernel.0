From: yad.naveen@gmail.com (naveen yadav)
Date: Thu, 25 Aug 2011 11:36:04 +0530
Subject: Kernel panic in 2.6.35.12 kernel
In-Reply-To: <CAJ8eaTyeQj5_EAsCFDMmDs3faiVptuccmq3VJLjG-QnYG038=A@mail.gmail.com>
References: <CAJ8eaTyeQj5_EAsCFDMmDs3faiVptuccmq3VJLjG-QnYG038=A@mail.gmail.com>
Message-ID: <CAJ8eaTw=dKUNE8h-HD7RWxXHcTEuxJH4AfcOO44RSF7QdC5arQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am paste only small crash log due to size problem.




> Hi All,
>
> We are running one malloc testprogram using below script.
>
> while true
> do
> ./stress &
> sleep 1
> done
>
>
>
>
> After 10-15 min we observe following crash in kernel
>
>
> ?Kernel panic - not syncing: Out of memory and no killable processes...
>
> attaching log also.
>
> Thanks
>
-------------- next part --------------

message_alloc  
message_alloc Thread 1 
message_alloc Thread 1 
message_alloc Thread 1 
oom_kill_process: 1 callbacks suppressed
stress invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:00000c2c r4:d6c78000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:00000c2c r4:d71e22e0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000c2c r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  30
active_anon:89656 inactive_anon:705 isolated_anon:0
 active_file:17 inactive_file:2 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:587 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:1 shmem:5 pagetables:233 bounce:0
Normal free:2348kB min:2456kB low:3068kB high:3684kB active_anon:358624kB inactive_anon:2820kB active_file:68kB inactive_file:8kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:4kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:336kB pagetables:932kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:132 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 5*4kB 5*8kB 15*16kB 12*32kB 10*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2348kB
24 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
704 free pages
1934 reserved pages
521 slab pages
23 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[   42]     0    42      374       16   0       0 sh
[  981]     0   981      373       10   0       0 sh
[ 1034]     0  1034    45809    44091   0       0 stress
[ 1038]     0  1038     1734       26   0       0 stress
[ 1042]     0  1042     2759     1051   0       0 stress
[ 1046]     0  1046     1734       26   0       0 stress
[ 1050]     0  1050    46578    45125   0       0 stress
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 981 (sh) score 3116 or a child
Killed process 1034 (stress) vsz:183236kB, anon-rss:176360kB, file-rss:4kB
##### send signal from KERNEL, SIG : 9, stress, PID:1034, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:cee665c0 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952c8>] (T.314+0xac/0xe8)
 r7:000201da r6:d71e23c8 r5:cee665c0 r4:d71e22e0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000c2c r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
stress invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:00000b5f r4:d6c78000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:00000b5f r4:d6bf1cc0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000b5f r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  30
active_anon:89560 inactive_anon:801 isolated_anon:0
 active_file:17 inactive_file:2 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:587 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:1 shmem:5 pagetables:233 bounce:0
Normal free:2348kB min:2456kB low:3068kB high:3684kB active_anon:358240kB inactive_anon:3204kB active_file:68kB inactive_file:8kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:4kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:336kB pagetables:932kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:228 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 5*4kB 5*8kB 15*16kB 12*32kB 10*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2348kB
24 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
704 free pages
1934 reserved pages
521 slab pages
23 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[   42]     0    42      374       16   0       0 sh
[  981]     0   981      373       10   0       0 sh
[ 1038]     0  1038     1734       26   0       0 stress
[ 1042]     0  1042     2759     1051   0       0 stress
[ 1046]     0  1046     1734       26   0       0 stress
[ 1050]     0  1050    46578    45125   0       0 stress
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 1050 (stress) score 2911 or a child
Killed process 1050 (stress) vsz:186312kB, anon-rss:180496kB, file-rss:4kB
##### send signal from KERNEL, SIG : 9, stress, PID:1050, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:d6bf1cc0 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952f4>] (T.314+0xd8/0xe8)
 r7:000201da r6:d6bf1da8 r5:d6bf1cb8 r4:d6bf1cc0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000b5f r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
stress invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:000000e5 r4:d6c78000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:000000e5 r4:d71e22e0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:000000e5 r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  30
active_anon:89560 inactive_anon:801 isolated_anon:0
 active_file:17 inactive_file:2 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:587 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:1 shmem:5 pagetables:233 bounce:0
Normal free:2348kB min:2456kB low:3068kB high:3684kB active_anon:358240kB inactive_anon:3204kB active_file:68kB inactive_file:8kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:4kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:336kB pagetables:932kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:228 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 5*4kB 5*8kB 15*16kB 12*32kB 10*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2348kB
24 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
704 free pages
1934 reserved pages
521 slab pages
23 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[   42]     0    42      374       16   0       0 sh
[  981]     0   981      373       10   0       0 sh
[ 1038]     0  1038     1734       26   0       0 stress
[ 1042]     0  1042     2759     1051   0       0 stress
[ 1046]     0  1046     1734       26   0       0 stress
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 981 (sh) score 229 or a child
Killed process 1038 (stress) vsz:6936kB, anon-rss:100kB, file-rss:4kB
##### send signal from KERNEL, SIG : 9, stress, PID:1038, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:cee66b80 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952c8>] (T.314+0xac/0xe8)
 r7:000201da r6:d71e23c8 r5:cee66b80 r4:d71e22e0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:000000e5 r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
stress invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:000000af r4:d6c78000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:000000af r4:d71e22e0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:000000af r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  30
active_anon:89496 inactive_anon:865 isolated_anon:0
 active_file:17 inactive_file:2 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:587 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:1 shmem:5 pagetables:233 bounce:0
Normal free:2348kB min:2456kB low:3068kB high:3684kB active_anon:357984kB inactive_anon:3460kB active_file:68kB inactive_file:8kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:4kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:336kB pagetables:932kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:292 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 5*4kB 5*8kB 15*16kB 12*32kB 10*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2348kB
24 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
704 free pages
1934 reserved pages
521 slab pages
23 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[   42]     0    42      374       16   0       0 sh
[  981]     0   981      373       10   0       0 sh
[ 1042]     0  1042     2759     1051   0       0 stress
[ 1046]     0  1046     1734       26   0       0 stress
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 981 (sh) score 175 or a child
Killed process 1042 (stress) vsz:11036kB, anon-rss:4200kB, file-rss:4kB
##### send signal from KERNEL, SIG : 9, stress, PID:1042, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:d6bf1420 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952c8>] (T.314+0xac/0xe8)
 r7:000201da r6:d71e23c8 r5:d6bf1420 r4:d71e22e0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:000000af r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
stress invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:0000006c r4:d6c78000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:0000006c r4:d6bf1700
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:0000006c r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  30
active_anon:89464 inactive_anon:897 isolated_anon:0
 active_file:17 inactive_file:2 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:587 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:1 shmem:5 pagetables:233 bounce:0
Normal free:2348kB min:2456kB low:3068kB high:3684kB active_anon:357856kB inactive_anon:3588kB active_file:68kB inactive_file:8kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:4kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:336kB pagetables:932kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:324 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 5*4kB 5*8kB 15*16kB 12*32kB 10*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2348kB
24 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
704 free pages
1934 reserved pages
521 slab pages
23 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[   42]     0    42      374       16   0       0 sh
[  981]     0   981      373       10   0       0 sh
[ 1046]     0  1046     1734       26   0       0 stress
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 1046 (stress) score 108 or a child
Killed process 1046 (stress) vsz:6936kB, anon-rss:100kB, file-rss:4kB
##### send signal from KERNEL, SIG : 9, stress, PID:1046, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:d6bf1700 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952f4>] (T.314+0xd8/0xe8)
 r7:000201da r6:d6bf17e8 r5:d6bf16f8 r4:d6bf1700
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:0000006c r6:d6c78000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6c78000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6c79fb0 to 0xd6c79ff8)
9fa0:                                     00000000 401ffe50 402024f4 00000000
9fc0: 00000000 00000000 401ffd50 000000a2 401ffe50 00000001 7fffffff 401ffcc4
9fe0: 00000000 401ffcb8 41bf2884 41bb1db4 80000010 ffffffff 00000000
 r7:000000a2 r6:401ffd50 r5:00000000 r4:ffffffff
sleep invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:00000023 r4:d6ce8000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:00000023 r4:d71e28a0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000023 r6:d6ce8000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6ce8000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6ce9fb0 to 0xd6ce9ff8)
9fa0:                                     00000000 becfe7c0 00000000 00000000
9fc0: 00000000 00000000 becfe6c0 000000a2 becfe7c0 00000001 7fffffff becfe634
9fe0: becfe740 becfe630 000a2168 00008dbc 40000010 ffffffff 00000000
 r7:000000a2 r6:becfe6c0 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  29
active_anon:89368 inactive_anon:993 isolated_anon:0
 active_file:17 inactive_file:3 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:587 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:1 shmem:5 pagetables:233 bounce:0
Normal free:2348kB min:2456kB low:3068kB high:3684kB active_anon:357472kB inactive_anon:3972kB active_file:68kB inactive_file:12kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:4kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:336kB pagetables:932kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:420 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 5*4kB 5*8kB 15*16kB 12*32kB 10*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2348kB
25 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
703 free pages
1934 reserved pages
521 slab pages
24 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[   42]     0    42      374       16   0       0 sh
[  981]     0   981      373       10   0       0 sh
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 42 (sh) score 35 or a child
Killed process 981 (sh) vsz:1492kB, anon-rss:40kB, file-rss:0kB
##### send signal from KERNEL, SIG : 9, sh, PID:981, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:d71e22e0 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952c8>] (T.314+0xac/0xe8)
 r7:000201da r6:d71e2988 r5:d71e22e0 r4:d71e28a0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000023 r6:d6ce8000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6ce8000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6ce9fb0 to 0xd6ce9ff8)
9fa0:                                     00000000 becfe7c0 00000000 00000000
9fc0: 00000000 00000000 becfe6c0 000000a2 becfe7c0 00000001 7fffffff becfe634
9fe0: becfe740 becfe630 000a2168 00008dbc 40000010 ffffffff 00000000
 r7:000000a2 r6:becfe6c0 r5:00000000 r4:ffffffff
sleep invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:00000017 r4:d6ce8000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:00000017 r4:d71e28a0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000017 r6:d6ce8000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6ce8000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6ce9fb0 to 0xd6ce9ff8)
9fa0:                                     00000000 becfe7c0 00000000 00000000
9fc0: 00000000 00000000 becfe6c0 000000a2 becfe7c0 00000001 7fffffff becfe634
9fe0: becfe740 becfe630 000a2168 00008dbc 40000010 ffffffff 00000000
 r7:000000a2 r6:becfe6c0 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  30
active_anon:89208 inactive_anon:1143 isolated_anon:0
 active_file:17 inactive_file:4 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:603 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:1 shmem:5 pagetables:231 bounce:0
Normal free:2412kB min:2456kB low:3068kB high:3684kB active_anon:356832kB inactive_anon:4572kB active_file:68kB inactive_file:16kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:4kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:328kB pagetables:924kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 7*4kB 6*8kB 16*16kB 13*32kB 10*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2412kB
26 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
716 free pages
1934 reserved pages
521 slab pages
25 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[   42]     0    42      374       16   0       0 sh
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 42 (sh) score 23 or a child
Killed process 42 (sh) vsz:1496kB, anon-rss:64kB, file-rss:0kB
##### send signal from KERNEL, SIG : 9, sh, PID:42, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:d71e28a0 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952f4>] (T.314+0xd8/0xe8)
 r7:000201da r6:d71e2988 r5:d71e2898 r4:d71e28a0
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000017 r6:d6ce8000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d6ce8000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd6ce9fb0 to 0xd6ce9ff8)
9fa0:                                     00000000 becfe7c0 00000000 00000000
9fc0: 00000000 00000000 becfe6c0 000000a2 becfe7c0 00000001 7fffffff becfe634
9fe0: becfe740 becfe630 000a2168 00008dbc 40000010 ffffffff 00000000
 r7:000000a2 r6:becfe6c0 r5:00000000 r4:ffffffff

init invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:00000017 r4:d7138000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c009525c>] (T.314+0x40/0xe8)
 r6:00000000 r5:00000017 r4:d6bf0000
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000017 r6:d7138000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d7138000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd7139fb0 to 0xd7139ff8)
9fa0:                                     0000002a 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000072 ffffffff 00000000 00000000 00000000
9fe0: bedc1bb0 bedc1c40 0005f770 000a1f60 60000010 ffffffff ffffffff
 r7:00000072 r6:00000000 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  79
active_anon:87064 inactive_anon:3271 isolated_anon:0
 active_file:19 inactive_file:3 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:576 slab_reclaimable:73 slab_unreclaimable:1159
 mapped:0 shmem:5 pagetables:228 bounce:0
Normal free:2304kB min:2456kB low:3068kB high:3684kB active_anon:348256kB inactive_anon:13084kB active_file:76kB inactive_file:12kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:20kB slab_reclaimable:292kB slab_unreclaimable:4636kB kernel_stack:328kB pagetables:912kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:471 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 8*4kB 6*8kB 17*16kB 13*32kB 10*64kB 7*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2304kB
27 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
735 free pages
1934 reserved pages
521 slab pages
23 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
[ 1051]     0  1051      373        8   0       0 sleep
Out of memory: kill process 1051 (sleep) score 23 or a child
Killed process 1051 (sleep) vsz:1492kB, anon-rss:32kB, file-rss:0kB
##### send signal from KERNEL, SIG : 9, sleep, PID:1051, force_sig_info 
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:00000009 r4:d6bf0000 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c00525dc>] (force_sig_info+0x3c/0x13c)
[<c00525a0>] (force_sig_info+0x0/0x13c) from [<c00526f4>] (force_sig+0x18/0x1c)
[<c00526dc>] (force_sig+0x0/0x1c) from [<c0095088>] (oom_kill_task+0x138/0x15c)
[<c0094f50>] (oom_kill_task+0x0/0x15c) from [<c00952f4>] (T.314+0xd8/0xe8)
 r7:000201da r6:d6bf00e8 r5:d6befff8 r4:d6bf0000
[<c009521c>] (T.314+0x0/0xe8) from [<c0095488>] (__out_of_memory+0x184/0x1a8)
 r7:00000017 r6:d7138000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d7138000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd7139fb0 to 0xd7139ff8)
9fa0:                                     0000002a 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000072 ffffffff 00000000 00000000 00000000
9fe0: bedc1bb0 bedc1c40 0005f770 000a1f60 60000010 ffffffff ffffffff
 r7:00000072 r6:00000000 r5:00000000 r4:ffffffff
init invoked oom-killer: gfp_mask=0x201da, order=0, oom_adj=0
Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:d7138000 r5:000201da r4:d7138000 r3:00000000
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c009511c>] (T.316+0x70/0x170)
[<c00950ac>] (T.316+0x0/0x170) from [<c0095464>] (__out_of_memory+0x160/0x1a8)
 r6:d7138000 r5:000201da r4:00000000
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d7138000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd7139fb0 to 0xd7139ff8)
9fa0:                                     0000002a 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000072 ffffffff 00000000 00000000 00000000
9fe0: bedc1bb0 bedc1c40 0005f770 000a1f60 60000010 ffffffff ffffffff
 r7:00000072 r6:00000000 r5:00000000 r4:ffffffff
Mem-info:
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:  47
active_anon:86040 inactive_anon:4287 isolated_anon:0
 active_file:11 inactive_file:35 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:599 slab_reclaimable:74 slab_unreclaimable:1159
 mapped:0 shmem:5 pagetables:226 bounce:0
Normal free:2396kB min:2456kB low:3068kB high:3684kB active_anon:344032kB inactive_anon:17276kB active_file:44kB inactive_file:140kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:378096kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:20kB slab_reclaimable:296kB slab_unreclaimable:4636kB kernel_stack:320kB pagetables:904kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:1056 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 280*4kB 237*8kB 145*16kB 118*32kB 88*64kB 24*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 18584kB
114 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
96000 pages of RAM
32518 free pages
1934 reserved pages
521 slab pages
45 pages shared
0 pages swap cached
[ pid ]   uid  tgid total_vm      rss cpu oom_adj name
[    1]     0     1      373        8   0       0 init
Kernel panic - not syncing: Out of memory and no killable processes...

Backtrace: 
[<c0023000>] (dump_backtrace+0x0/0x110) from [<c02f6270>] (dump_stack+0x18/0x1c)
 r6:d7138000 r5:000201da r4:c03f1308 r3:00000002
[<c02f6258>] (dump_stack+0x0/0x1c) from [<c02f62e0>] (panic+0x6c/0xec)
[<c02f6274>] (panic+0x0/0xec) from [<c009546c>] (__out_of_memory+0x168/0x1a8)
 r3:c03dcf18 r2:00000000 r1:00000001 r0:c0397459
[<c0095304>] (__out_of_memory+0x0/0x1a8) from [<c009558c>] (out_of_memory+0xe0/0x14c)
[<c00954ac>] (out_of_memory+0x0/0x14c) from [<c009879c>] (__alloc_pages_nodemask+0x534/0x61c)
 r6:d7138000 r5:c03ef8f8 r4:000201da
[<c0098268>] (__alloc_pages_nodemask+0x0/0x61c) from [<c0092c58>] (filemap_fault+0x340/0x41c)
[<c0092918>] (filemap_fault+0x0/0x41c) from [<c00a754c>] (__do_fault+0x58/0x45c)
[<c00a74f4>] (__do_fault+0x0/0x45c) from [<c00a8ad4>] (handle_mm_fault+0x364/0x7e8)
[<c00a8770>] (handle_mm_fault+0x0/0x7e8) from [<c0025f90>] (do_page_fault+0xf8/0x1e8)
[<c0025e98>] (do_page_fault+0x0/0x1e8) from [<c001e230>] (do_PrefetchAbort+0x3c/0xa0)
[<c001e1f4>] (do_PrefetchAbort+0x0/0xa0) from [<c001ef24>] (ret_from_exception+0x0/0x10)
Exception stack(0xd7139fb0 to 0xd7139ff8)
9fa0:                                     0000002a 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000072 ffffffff 00000000 00000000 00000000
9fe0: bedc1bb0 bedc1c40 0005f770 000a1f60 60000010 ffffffff ffffffff
 r7:00000072 r6:00000000 r5:00000000 r4:ffffffff
