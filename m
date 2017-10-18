From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 18 Oct 2017 09:47:44 +0100
Subject: Tegra baseline test results for v4.14-rc4
Message-ID: <a90b6c7f-cc33-5e39-9b87-6dc69b0de8b9@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.14-rc4.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.14-rc4/20171008213104/


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
    Pass: ( 4/ 4): tegra124-jetson-tk1, tegra124-nyan-big,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra124-jetson-tk1, tegra124-nyan-big,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: multi_v7_defconfig:
    FAIL: ( 3/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver
    Pass: ( 2/ 5): tegra124-nyan-big, tegra20-trimslice

PM: System suspend: tegra_defconfig:
    FAIL: ( 3/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver
    Pass: ( 2/ 5): tegra124-nyan-big, tegra20-trimslice


vmlinux object size
(delta in bytes from test_v4.14-rc3 (9e66317d3c92ddaab330c125dfe9d06eee268aff)):
   text     data      bss    total  kernel
    -84     +588        0     +504  defconfig
   +852    +4128        0    +4980  multi_v7_defconfig
   +792      +44        0     +836  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.14-rc3 (9e66317d3c92ddaab330c125dfe9d06eee268aff))
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

--
nvpublic
