From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 27 Feb 2014 02:37:40 -0800
Subject: Tegra baseline test results for v3.14-rc1
Message-ID: <530F1574.3020006@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc1.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14-rc1/20140227022109/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13 (d8ec26d7f8287f5788a494f56e8814210f0e64be)):
    text     data      bss    total  kernel
+1833734  +109664     -460  +1942938  multi_v7_defconfig
+170871   +23512    -6616  +187767  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.13 (d8ec26d7f8287f5788a494f56e8814210f0e64be))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
  -2070932k  -25196k -1317888k    -472k tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
  -2053808k  -42320k -1317888k    -244k tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
   -18320k   18320k        .      36k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
     -168k     168k        .       4k       tegra30-beaver      tegra_defconfig       tegra30-beaver



The tegra114-dalmore-headless board, an A03 Dalmore, was dropped out of the testbed
since apparently NVIDIA folks don't maintain upstream support for any Dalmore revision
other than A04.  That's the cause of the large boot-time memory deltas above.
It's been replaced by an A04 Dalmore.  There should have been large boot-time memory
deltas on the A04 lines too, but the current set of scripts don't handle that condition well.

I double-checked the +1.9MB size increase for the multi_v7_defconfig kernel, and it appears
to be accurate :-(
