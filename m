From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 9 Mar 2015 03:11:29 -0600
Subject: Tegra baseline test results for v4.0-rc3
Message-ID: <54FD63C1.9050603@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.0-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.0-rc3/20150308163103/


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
(delta in bytes from test_v4.0-rc2 (13a7a6ac0a11197edcd0f756a035f472b42cdf8b)):
    text     data      bss    total  kernel
     -30      +16      +64      +50  defconfig
   +3638      -80      +64    +3622  multi_v7_defconfig
   +2590     -112      +64    +2542  tegra_defconfig


  Boot-time memory difference
(delta in bytes from test_v4.0-rc2 (13a7a6ac0a11197edcd0f756a035f472b42cdf8b))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        .      qemu-vexpress64            defconfig           __internal
         .        .        .      -4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .      -4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .      -4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .      -4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .      -4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
