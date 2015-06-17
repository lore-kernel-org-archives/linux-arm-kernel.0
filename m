From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 17 Jun 2015 13:23:02 -0600
Subject: Tegra baseline test results for v4.1-rc8
Message-ID: <5581C916.6010807@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.1-rc8.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.1-rc8/20150617120102/


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
(delta in bytes from test_v4.1-rc7 (d4a4f75cd8f29cd9464a5a32e9224a91571d6649)):
    text     data      bss    total  kernel
       0        0        0        0  defconfig
    -188        0        0     -188  multi_v7_defconfig
    +104        0        0     +104  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.1-rc7 (d4a4f75cd8f29cd9464a5a32e9224a91571d6649))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        .      qemu-vexpress64            defconfig           __internal
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
         .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
