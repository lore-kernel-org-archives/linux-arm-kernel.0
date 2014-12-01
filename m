From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 1 Dec 2014 09:21:35 -0700
Subject: Tegra baseline test results for v3.18-rc7
Message-ID: <547C958F.1010008@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.18-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18-rc7/20141130170104/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.18-rc6 (5d01410fe4d92081f349b013a2e7a95429e4f2c9)):
    text     data      bss    total  kernel
    -391     +480        0      +89  multi_v7_defconfig
    -215     +480        0     +265  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.18-rc6 (5d01410fe4d92081f349b013a2e7a95429e4f2c9))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -4k       4k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       -4k       4k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
       -4k       4k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
