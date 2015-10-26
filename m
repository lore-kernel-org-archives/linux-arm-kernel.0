From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 26 Oct 2015 09:34:27 +0000
Subject: Tegra baseline test results for v4.3-rc7
Message-ID: <562DF3A3.90305@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.3-rc7.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.3-rc7/20151024220102/


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
(delta in bytes from test_v4.3-rc6 (7379047d5585187d1288486d4627873170d0005a)):
   text     data      bss    total  kernel
     +4        0        0       +4  defconfig
   +408        0        0     +408  multi_v7_defconfig
   +458        0      +64     +522  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.3-rc6 (7379047d5585187d1288486d4627873170d0005a))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .      -4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .      -4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .      -4k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .      -4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
