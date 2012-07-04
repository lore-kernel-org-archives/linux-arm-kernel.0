From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 00:53:34 -0300
Subject: mx28evk: kernel dump on sgtl5000 probe
Message-ID: <CAOMZO5BD_FcXVU18PauOFudod5FKd9MP-ZNUDJ4F9iQ6+EAjiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Running linux-next on a mx28evk I get the following:

[    0.930000] ------------[ cut here ]------------
[    0.940000] WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0x90/0xc0()
[    0.940000] sysfs: cannot create duplicate filename
'/devices/platform/reg-fixed-voltage/regulator/regulator.1/0-000a-VDDA'
[    0.950000] Modules linked in:
[    0.960000] [<c0014930>] (unwind_backtrace+0x0/0xf4) from
[<c001c054>] (warn_slowpath_common+0x4c/0x64)
[    0.970000] [<c001c054>] (warn_slowpath_common+0x4c/0x64) from
[<c001c100>] (warn_slowpath_fmt+0x30/0x40)
[    0.980000] [<c001c100>] (warn_slowpath_fmt+0x30/0x40) from
[<c0123b04>] (sysfs_add_one+0x90/0xc0)
[    0.990000] [<c0123b04>] (sysfs_add_one+0x90/0xc0) from
[<c0124d10>] (sysfs_do_create_link+0x128/0x224)
[    1.000000] [<c0124d10>] (sysfs_do_create_link+0x128/0x224) from
[<c01c4f60>] (create_regulator+0xbc/0x254)
[    1.010000] [<c01c4f60>] (create_regulator+0xbc/0x254) from
[<c01c6758>] (_regulator_get+0x9c/0x138)
[    1.020000] [<c01c6758>] (_regulator_get+0x9c/0x138) from
[<c01c684c>] (regulator_bulk_get+0x48/0xc0)
[    1.020000] [<c01c684c>] (regulator_bulk_get+0x48/0xc0) from
[<c0250f70>] (sgtl5000_replace_vddd_with_ldo+0xf8/0x1cc)
[    1.040000] [<c0250f70>]
(sgtl5000_replace_vddd_with_ldo+0xf8/0x1cc) from [<c02510c0>]
(sgtl5000_probe+0x7c/0x4dc)
[    1.050000] [<c02510c0>] (sgtl5000_probe+0x7c/0x4dc) from
[<c0244c04>] (soc_probe_codec+0x180/0x290)
[    1.060000] [<c0244c04>] (soc_probe_codec+0x180/0x290) from
[<c02454ec>] (snd_soc_register_card+0x7d8/0x1348)
[    1.070000] [<c02454ec>] (snd_soc_register_card+0x7d8/0x1348) from
[<c02f141c>] (mxs_sgtl5000_probe+0xf8/0x138)
[    1.080000] [<c02f141c>] (mxs_sgtl5000_probe+0xf8/0x138) from
[<c01eb4fc>] (platform_drv_probe+0x14/0x18)
[    1.090000] [<c01eb4fc>] (platform_drv_probe+0x14/0x18) from
[<c01ea1d4>] (driver_probe_device+0x80/0x214)
[    1.100000] [<c01ea1d4>] (driver_probe_device+0x80/0x214) from
[<c01ea3fc>] (__driver_attach+0x94/0x98)
[    1.110000] [<c01ea3fc>] (__driver_attach+0x94/0x98) from
[<c01e8afc>] (bus_for_each_dev+0x64/0x8c)
[    1.110000] [<c01e8afc>] (bus_for_each_dev+0x64/0x8c) from
[<c01e9364>] (bus_add_driver+0x194/0x270)
[    1.120000] [<c01e9364>] (bus_add_driver+0x194/0x270) from
[<c01ea9dc>] (driver_register+0x78/0x12c)
[    1.130000] [<c01ea9dc>] (driver_register+0x78/0x12c) from
[<c000874c>] (do_one_initcall+0x30/0x17c)
[    1.140000] [<c000874c>] (do_one_initcall+0x30/0x17c) from
[<c0413314>] (kernel_init+0xe8/0x1b4)
[    1.150000] [<c0413314>] (kernel_init+0xe8/0x1b4) from [<c001012c>]
(kernel_thread_exit+0x0/0x8)
[    1.160000] ---[ end trace 71dcd8a3218c5e53 ]---
[    1.170000] 3V3: could not add device link 0-000a err -17
[    1.180000] ------------[ cut here ]------------
[    1.180000] WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0x90/0xc0()
[    1.190000] sysfs: cannot create duplicate filename
'/devices/platform/reg-fixed-voltage/regulator/regulator.1/0-000a-VDDIO'
[    1.200000] Modules linked in:
[    1.210000] [<c0014930>] (unwind_backtrace+0x0/0xf4) from
[<c001c054>] (warn_slowpath_common+0x4c/0x64)
[    1.210000] [<c001c054>] (warn_slowpath_common+0x4c/0x64) from
[<c001c100>] (warn_slowpath_fmt+0x30/0x40)
[    1.220000] [<c001c100>] (warn_slowpath_fmt+0x30/0x40) from
[<c0123b04>] (sysfs_add_one+0x90/0xc0)
[    1.230000] [<c0123b04>] (sysfs_add_one+0x90/0xc0) from
[<c0124d10>] (sysfs_do_create_link+0x128/0x224)
[    1.240000] [<c0124d10>] (sysfs_do_create_link+0x128/0x224) from
[<c01c4f60>] (create_regulator+0xbc/0x254)
[    1.250000] [<c01c4f60>] (create_regulator+0xbc/0x254) from
[<c01c6758>] (_regulator_get+0x9c/0x138)
[    1.260000] [<c01c6758>] (_regulator_get+0x9c/0x138) from
[<c01c684c>] (regulator_bulk_get+0x48/0xc0)
[    1.270000] [<c01c684c>] (regulator_bulk_get+0x48/0xc0) from
[<c0250f70>] (sgtl5000_replace_vddd_with_ldo+0xf8/0x1cc)
[    1.280000] [<c0250f70>]
(sgtl5000_replace_vddd_with_ldo+0xf8/0x1cc) from [<c02510c0>]
(sgtl5000_probe+0x7c/0x4dc)
[    1.290000] [<c02510c0>] (sgtl5000_probe+0x7c/0x4dc) from
[<c0244c04>] (soc_probe_codec+0x180/0x290)
[    1.300000] [<c0244c04>] (soc_probe_codec+0x180/0x290) from
[<c02454ec>] (snd_soc_register_card+0x7d8/0x1348)
[    1.310000] [<c02454ec>] (snd_soc_register_card+0x7d8/0x1348) from
[<c02f141c>] (mxs_sgtl5000_probe+0xf8/0x138)
[    1.320000] [<c02f141c>] (mxs_sgtl5000_probe+0xf8/0x138) from
[<c01eb4fc>] (platform_drv_probe+0x14/0x18)
[    1.330000] [<c01eb4fc>] (platform_drv_probe+0x14/0x18) from
[<c01ea1d4>] (driver_probe_device+0x80/0x214)
[    1.340000] [<c01ea1d4>] (driver_probe_device+0x80/0x214) from
[<c01ea3fc>] (__driver_attach+0x94/0x98)
[    1.350000] [<c01ea3fc>] (__driver_attach+0x94/0x98) from
[<c01e8afc>] (bus_for_each_dev+0x64/0x8c)
[    1.360000] [<c01e8afc>] (bus_for_each_dev+0x64/0x8c) from
[<c01e9364>] (bus_add_driver+0x194/0x270)
[    1.370000] [<c01e9364>] (bus_add_driver+0x194/0x270) from
[<c01ea9dc>] (driver_register+0x78/0x12c)
[    1.380000] [<c01ea9dc>] (driver_register+0x78/0x12c) from
[<c000874c>] (do_one_initcall+0x30/0x17c)
[    1.390000] [<c000874c>] (do_one_initcall+0x30/0x17c) from
[<c0413314>] (kernel_init+0xe8/0x1b4)
[    1.400000] [<c0413314>] (kernel_init+0xe8/0x1b4) from [<c001012c>]
(kernel_thread_exit+0x0/0x8)
[    1.410000] ---[ end trace 71dcd8a3218c5e54 ]---
[    1.410000] 3V3: could not add device link 0-000a err -17

I haven't started debugging this yet, but just would like to check if
it is a known issue.

Regards,

Fabio Estevam
