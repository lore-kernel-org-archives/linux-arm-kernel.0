From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 15 Mar 2016 08:45:30 +0000
Subject: Tegra baseline test results for v4.5
Message-ID: <56E7CBAA.3040004@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.5.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.5/20160314073105/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 3/ 3): qemu-vexpress64, tegra132-norrin,
		   tegra210-p2371-0000

Boot to userspace: multi_v7_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: multi_v7_defconfig:
    FAIL: ( 1/ 4): tegra114-dalmore-a04
    Pass: ( 3/ 4): tegra124-jetson-tk1, tegra20-trimslice,
		   tegra30-beaver

PM: System suspend: tegra_defconfig:
    FAIL: ( 1/ 4): tegra114-dalmore-a04
    Pass: ( 3/ 4): tegra124-jetson-tk1, tegra20-trimslice,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.5-rc7 (f6cede5b49e822ebc41a099fe41ab4989f64e2cb)):
   text     data      bss    total  kernel
  +4212   +12288        0   +16500  defconfig
  +1472        0        0    +1472  multi_v7_defconfig
  -3224        0        0    -3224  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.5-rc7 (f6cede5b49e822ebc41a099fe41ab4989f64e2cb))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .      -4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .       4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .      -4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .       4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
        .        .        .      -4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .       4k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
        .        .        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .       4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
