From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 2 Nov 2016 14:03:06 +0000
Subject: Tegra baseline test results for v4.9-rc3
Message-ID: <f7750673-e13a-9e17-49b4-a2afc4a198cf@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.9-rc3.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.9-rc3/20161102060102/


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
(delta in bytes from test_v4.9-rc2 (07d9a380680d1c0eb51ef87ff2eab5c994949e69)):
   text     data      bss    total  kernel
   -429    +6528        0    +6099  defconfig
+121935   +25312      +64  +147311  multi_v7_defconfig
   -185    +3200        0    +3015  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.9-rc2 (07d9a380680d1c0eb51ef87ff2eab5c994949e69))
    avail    rsrvd     high    freed                board              kconfig                  dtb
      20k     -20k        .        .      qemu-vexpress64            defconfig           __internal
      32k     -32k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      36k     -36k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      32k     -32k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      36k     -36k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
      32k     -32k        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
      36k     -36k        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
      12k     -12k        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      16k     -16k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
      68k     -68k        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
      64k     -64k        .        .       tegra210-smaug            defconfig       tegra210-smaug
      32k     -32k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      36k     -36k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver

--
nvpublic
