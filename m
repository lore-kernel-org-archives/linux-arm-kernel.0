From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 14 Dec 2015 10:12:20 +0000
Subject: Tegra baseline test results for v4.4-rc5
Message-ID: <566E9604.8040601@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.4-rc5.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.4-rc5/20151213180102/


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
(delta in bytes from test_v4.4-rc4 (527e9316f8ec44bd53d90fb9f611fa7ffff52bb9)):
   text     data      bss    total  kernel
   +219        0        0     +219  defconfig
  +5803     +448        0    +6251  multi_v7_defconfig
  +5203      +64      -64    +5203  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.4-rc4 (527e9316f8ec44bd53d90fb9f611fa7ffff52bb9))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
      -8k       8k        .       4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      -8k       8k        .       4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -8k       8k        .       4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      -8k       8k        .       4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
      -8k       8k        .       4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      -8k       8k        .       4k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
      -8k       8k        .       4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      -8k       8k        .       4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
