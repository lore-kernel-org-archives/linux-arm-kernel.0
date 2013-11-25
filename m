From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 25 Nov 2013 11:19:03 -0800
Subject: Tegra baseline test results for v3.13-rc1
Message-ID: <5293A2A7.6060100@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.13-rc1.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13-rc1/20131125105015/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.12 (test_v3.12)):
    text     data      bss    total  kernel
-458712    +3432    +5624  -449656  multi_v7_defconfig
-420983     +856    +4564  -415563  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.12 (test_v3.12))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      416k    -416k        .      -4k tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
      392k    -392k        .       8k tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
      428k    -428k        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      404k    -404k        .       8k       tegra30-beaver      tegra_defconfig       tegra30-beaver


The large size deltas are due to a toolchain switchover from CodeSourcery 2010.09 to Ubuntu/Linaro 4.6.3-1ubuntu5.
I'd expect that if the toolchain remained the same, the size deltas would be similar to the OMAP deltas:

     http://www.pwsan.com/omap/testlogs/test_v3.13-rc1/20131124223225/README.txt

This toolchain probably won't stay in use for very long here.
(Since this is a mainline kernel test, in my view, the primary test toolchain should also be mainline gcc/binutils.)
