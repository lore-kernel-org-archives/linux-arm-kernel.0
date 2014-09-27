From: drake@endlessm.com (Daniel Drake)
Date: Fri, 26 Sep 2014 18:24:41 -0600
Subject: 3.17-rc6 on ODROID: ERROR: Bad of_node_put() on /ehci@12580000/port@1
Message-ID: <CAD8Lp45qyHpHqRnUy4T9Sm8zV4XJBDp=cLYXjtcxmVrS8GSjbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Booting 3.17-rc6 on ODROID-U2, I see this message:

ERROR: Bad of_node_put() on /ehci at 12580000/port at 1
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.17.0-rc6-00376-g85cd8fd #1031
[<c0016418>] (unwind_backtrace) from [<c0011f00>] (show_stack+0x10/0x14)
[<c0011f00>] (show_stack) from [<c08213fc>] (dump_stack+0x84/0xc4)
[<c08213fc>] (dump_stack) from [<c02dacc0>] (kobject_cleanup+0x58/0x6c)
[<c02dacc0>] (kobject_cleanup) from [<c0608718>]
(of_get_next_available_child+0x78/0x98)
[<c0608718>] (of_get_next_available_child) from [<c05673c8>]
(exynos_ehci_probe+0x254/0x424)
[<c05673c8>] (exynos_ehci_probe) from [<c03ce700>]
(platform_drv_probe+0x2c/0x5c)
[<c03ce700>] (platform_drv_probe) from [<c03ccd00>]
(driver_probe_device+0xe8/0x234)
[<c03ccd00>] (driver_probe_device) from [<c03ccef8>] (__driver_attach+0x68/0x8c)

This repeats for all of the ehci and ohci ports.

Haven't had time to dig deeper. Is this a known issue?

Thanks
Daniel
