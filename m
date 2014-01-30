From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Thu, 30 Jan 2014 15:31:46 +0100
Subject: 'unannotated irqs-on' lockdep warning
Message-ID: <CAH9NwWcVrjV1=rFnHJhDH0yoEkTwUTcq-Tn=R0aaiTr70Fs3hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got this lockdep warning on an imx6q with 3.12.4

uncompressing Linux... done, booting the kernel.
Loading, please wait...
[   19.835411] ------------[ cut here ]------------
[   19.840069] WARNING: CPU: 0 PID: 1848 at kernel/lockdep.c:3539
check_flags.part.26+0xb4/0x1e4()
[   19.848775] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
[   19.854180] Modules linked in: ipv6 rotary_encoder
[   19.859234] CPU: 0 PID: 1848 Comm: mkdir Not tainted 3.12.4 #44
[   19.865190] [<c0013900>] (unwind_backtrace+0x0/0xe0) from
[<c00113b8>] (show_stack+0x10/0x14)
[   19.873739] [<c00113b8>] (show_stack+0x10/0x14) from [<c044e040>]
(dump_stack+0x64/0xa4)
[   19.881851] [<c044e040>] (dump_stack+0x64/0xa4) from [<c0022718>]
(warn_slowpath_common+0x64/0x84)
[   19.890828] [<c0022718>] (warn_slowpath_common+0x64/0x84) from
[<c00227b8>] (warn_slowpath_fmt+0x2c/0x3c)
[   19.900413] [<c00227b8>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c0076c84>] (check_flags.part.26+0xb4/0x1e4)
[   19.910001] [<c0076c84>] (check_flags.part.26+0xb4/0x1e4) from
[<c0079654>] (lock_release+0x3c/0x100)
[   19.919243] [<c0079654>] (lock_release+0x3c/0x100) from
[<c00485b4>] (lg_local_unlock+0x18/0x6c)
[   19.928055] [<c00485b4>] (lg_local_unlock+0x18/0x6c) from
[<c012a2cc>] (free_fs_struct+0x18/0x30)
[   19.936947] [<c012a2cc>] (free_fs_struct+0x18/0x30) from
[<c0024e24>] (do_exit+0x2ac/0x3f0)
[   19.945316] [<c0024e24>] (do_exit+0x2ac/0x3f0) from [<c002501c>]
(do_group_exit+0x88/0xb4)
[   19.953596] [<c002501c>] (do_group_exit+0x88/0xb4) from
[<c0025058>] (__wake_up_parent+0x0/0x18)
[   19.962391] ---[ end trace 98a70b5cdc7b49fe ]---
[   19.967017] possible reason: unannotated irqs-on.
[   19.971729] irq event stamp: 2910
[   19.975050] hardirqs last  enabled at (2909): [<c044a160>]
__slab_free+0x1c0/0x390
[   19.982661] hardirqs last disabled at (2910): [<c0456d14>]
__dabt_svc+0x34/0x60
[   19.990007] softirqs last  enabled at (2788): [<c0026ed4>]
__do_softirq+0x2a0/0x2e0
[   19.997696] softirqs last disabled at (2763): [<c0026fac>]
do_softirq+0x48/0x6c
[   20.573919] fec 2188000.ethernet eth0: Freescale FEC PHY driver
[Generic PHY] (mii_bus:phy_addr=fixed-0:00, irq=-1)
[   20.592644] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   21.790278] input: frontkey-keyboard as /devices/virtual/input/input2
[   21.815455] input: rotary-keyboard as /devices/virtual/input/input3
[   22.572591] libphy: fixed-0:00 - Link is Up - 100/Full
[   22.577819] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--
Christian Gmeiner, MSc
