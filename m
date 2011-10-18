From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Oct 2011 14:43:27 -0200
Subject: Warning at kernel/mutex.c
Message-ID: <CAOMZO5AR4iiktjmjzUU3AbQmYVk4wE28+KrZckt=VXLBJzXdBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am running 3.1-rc10 kernel built with mxs_defconfig on a MX28EVK
board and I am getting the following:

[    0.200000] Switching to clocksource mxs_timer
[    0.220000] Switched to NOHz mode on CPU #0
[    0.220000] ------------[ cut here ]------------
[    0.220000] WARNING: at kernel/mutex.c:198 mutex_lock_nested+0x260/0x29c()
[    0.220000] Modules linked in:
[    0.220000] [<c0014478>] (unwind_backtrace+0x0/0xf4) from
[<c002630c>] (warn_slowpath_common+0x4c/0x64)
[    0.220000] [<c002630c>] (warn_slowpath_common+0x4c/0x64) from
[<c0026340>] (warn_slowpath_null+0x1c/0x24)
[    0.220000] [<c0026340>] (warn_slowpath_null+0x1c/0x24) from
[<c02957cc>] (mutex_lock_nested+0x260/0x29c)
[    0.220000] [<c02957cc>] (mutex_lock_nested+0x260/0x29c) from
[<c0018580>] (clk_enable+0x2c/0x4c)
[    0.220000] [<c0018580>] (clk_enable+0x2c/0x4c) from [<c01cd9e0>]
(pl011_console_write+0x20/0x78)
[    0.220000] [<c01cd9e0>] (pl011_console_write+0x20/0x78) from
[<c002650c>] (__call_console_drivers+0x7c/0x94)
[    0.220000] [<c002650c>] (__call_console_drivers+0x7c/0x94) from
[<c0026b98>] (console_unlock+0xf8/0x230)
[    0.220000] [<c0026b98>] (console_unlock+0xf8/0x230) from
[<c002724c>] (vprintk+0x2a8/0x42c)
[    0.220000] [<c002724c>] (vprintk+0x2a8/0x42c) from [<c02937e0>]
(printk+0x20/0x30)
[    0.220000] [<c02937e0>] (printk+0x20/0x30) from [<c0049a80>]
(hrtimer_run_pending+0x78/0xd8)
[    0.220000] [<c0049a80>] (hrtimer_run_pending+0x78/0xd8) from
[<c00344c4>] (run_timer_softirq+0x18/0x3bc)
[    0.220000] [<c00344c4>] (run_timer_softirq+0x18/0x3bc) from
[<c002cb00>] (__do_softirq+0xa0/0x1e0)
[    0.220000] [<c002cb00>] (__do_softirq+0xa0/0x1e0) from
[<c002cdd8>] (irq_exit+0x8c/0xa8)
[    0.220000] [<c002cdd8>] (irq_exit+0x8c/0xa8) from [<c000ff60>]
(handle_IRQ+0x34/0x84)
[    0.220000] [<c000ff60>] (handle_IRQ+0x34/0x84) from [<c000ecd8>]
(__irq_svc+0x38/0x60)
[    0.220000] [<c000ecd8>] (__irq_svc+0x38/0x60) from [<c00c10c4>]
(T.844+0x2c8/0x404)
[    0.220000] [<c00c10c4>] (T.844+0x2c8/0x404) from [<c00c1364>]
(kmem_cache_alloc+0x164/0x174)
[    0.220000] [<c00c1364>] (kmem_cache_alloc+0x164/0x174) from
[<c00dbbc8>] (alloc_inode+0x54/0x9c)
[    0.220000] [<c00dbbc8>] (alloc_inode+0x54/0x9c) from [<c00dbc18>]
(new_inode_pseudo+0x8/0x40)
[    0.220000] [<c00dbc18>] (new_inode_pseudo+0x8/0x40) from
[<c00dbc58>] (new_inode+0x8/0x1c)
[    0.220000] [<c00dbc58>] (new_inode+0x8/0x1c) from [<c017a940>]
(T.386+0x38/0x160)
[    0.220000] [<c017a940>] (T.386+0x38/0x160) from [<c017ab30>]
(debugfs_create_file+0xc8/0x1b4)
[    0.220000] [<c017ab30>] (debugfs_create_file+0xc8/0x1b4) from
[<c0075bf8>] (trace_create_file+0x18/0x40)
[    0.220000] [<c0075bf8>] (trace_create_file+0x18/0x40) from
[<c007fc6c>] (__trace_add_event_call+0xc4/0x3bc)
[    0.220000] [<c007fc6c>] (__trace_add_event_call+0xc4/0x3bc) from
[<c0392cc4>] (event_trace_init+0x1c4/0x2c8)
[    0.220000] [<c0392cc4>] (event_trace_init+0x1c4/0x2c8) from
[<c0008704>] (do_one_initcall+0x30/0x17c)
[    0.220000] [<c0008704>] (do_one_initcall+0x30/0x17c) from
[<c038b21c>] (kernel_init+0x7c/0x120)
[    0.220000] [<c038b21c>] (kernel_init+0x7c/0x120) from [<c0010000>]
(kernel_thread_exit+0x0/0x8)

Is this a known issue?

Regards,

Fabio Estevam
