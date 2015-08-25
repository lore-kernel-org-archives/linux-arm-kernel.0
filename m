From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 25 Aug 2015 09:17:32 +0100
Subject: Tegra baseline test results for v4.2-rc8
Message-ID: <55DC249C.5070808@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.2-rc8.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.2-rc8/20150823213103/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 1/ 1): qemu-vexpress64

Boot to userspace: multi_v7_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.2-rc7 (2c6625cd545bdd66acff14f3394865d43920a5c7)):
   text     data      bss    total  kernel
     -3        0        0       -3  defconfig
   text     data      bss    total  kernel
  -1151        0        0    -1151  multi_v7_defconfig
 -14778      -64        0   -14842  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.2-rc7 (2c6625cd545bdd66acff14f3394865d43920a5c7))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .       4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      16k     -16k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .       4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      16k     -16k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .       4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      16k     -16k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .       4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      16k     -16k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
