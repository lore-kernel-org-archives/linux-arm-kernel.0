From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Tue, 18 Jun 2013 14:58:18 +0530
Subject: ARM Versatile A15_A7 boot with 3 & 4 Cores
Message-ID: <CALicx6s6E6qMmFPmvjikk+UCWaQCHipEdBN-eC33NPO7E9Gx4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

   Using ARM Versatile board A15 (2 core) & A7 (3 cores) configuration
with 3.10 SMP kernel with number of cores set to 3 / 4 cores, kernel
does not boot. Boot fails with Bad page during pgd_alloc()


The same kernel boots without any problems when number of cores set to
1/2/5. The problem is seen only with 3/4 cores.

VFS: Mounted root (nfs filesystem) on device 0:10.
Freeing unused kernel memory: 200K (80487000 - 804b9000)
BUG: Bad page state in process swapper/0  pfn:bf98e
page:80cfa1c0 count:1 mapcount:0 mapping:  (null) index:0x0
page flags: 0x0(
INFO: rcu_sched self-detected stall on CPUINFO: rcu_sched detected
stalls on CPUs/tasks: { 0} (detected by 1, t=65540 jiffies,
g=4294967027, c=4294967026, q=9)
Task dump for CPU 0:
swapper/0       R running      0     1      0 0x00000000
[<80365440>] (__schedule+0x1dc/0x5b8) from [<00000000>] (  (null))
 { 0}  (t=65540 jiffies g=4294967027 c=4294967026 q=9)
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
3.10.0-rc4.arm-cortex-a15 #1
[<80014808>] (unwind_backtrace+0x0/0xf8) from [<80011ab4>]
(show_stack+0x10/0x14)
[<80011ab4>] (show_stack+0x10/0x14) from [<80071fb8>]
(rcu_check_callbacks+0x30c/0x71c)
[<80071fb8>] (rcu_check_callbacks+0x30c/0x71c) from [<8002c07c>]
(update_process_times+0x38/0x64)
[<8002c07c>] (update_process_times+0x38/0x64) from [<800570b0>]
(tick_periodic+0x34/0xb8)
[<800570b0>] (tick_periodic+0x34/0xb8) from [<800571a0>]
(tick_handle_periodic+0x24/0x88)
[<800571a0>] (tick_handle_periodic+0x24/0x88) from [<80276638>]
(arch_timer_handler_virt+0x28/0x30)
[<80276638>] (arch_timer_handler_virt+0x28/0x30) from [<8006d5d4>]
(handle_percpu_devid_irq+0x64/0x80)
[<8006d5d4>] (handle_percpu_devid_irq+0x64/0x80) from [<80069f9c>]
(generic_handle_irq+0x20/0x30)
[<80069f9c>] (generic_handle_irq+0x20/0x30) from [<8000f174>]
(handle_IRQ+0x38/0x94)
[<8000f174>] (handle_IRQ+0x38/0x94) from [<80008570>] (gic_handle_irq+0x28/0x5c)
[<80008570>] (gic_handle_irq+0x28/0x5c) from [<8000dec0>] (__irq_svc+0x40/0x50)
Exception stack(0xbf847d08 to 0xbf847d50)
7d00:                   804e4700 20000193 000003a2 000003a3 804e4700 0000000f
7d20: 804c89f4 00000001 60000113 60000113 bf846000 00000010 00000000 bf847d50
7d40: 80020df4 80021444 60000113 ffffffff
[<8000dec0>] (__irq_svc+0x40/0x50) from [<80021444>] (vprintk_emit+0x214/0x508)
[<80021444>] (vprintk_emit+0x214/0x508) from [<80360a74>] (printk+0x34/0x44)
[<80360a74>] (printk+0x34/0x44) from [<80086c98>] (dump_page+0x48/0xf8)
[<80086c98>] (dump_page+0x48/0xf8) from [<80086dec>] (bad_page+0xa4/0x108)
[<80086dec>] (bad_page+0xa4/0x108) from [<80087458>]
(get_page_from_freelist+0x548/0x648)
[<80087458>] (get_page_from_freelist+0x548/0x648) from [<80087e00>]
(__alloc_pages_nodemask+0x124/0x890)
[<80087e00>] (__alloc_pages_nodemask+0x124/0x890) from [<8008857c>]
(__get_free_pages+0x10/0x4c)
[<8008857c>] (__get_free_pages+0x10/0x4c) from [<80019ecc>]
(pgd_alloc+0x14/0xe0)
[<80019ecc>] (pgd_alloc+0x14/0xe0) from [<8001cbe4>] (mm_init.isra.50+0x98/0xd4)
[<8001cbe4>] (mm_init.isra.50+0x98/0xd4) from [<800be984>]
(do_execve+0x198/0x4c0)
[<800be984>] (do_execve+0x198/0x4c0) from [<8035c208>] (kernel_init+0x80/0xe4)
[<8035c208>] (kernel_init+0x80/0xe4) from [<8000e318>] (ret_from_fork+0x14/0x3c)
)
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
3.10.0-rc4.arm-cortex-a15 #1
[<80014808>] (unwind_backtrace+0x0/0xf8) from [<80011ab4>]
(show_stack+0x10/0x14)
[<80011ab4>] (show_stack+0x10/0x14) from [<80086df4>] (bad_page+0xac/0x108)
[<80086df4>] (bad_page+0xac/0x108) from [<80087458>]
(get_page_from_freelist+0x548/0x648)
[<80087458>] (get_page_from_freelist+0x548/0x648) from [<80087e00>]
(__alloc_pages_nodemask+0x124/0x890)
[<80087e00>] (__alloc_pages_nodemask+0x124/0x890) from [<8008857c>]
(__get_free_pages+0x10/0x4c)
[<8008857c>] (__get_free_pages+0x10/0x4c) from [<80019ecc>]
(pgd_alloc+0x14/0xe0)
[<80019ecc>] (pgd_alloc+0x14/0xe0) from [<8001cbe4>] (mm_init.isra.50+0x98/0xd4)
[<8001cbe4>] (mm_init.isra.50+0x98/0xd4) from [<800be984>]
(do_execve+0x198/0x4c0)
[<800be984>] (do_execve+0x198/0x4c0) from [<8035c208>] (kernel_init+0x80/0xe4)
[<8035c208>] (kernel_init+0x80/0xe4) from [<8000e318>] (ret_from_fork+0x14/0x3c)
Disabling lock debugging due to kernel taint
BUG: Bad page state in process kworker/2:1  pfn:bf9e2
page:80cfac40 count:1 mapcount:0 mapping:  (null) index:0x0
page flags: 0x0()
Modules linked in:
CPU: 2 PID: 364 Comm: kworker/2:1 Tainted: G    B   W
3.10.0-rc4.arm-cortex-a15 #1
Workqueue: rpciod xs_udp_setup_socket
[<80014808>] (unwind_backtrace+0x0/0xf8) from [<80011ab4>]
(show_stack+0x10/0x14)
[<80011ab4>] (show_stack+0x10/0x14) from [<80086df4>] (bad_page+0xac/0x108)
[<80086df4>] (bad_page+0xac/0x108) from [<80087458>]
(get_page_from_freelist+0x548/0x648)
[<80087458>] (get_page_from_freelist+0x548/0x648) from [<0a216a00>] (0xa216a00)
BUG: Bad page state in process kworker/2:1  pfn:bf9e2
page:80cfac40 count:1 mapcount:0 mapping:  (null) index:0x0
page flags: 0x0()
Modules linked in:
CPU: 2 PID: 364 Comm: kworker/2:1 Tainted: G    B   W
3.10.0-rc4.arm-cortex-a15 #1
Workqueue: rpciod xs_udp_setup_socket
[<80014808>] (unwind_backtrace+0x0/0xf8) from [<80011ab4>]
(show_stack+0x10/0x14)


can you please provide your inputs

Thanks & Regards
Vijay
