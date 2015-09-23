From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 23 Sep 2015 09:26:57 +0100
Subject: Tegra baseline test results for v4.3-rc2
Message-ID: <56026251.6060701@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.3-rc2.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.3-rc2/20150920150104/


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
(delta in bytes from test_v4.3-rc1 (6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f)):
   text     data      bss    total  kernel
   +784   +12272        0   +13056  defconfig
  +2978      -72        0    +2906  multi_v7_defconfig
    +18        0        0      +18  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.3-rc1 (6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .      -4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .      -4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .      -4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
