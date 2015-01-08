From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 8 Jan 2015 03:51:22 -0700
Subject: Tegra baseline test results for v3.19-rc3
Message-ID: <54AE612A.6020607@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.19-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19-rc3/20150108022533/


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
(delta in bytes from test_v3.19-rc2 (b7392d2247cfe6771f95d256374f1a8e6a6f48d6)):
    text     data      bss    total  kernel
  +10783     +464        0   +11247  multi_v7_defconfig
   +4844      +72        0    +4916  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.19-rc2 (b7392d2247cfe6771f95d256374f1a8e6a6f48d6))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -12k      12k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .       4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -12k      12k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
       -8k       8k        .       4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
      -12k      12k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .       4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
