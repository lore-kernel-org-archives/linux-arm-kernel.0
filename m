From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 2 Oct 2017 10:34:57 +0100
Subject: Tegra baseline test results for v4.14-rc3
Message-ID: <39a8ab29-1eda-674a-6f55-d4cf95eff223@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.14-rc3.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.14-rc3/20171001153104/


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
    FAIL: ( 3/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver
    Pass: ( 2/ 5): tegra124-nyan-big, tegra20-trimslice

PM: System suspend: tegra_defconfig:
    FAIL: ( 3/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver
    Pass: ( 2/ 5): tegra124-nyan-big, tegra20-trimslice


vmlinux object size
(delta in bytes from test_v4.14-rc2 (e19b205be43d11bff638cad4487008c48d21c103)):
   text     data      bss    total  kernel
  +3056    +9928        0   +12984  defconfig


Boot-time memory difference
(delta in bytes from test_v4.14-rc2 (e19b205be43d11bff638cad4487008c48d21c103))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
        .        .        .        .       tegra210-smaug            defconfig       tegra210-smaug

--
nvpublic
