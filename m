From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Sun, 18 Jan 2015 19:24:54 -0700
Subject: Tegra baseline test results for v3.19-rc5
Message-ID: <54BC6AF6.6010407@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.19-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19-rc5/20150118174923/


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
(delta in bytes from test_v3.19-rc4 (eaa27f34e91a14cdceed26ed6c6793ec1d186115)):
    text     data      bss    total  kernel
   +1808     +416        0    +2224  multi_v7_defconfig
   +1188      +96        0    +1284  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.19-rc4 (eaa27f34e91a14cdceed26ed6c6793ec1d186115))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -8k       8k        .       8k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       -8k       8k        .       8k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
       -8k       8k        .       8k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
