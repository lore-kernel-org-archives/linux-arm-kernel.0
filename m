From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 13 Dec 2017 10:36:24 +0000
Subject: Tegra baseline test results for v4.15-rc3
Message-ID: <e2f90733-eb64-cb23-76a2-cdae32409f38@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.15-rc3.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.15-rc3/20171212080102/


Test summary - 81% Success
--------------------------

Build: zImage:
    Pass: ( 3/ 3): multi_v7_defconfig, tegra_defconfig,
		   tegra_defconfig%tegra-fw

Build: Image:
    Pass: ( 3/ 3): defconfig, defconfig%jetson-tx2,
		   defconfig%jetson-tx1

Boot to userspace: defconfig:
    FAIL: ( 1/ 4): qemu-vexpress64
    Pass: ( 3/ 4): tegra132-norrin, tegra210-p2371-0000, tegra210-smaug

Boot to userspace: defconfig%jetson-tx1:
    Pass: ( 2/ 2): tegra210-p2371-0000, tegra210-p2371-2180

Boot to userspace: defconfig%jetson-tx2:
    Pass: ( 1/ 1): tegra186-p2771-0000

Boot to userspace: multi_v7_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig%tegra-fw:
    FAIL: ( 1/ 2): tegra124-nyan-big
    Pass: ( 1/ 2): tegra124-jetson-tk1

PM: System suspend: multi_v7_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig%tegra-fw:
    FAIL: ( 1/ 2): tegra124-nyan-big
    Pass: ( 1/ 2): tegra124-jetson-tk1


vmlinux object size
(delta in bytes from test_v4.15-rc2 (ae64f9bd1d3621b5e60d7363bc20afb46aede215)):
   text     data      bss    total  kernel
  +3152     +832        0    +3984  defconfig
   +820     -128      +64     +756  multi_v7_defconfig
  +2120    +4108        0    +6228  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.15-rc2 (ae64f9bd1d3621b5e60d7363bc20afb46aede215))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1 tegra_defconfig%tegr  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
        .        .        .        .    tegra124-nyan-big tegra_defconfig%tegr    tegra124-nyan-big
        .        .        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
        .        .        .        .  tegra186-p2771-0000 defconfig%jetson-tx2  tegra186-p2771-0000
        .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000 defconfig%jetson-tx1  tegra210-p2371-0000
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
        .        .        .        .  tegra210-p2371-2180 defconfig%jetson-tx1  tegra210-p2371-2180
        .        .        .        .       tegra210-smaug            defconfig       tegra210-smaug
        .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
--
nvpublic
