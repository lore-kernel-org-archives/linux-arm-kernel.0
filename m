From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 5 Sep 2016 20:37:30 +0100
Subject: Tegra baseline test results for v4.8-rc5
Message-ID: <01462d4f-b8eb-9fe8-8f68-73979c1b34f0@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.8-rc5.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.8-rc5/20160904150103/


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
(delta in bytes from test_v4.8-rc4 (3eab887a55424fc2c27553b7bfe32330df83f7b8)):
   text     data      bss    total  kernel
    -14    +1056     -128     +914  defconfig
  -1337    +1152        0     -185  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.8-rc4 (3eab887a55424fc2c27553b7bfe32330df83f7b8))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
      -4k       4k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -4k       4k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
      -4k       4k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
        .        .        .        .       tegra210-smaug            defconfig       tegra210-smaug
      -4k       4k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver


--
nvpublic
