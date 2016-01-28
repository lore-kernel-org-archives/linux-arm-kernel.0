From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 28 Jan 2016 11:54:28 +0000
Subject: Tegra baseline test results for v4.5-rc1
Message-ID: <56AA0174.5030608@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.5-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.5-rc1/20160128033104/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    FAIL: ( 1/ 2): qemu-vexpress64
    Pass: ( 1/ 2): tegra210-p2371-0000

Boot to userspace: multi_v7_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: multi_v7_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.4 (afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc)):
   text     data      bss    total  kernel
+878334  +129752   +13056  +1021142  defconfig
+590446  +106192    +4536  +701174  multi_v7_defconfig
+122632   +21736    +3320  +147688  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.4 (afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
    -684k     684k        .      52k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
    -136k     136k        .       8k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
    -684k     684k        .      52k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
    -136k     136k        .       8k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
    -684k     684k        .      52k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
    -136k     136k        .       8k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
    -684k     684k        .      52k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
    -136k     136k        .       8k       tegra30-beaver      tegra_defconfig       tegra30-beaver
