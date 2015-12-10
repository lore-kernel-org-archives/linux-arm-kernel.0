From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 10 Dec 2015 13:56:20 +0000
Subject: Tegra baseline test results for v4.4-rc4
Message-ID: <56698484.3060808@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.4-rc4.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.4-rc4/20151210053103/


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
(delta in bytes from test_v4.4-rc3 (31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8)):
   text     data      bss    total  kernel
  +4046    -4104        0      -58  defconfig
  +2665        0        0    +2665  multi_v7_defconfig
  +2361        0        0    +2361  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.4-rc3 (31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .      -4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .      -4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .      -4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .      -4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .      -4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .      -4k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .      -4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
