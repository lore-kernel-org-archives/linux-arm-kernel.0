From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 16 Mar 2015 11:10:24 -0600
Subject: Tegra baseline test results for v4.0-rc4
Message-ID: <55070E80.8010209@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.0-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.0-rc4/20150315180104/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
     Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
     Pass: ( 1/ 1): qemu-vexpress64

Boot to userspace: multi_v7_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.0-rc3 (9eccca0843205f87c00404b663188b88eb248051)):
    text     data      bss    total  kernel
   +1272     -104    +1472    +2640  multi_v7_defconfig
    +832      +64        0     +896  tegra_defconfig
   +4148    -3600        0     +548  defconfig


Boot-time memory difference
(delta in bytes from test_v4.0-rc3 (9eccca0843205f87c00404b663188b88eb248051))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        .      qemu-vexpress64            defconfig           __internal
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
