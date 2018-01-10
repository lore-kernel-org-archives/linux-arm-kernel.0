From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 10 Jan 2018 10:35:19 +0000
Subject: Tegra baseline test results for v4.15-rc7
Message-ID: <ee7d9ffa-315a-f624-3cfd-ddffe8e55576@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.15-rc7.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.15-rc7/20180107150102/


Test summary - 84% Success
--------------------------

Build: zImage:
    Pass: ( 3/ 3): multi_v7_defconfig, tegra_defconfig,
		   tegra_defconfig%tegra-fw

Build: Image:
    Pass: ( 3/ 3): defconfig, defconfig%jetson-tx2,
		   defconfig%jetson-tx1

Boot to userspace: defconfig:
    Pass: ( 4/ 4): qemu-vexpress64, tegra132-norrin,
		   tegra210-p2371-0000, tegra210-smaug

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
(delta in bytes from test_v4.15-rc6 (30a7acd573899fd8b8ac39236eff6468b195ac7d)):
   text     data      bss    total  kernel
   +266     -256        0      +10  defconfig
   +140        0        0     +140  multi_v7_defconfig
   +108        0        0     +108  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.15-rc6 (30a7acd573899fd8b8ac39236eff6468b195ac7d))
    avail    rsrvd     high    freed                board              kconfig                  dtb
       8k      -8k        .        .      qemu-vexpress64            defconfig           __internal
        .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
        .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1 tegra_defconfig%tegr  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
        .        .        .        .    tegra124-nyan-big tegra_defconfig%tegr    tegra124-nyan-big
        .        .        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
       8k      -8k        .        .      tegra132-norrin            defconfig      tegra132-norrin
        .        .        .        .  tegra186-p2771-0000 defconfig%jetson-tx2  tegra186-p2771-0000
        .        .        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
       8k      -8k        .        .  tegra210-p2371-0000 defconfig%jetson-tx1  tegra210-p2371-0000
       8k      -8k        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
        .        .        .        .  tegra210-p2371-2180 defconfig%jetson-tx1  tegra210-p2371-2180
       8k      -8k        .        .       tegra210-smaug            defconfig       tegra210-smaug
        .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
--
nvpublic
