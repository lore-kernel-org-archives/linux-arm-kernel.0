From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 18 Aug 2015 11:08:03 +0100
Subject: Tegra baseline test results for v4.2-rc6
Message-ID: <55D30403.2030702@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.2-rc6.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.2-rc6/20150809133102/


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
(delta in bytes from test_v4.2-rc5 (74d33293e467df61de1b1d8b2fbe29e550dec33b)):
   text     data      bss    total  kernel
     -1        0        0       -1  defconfig
   +576        0        0     +576  multi_v7_defconfig
  +4431        0        0    +4431  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.2-rc5 (74d33293e467df61de1b1d8b2fbe29e550dec33b))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      -8k       8k        .       4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      -8k       8k        .       4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      -8k       8k        .       4k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      -8k       8k        .       4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
