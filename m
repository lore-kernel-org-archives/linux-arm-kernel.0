From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 1 Jun 2016 09:02:11 +0100
Subject: Tegra baseline test results for v4.7-rc1
Message-ID: <574E9683.4020405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.7-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.7-rc1/20160531073102/


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
    FAIL: ( 1/ 5): tegra30-beaver
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice

PM: System suspend: tegra_defconfig:
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.6 (2dcd0af568b0cf583645c8a317dd12e344b1c72a)):
   text     data      bss    total  kernel
+929034   +88176   +17288  +1034498  defconfig
+225509  +415328    +1928  +642765  multi_v7_defconfig
+103892  +319480    +4372  +427744  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.6 (2dcd0af568b0cf583645c8a317dd12e344b1c72a))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
     -16k      16k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
     -20k      20k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -28k      28k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
     -32k      32k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
        .        .        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
      -8k       8k        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
     -12k      12k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
        .        .        .        .       tegra210-smaug            defconfig       tegra210-smaug
     -16k      16k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
     -20k      20k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver

--
nvpublic
