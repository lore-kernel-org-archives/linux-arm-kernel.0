From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 23 Jan 2017 11:14:27 +0000
Subject: Tegra baseline test results for v4.10-rc5
Message-ID: <8a2a2fee-997b-3bc7-acee-2784d5de19ce@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.10-rc5.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.10-rc5/20170123023102/


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
(delta in bytes from test_v4.10-rc4 (49def1853334396f948dcb4cedb9347abb318df5)):
   text     data      bss    total  kernel
    +76    +1832        0    +1908  defconfig
 +20751    +5128   +65536   +91415  multi_v7_defconfig
   +788     +832        0    +1620  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.10-rc4 (49def1853334396f948dcb4cedb9347abb318df5))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
     -64k      64k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -64k      64k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
     -64k      64k        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
        .        .        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
     -64k      64k        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
      -4k       4k        .        .       tegra210-smaug            defconfig       tegra210-smaug
     -64k      64k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver

--
nvpublic
