From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 6 Mar 2017 10:09:10 +0000
Subject: Tegra baseline test results for v4.11-rc1
Message-ID: <3cf7a5bd-9cdc-bb08-b41b-91a6d9dc6399@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.11-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.11-rc1/20170305133103/


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
(delta in bytes from test_v4.10 (c470abd4fde40ea6a0846a2beab642a578c0b8cd)):
   text     data      bss    total  kernel
+244712  +130912    +2280  +377904  defconfig
+175580  +128192     +488  +304260  multi_v7_defconfig
 +80308   +17632   -66268   +31672  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.10 (c470abd4fde40ea6a0846a2beab642a578c0b8cd))
    avail    rsrvd     high    freed                board              kconfig                  dtb
    1184k   -1184k        .      64k      qemu-vexpress64            defconfig           __internal
   -1104k    1104k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      36k     -36k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
   -1104k    1104k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      36k     -36k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
   -1104k    1104k        .        .    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
      36k     -36k        .        .    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
   -1088k    1088k        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      52k     -52k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
    5768k   -5768k        .      64k  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
    5768k   -5768k        .      64k       tegra210-smaug            defconfig       tegra210-smaug
   -1104k    1104k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      36k     -36k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver

--
nvpublic
