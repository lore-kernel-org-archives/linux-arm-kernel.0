From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 2 Nov 2016 13:39:55 +0000
Subject: Tegra baseline test results for v4.9-rc1
Message-ID: <ff60cb86-a8e3-dc25-ac86-b6e3ccf7ea17@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.9-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.9-rc1/20161102045959/


Test summary
------------

Build: zImage:
    FAIL: ( 1/ 2): multi_v7_defconfig
    Pass: ( 1/ 2): tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 4/ 4): qemu-vexpress64, tegra132-norrin,
		   tegra210-p2371-0000, tegra210-smaug

Boot to userspace: tegra_defconfig:
    Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig:
    FAIL: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.8 (c8d2bc9bc39ebea8437fd974fdbc21847bb897a3)):
   text     data      bss    total  kernel
-3007747  +3664344    +7816  +664413  defconfig
 +69649   +14344    +3952   +87945  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.8 (c8d2bc9bc39ebea8437fd974fdbc21847bb897a3))
    avail    rsrvd     high    freed                board              kconfig                  dtb
    -640k     640k        .      64k      qemu-vexpress64            defconfig           __internal
      -4k       4k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -4k       4k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
     -96k      96k        .        .      tegra132-norrin            defconfig      tegra132-norrin
      -4k       4k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
    -660k     660k        .      64k  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
    -664k     664k        .      64k       tegra210-smaug            defconfig       tegra210-smaug
      -4k       4k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver

--
nvpublic
