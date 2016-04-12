From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 12 Apr 2016 17:27:21 +0530
Subject: exynos5800 based peach-pi boot is broken with v4.6-rc-1
Message-ID: <570CE2A1.904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
I can't boot Peach-pi (exynos5800) with v4.6-rc-1, board hangs while 
booting with below boot hang-task.
I have not git-bisected yet, will do that, but AFAIR it was booting fine 
with v4.5.
Any idea?

=======
[    3.682786]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[   36.001343] random: nonblocking pool is initialized
[  240.086291] INFO: task swapper/0:1 blocked for more than 120 seconds.
[  240.091271]       Not tainted 4.6.0-rc1 #1
[  240.095324] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  240.103153] swapper/0       D c07247cc     0     1      0 0x00000000
[  240.109480] [<c07247cc>] (__schedule) from [<c0724ca0>] 
(schedule+0x40/0xac)
[  240.116517] [<c0724ca0>] (schedule) from [<c0724f04>] 
(schedule_preempt_disabled+0x14/0x20)
[  240.124846] [<c0724f04>] (schedule_preempt_disabled) from 
[<c0727704>] (__mutex_lock_slowpath+0x1b4/0x418)
[  240.134474] [<c0727704>] (__mutex_lock_slowpath) from [<c0727974>] 
(mutex_lock+0xc/0x24)
[  240.142544] [<c0727974>] (mutex_lock) from [<c05a1678>] 
(cros_ec_cmd_xfer+0x18/0xe8)
[  240.150262] [<c05a1678>] (cros_ec_cmd_xfer) from [<c05a087c>] 
(get_lightbar_version+0x34/0xb8)
[  240.158849] [<c05a087c>] (get_lightbar_version) from [<c05a092c>] 
(cros_ec_lightbar_attrs_are_visible+0x2c/0x38)
[  240.169000] [<c05a092c>] (cros_ec_lightbar_attrs_are_visible) from 
[<c024ca58>] (internal_create_group+0xb4/0x2d4)
[  240.179323] [<c024ca58>] (internal_create_group) from [<c024cda4>] 
(sysfs_create_groups+0x48/0xc8)
[  240.188260] [<c024cda4>] (sysfs_create_groups) from [<c0431c6c>] 
(device_add+0x258/0x528)
[  240.196413] [<c0431c6c>] (device_add) from [<c059fc90>] 
(ec_device_probe+0x12c/0x14c)
[  240.204223] [<c059fc90>] (ec_device_probe) from [<c0435c90>] 
(platform_drv_probe+0x50/0xa0)
[  240.212549] [<c0435c90>] (platform_drv_probe) from [<c04344b0>] 
(driver_probe_device+0x200/0x2ac)
[  240.221397] [<c04344b0>] (driver_probe_device) from [<c0434600>] 
(__driver_attach+0xa4/0xa8)
[  240.229811] [<c0434600>] (__driver_attach) from [<c0432b90>] 
(bus_for_each_dev+0x54/0x88)
[  240.237966] [<c0432b90>] (bus_for_each_dev) from [<c0433b00>] 
(bus_add_driver+0x174/0x1fc)
[  240.246206] [<c0433b00>] (bus_add_driver) from [<c0434e00>] 
(driver_register+0x78/0xf4)
[  240.254188] [<c0434e00>] (driver_register) from [<c0b22dcc>] 
(cros_ec_dev_init+0x88/0xd0)
[  240.262344] [<c0b22dcc>] (cros_ec_dev_init) from [<c0101774>] 
(do_one_initcall+0x90/0x1d4)
[  240.270587] [<c0101774>] (do_one_initcall) from [<c0b00d98>] 
(kernel_init_freeable+0x14c/0x1f4)
[  240.279259] [<c0b00d98>] (kernel_init_freeable) from [<c0723cb4>] 
(kernel_init+0x8/0x114)
[  240.287416] [<c0723cb4>] (kernel_init) from [<c0107e38>] 
(ret_from_fork+0x14/0x3c)
[  240.294961] INFO: task kworker/3:1:78 blocked for more than 120 seconds.
[  240.301637]       Not tainted 4.6.0-rc1 #1
