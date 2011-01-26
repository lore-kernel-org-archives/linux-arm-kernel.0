From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 26 Jan 2011 22:46:00 +0200
Subject: PXA270 overlay problem
Message-ID: <201101262246.01164.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I'm experiencing problems with overlay1/overlay2 on PXA270 using pxafb 
driver. Main problem is overlays just don't work for some reason, and even 
more - after enabling any overlay something weird happens (LCD blinks for a 
0.5 second, and then main plane comes back, no overlay plane is visible), I'm 
getting following messages on dmesg:

[   93.679574] overlay1fb_disable: timeout disabling overlay1
[   95.601537] BUG: Bad page state in process sh  pfn:a1b60
[   95.601645] page:c0456c00 count:0 mapcount:0 mapping:  (null) index:0x0
[   95.601698] page flags: 0x200(arch_1)
[   95.601917] [<c0029610>] (unwind_backtrace+0x0/0xe4) from [<c0073088>] 
(bad_page+0xc8/0xf4)
[   95.602042] [<c0073088>] (bad_page+0xc8/0xf4) from [<c0074088>] 
(get_page_from_freelist+0x378/0x494)
[   95.602167] [<c0074088>] (get_page_from_freelist+0x378/0x494) from 
[<c007426c>] (__alloc_pages_nodemask+0xc8/0x50c)
[   95.602290] [<c007426c>] (__alloc_pages_nodemask+0xc8/0x50c) from 
[<c00746c0>] (__get_free_pages+0x10/0x3c)
[   95.602424] [<c00746c0>] (__get_free_pages+0x10/0x3c) from [<c002b780>] 
(pgd_alloc+0x14/0xd0)
[   95.602581] [<c002b780>] (pgd_alloc+0x14/0xd0) from [<c0036ce0>] 
(mm_init.clone.54+0x98/0xd8)
[   95.602702] [<c0036ce0>] (mm_init.clone.54+0x98/0xd8) from [<c0036edc>] 
(dup_mm+0x60/0x4e0)
[   95.602819] [<c0036edc>] (dup_mm+0x60/0x4e0) from [<c0037a60>] 
(copy_process+0x6cc/0xde4)
[   95.602933] [<c0037a60>] (copy_process+0x6cc/0xde4) from [<c00382fc>] 
(do_fork+0x160/0x334)
[   95.603042] [<c00382fc>] (do_fork+0x160/0x334) from [<c002804c>] 
(sys_fork+0x20/0x24)
[   95.603196] [<c002804c>] (sys_fork+0x20/0x24) from [<c0024fc0>] 
(ret_fast_syscall+0x0/0x2c)
[   95.603264] Disabling lock debugging due to kernel taint
[   95.607171] BUG: Bad page state in process sh  pfn:a1b64
[   95.607282] page:c0456c80 count:0 mapcount:0 mapping:  (null) index:0x0
[   95.607335] page flags: 0x200(arch_1)
[   95.607556] [<c0029610>] (unwind_backtrace+0x0/0xe4) from [<c0073088>] 
(bad_page+0xc8/0xf4)
[   95.607680] [<c0073088>] (bad_page+0xc8/0xf4) from [<c0074088>] 
(get_page_from_freelist+0x378/0x494)
[   95.607805] [<c0074088>] (get_page_from_freelist+0x378/0x494) from 
[<c007426c>] (__alloc_pages_nodemask+0xc8/0x50c)
[   95.607955] [<c007426c>] (__alloc_pages_nodemask+0xc8/0x50c) from 
[<c0083890>] (__pte_alloc+0x20/0x1a4)
[   95.608080] [<c0083890>] (__pte_alloc+0x20/0x1a4) from [<c0084864>] 
(copy_page_range+0xf4/0x42c)
[   95.608236] [<c0084864>] (copy_page_range+0xf4/0x42c) from [<c0037178>] 
(dup_mm+0x2fc/0x4e0)
[   95.608355] [<c0037178>] (dup_mm+0x2fc/0x4e0) from [<c0037a60>] 
(copy_process+0x6cc/0xde4)
[   95.608471] [<c0037a60>] (copy_process+0x6cc/0xde4) from [<c00382fc>] 
(do_fork+0x160/0x334)
[   95.608580] [<c00382fc>] (do_fork+0x160/0x334) from [<c002804c>] 
(sys_fork+0x20/0x24)
[   95.608735] [<c002804c>] (sys_fork+0x20/0x24) from [<c0024fc0>] 
(ret_fast_syscall+0x0/0x2c)

And kernel hangs in few minutes after that.

Sample code is attached, it tries to enable 1st overlay and fill it with some 
color.

Any ideas what can be wrong?

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: main.c
Type: text/x-csrc
Size: 1483 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110126/8737df7f/attachment.bin>
