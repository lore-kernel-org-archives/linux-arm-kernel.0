From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 30 Mar 2015 00:54:50 -0600
Subject: Tegra baseline test results for v4.0-rc6
Message-ID: <5518F33A.9020404@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.0-rc6.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v4.0-rc6/20150329160102/


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
(delta in bytes from test_v4.0-rc5 (bc465aa9d045feb0e13b4a8f32cc33c1943f62d6)):
    text     data      bss    total  kernel
    +252      -16        0     +236  multi_v7_defconfig
    +144      -24        0     +120  tegra_defconfig
  +20712   +12288        0   +33000  defconfig


Boot-time memory difference
(delta in bytes from test_v4.0-rc5 (bc465aa9d045feb0e13b4a8f32cc33c1943f62d6))
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
