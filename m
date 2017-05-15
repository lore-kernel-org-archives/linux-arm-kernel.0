From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 15 May 2017 09:25:54 +0100
Subject: Tegra baseline test results for v4.12-rc1
Message-ID: <3c353038-d001-4560-4185-5d570a7c0839@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.12-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.12-rc1/20170513133103/


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
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig:
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.11 (a351e9b9fc24e982ec2f0e76379a49826036da12)):
   text     data      bss    total  kernel
+123259  +182072    +9736  +315067  defconfig
+665814  +536544  -129824  +1072534 multi_v7_defconfig
+1063940  +609176   +2560  +1675676 tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.11 (a351e9b9fc24e982ec2f0e76379a49826036da12))
    avail    rsrvd     high    freed                board              kconfig                  dtb
    -328k     328k        .        .      qemu-vexpress64            defconfig           __internal
    -232k     232k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
   -1436k    1436k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
    -232k     232k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
   -1436k    1436k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
    -232k     232k        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
   -1436k    1436k        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
    -224k     224k        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
   -1428k    1428k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
    -344k     344k        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
     736k    -736k        .        .       tegra210-smaug            defconfig       tegra210-smaug
    -232k     232k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
   -1436k    1436k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver

--
nvpublic
