From: cb@sgoc.de (Christoph G. Baumann)
Date: Tue, 30 Apr 2013 15:06:03 +0200 (CEST)
Subject: Driver for OCOTP with write support for i.MX23/28
Message-ID: <179156480.94949.1367327163761.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

currently I'm porting the OCOTP driver from Freescale for the i.MX23/28 to
mainline.
I removed the code for i.MX50 as this platform is AFAIK currently not supported
and I can't test it anyway.
So far checkpatch.pl is pleased with it. Write support also works.
But there is one flaw: the creation of the sysfs nodes triggers some error logs
(see attachment).

So I have two questions:
1. How can I fix these error/bug messages?
2. Is this the right list to post the patch?


Regards
Christoph
-------------- next part --------------
[    2.140000] BUG: key c7a3a80c not in .data!
[    2.150000] ------------[ cut here ]------------
[    2.150000] WARNING: at kernel/lockdep.c:2986 sysfs_add_file_mode+0x84/0xe4()
[    2.160000] [<c0013708>] (unwind_backtrace+0x0/0xf0) from [<c001c0bc>] (warn_slowpath_common+0x48/0x60)
[    2.170000] [<c001c0bc>] (warn_slowpath_common+0x48/0x60) from [<c001c19c>] (warn_slowpath_null+0x1c/0x24)
[    2.180000] [<c001c19c>] (warn_slowpath_null+0x1c/0x24) from [<c0130114>] (sysfs_add_file_mode+0x84/0xe4)
[    2.190000] [<c0130114>] (sysfs_add_file_mode+0x84/0xe4) from [<c0132d34>] (create_files+0x74/0xc4)
[    2.200000] [<c0132d34>] (create_files+0x74/0xc4) from [<c0132e2c>] (internal_create_group+0xa8/0x170)
[    2.210000] [<c0132e2c>] (internal_create_group+0xa8/0x170) from [<c03366a8>] (fsl_otp_probe+0x4c/0x9c)
[    2.220000] [<c03366a8>] (fsl_otp_probe+0x4c/0x9c) from [<c028da3c>] (platform_drv_probe+0x14/0x18)
[    2.220000] [<c028da3c>] (platform_drv_probe+0x14/0x18) from [<c028cb40>] (really_probe+0x68/0x1fc)
[    2.230000] [<c028cb40>] (really_probe+0x68/0x1fc) from [<c028cd8c>] (__driver_attach+0x94/0x98)
[    2.240000] [<c028cd8c>] (__driver_attach+0x94/0x98) from [<c028b2bc>] (bus_for_each_dev+0x54/0x7c)
[    2.250000] [<c028b2bc>] (bus_for_each_dev+0x54/0x7c) from [<c028baf0>] (bus_add_driver+0x174/0x244)
[    2.260000] [<c028baf0>] (bus_add_driver+0x174/0x244) from [<c028d138>] (driver_register+0x78/0x144)
[    2.270000] [<c028d138>] (driver_register+0x78/0x144) from [<c0520838>] (do_one_initcall+0x94/0x170)
[    2.280000] [<c0520838>] (do_one_initcall+0x94/0x170) from [<c05209ac>] (do_basic_setup+0x98/0xcc)
[    2.290000] [<c05209ac>] (do_basic_setup+0x98/0xcc) from [<c0520a8c>] (kernel_init_freeable+0xac/0x144)
[    2.300000] [<c0520a8c>] (kernel_init_freeable+0xac/0x144) from [<c03dc6c8>] (kernel_init+0x8/0x104)
[    2.310000] [<c03dc6c8>] (kernel_init+0x8/0x104) from [<c000e868>] (ret_from_fork+0x14/0x2c)
[    2.320000] ---[ end trace e4af0d3a4a3a4b51 ]---
[    2.320000] BUG: key c7a3a828 not in .data!
[    2.330000] BUG: key c7a3a844 not in .data!
[    2.330000] BUG: key c7a3a860 not in .data!
[    2.330000] BUG: key c7a3a87c not in .data!
[    2.340000] BUG: key c7a3a898 not in .data!
[    2.340000] BUG: key c7a3a8b4 not in .data!
[    2.350000] BUG: key c7a3a8d0 not in .data!
[    2.350000] BUG: key c7a3a8ec not in .data!
[    2.360000] BUG: key c7a3a908 not in .data!
[    2.360000] BUG: key c7a3a924 not in .data!
[    2.360000] BUG: key c7a3a940 not in .data!
[    2.370000] BUG: key c7a3a95c not in .data!
[    2.370000] BUG: key c7a3a978 not in .data!
[    2.380000] BUG: key c7a3a994 not in .data!
[    2.380000] BUG: key c7a3a9b0 not in .data!
[    2.390000] BUG: key c7a3a9cc not in .data!
[    2.390000] BUG: key c7a3a9e8 not in .data!
[    2.390000] BUG: key c7a3aa04 not in .data!
[    2.400000] BUG: key c7a3aa20 not in .data!
[    2.400000] BUG: key c7a3aa3c not in .data!
[    2.410000] BUG: key c7a3aa58 not in .data!
[    2.410000] BUG: key c7a3aa74 not in .data!
[    2.420000] BUG: key c7a3aa90 not in .data!
[    2.420000] BUG: key c7a3aaac not in .data!
[    2.420000] BUG: key c7a3aac8 not in .data!
[    2.430000] BUG: key c7a3aae4 not in .data!
[    2.430000] BUG: key c7a3ab00 not in .data!
[    2.440000] BUG: key c7a3ab1c not in .data!
[    2.440000] BUG: key c7a3ab38 not in .data!
[    2.450000] BUG: key c7a3ab54 not in .data!
[    2.450000] BUG: key c7a3ab70 not in .data!
[    2.450000] BUG: key c7a3ab8c not in .data!
[    2.460000] BUG: key c7a3aba8 not in .data!
[    2.460000] BUG: key c7a3abc4 not in .data!
[    2.470000] BUG: key c7a3abe0 not in .data!
[    2.470000] BUG: key c7a3abfc not in .data!
[    2.480000] BUG: key c7a3ac18 not in .data!
[    2.480000] BUG: key c7a3ac34 not in .data!
[    2.480000] BUG: key c7a3ac50 not in .data!
