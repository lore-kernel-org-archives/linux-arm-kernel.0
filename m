From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 12 Dec 2016 09:40:17 +0000
Subject: Tegra baseline test results for v4.9-rc8
Message-ID: <5b37cc1c-033e-f198-47c8-79e4a8a72a40@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.9-rc8.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.9-rc8/20161206040103/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 4/ 4): qemu-vexpress64, tegra132-norrin,
		   tegra210-p2371-0000, tegra210-smaug

Boot to userspace: multi_v7_defconfig:
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver

PM: System suspend: multi_v7_defconfig:
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig:
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.9-rc7 (e5517c2a5a49ed5e99047008629f1cd60246ea0e)):
   text     data      bss    total  kernel
  +3849     +216        0    +4065  defconfig
   +936        0        0     +936  multi_v7_defconfig
   +228        0        0     +228  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.9-rc7 (e5517c2a5a49ed5e99047008629f1cd60246ea0e))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
        .        .        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
        .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
        .        .        .        .       tegra210-smaug            defconfig       tegra210-smaug
        .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
