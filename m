From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 13 Apr 2015 11:12:27 -0600
Subject: Tegra baseline test results for v4.0
Message-ID: <552BF8FB.7080103@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.0.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.0/20150413095455/


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
(delta in bytes from test_v4.0-rc7 (f22e6e847115abc3a0e2ad7bb18d243d42275af1)):
    text     data      bss    total  kernel
     -36    -1528        0    -1564  multi_v7_defconfig
    -128        0        0     -128  tegra_defconfig
       0        0        0        0  defconfig


Boot-time memory difference
(delta in bytes from test_v4.0-rc7 (f22e6e847115abc3a0e2ad7bb18d243d42275af1))
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
