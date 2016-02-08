From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 8 Feb 2016 16:53:51 +0000
Subject: Tegra baseline test results for v4.5-rc3
Message-ID: <56B8C81F.6000300@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.5-rc3.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.5-rc3/20160208033104/


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
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.5-rc2 (36f90b0a2ddd60823fe193a85e60ff1906c2a9b3)):
   text     data      bss    total  kernel
  +4160   +12288     -128   +16320  defconfig
  +3754     +320      +64    +4138  multi_v7_defconfig
  +1938     +456        0    +2394  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.5-rc2 (36f90b0a2ddd60823fe193a85e60ff1906c2a9b3))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
      -8k       8k        .       4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      -4k       4k        .      -4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -8k       8k        .       4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      -4k       4k        .      -4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
      -8k       8k        .       4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      -4k       4k        .      -4k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
      -8k       8k        .       4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      -4k       4k        .      -4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
