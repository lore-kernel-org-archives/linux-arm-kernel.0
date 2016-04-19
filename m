From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 19 Apr 2016 10:03:26 +0100
Subject: Tegra baseline test results for v4.6-rc1
Message-ID: <5715F45E.3080305@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.6-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.6-rc1/20160330013102/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 3/ 3): qemu-vexpress64, tegra132-norrin,
		   tegra210-p2371-0000

Boot to userspace: multi_v7_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: multi_v7_defconfig:
    FAIL: ( 1/ 4): tegra124-jetson-tk1
    Pass: ( 3/ 4): tegra114-dalmore-a04, tegra20-trimslice,
		   tegra30-beaver

PM: System suspend: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.5 (b562e44f507e863c6792946e4e1b1449fbbac85d)):
    text      data     bss    total  kernel
 +358923    +36920    +656  +396499  defconfig
-3662632  +3897680   -4488  +230560  multi_v7_defconfig
-2179053  +2281368   -4996   +97319  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.5 (b562e44f507e863c6792946e4e1b1449fbbac85d))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
   -2760k    2760k        .     952k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
   -1208k    1208k        .     684k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
   -2760k    2760k        .     952k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
   -1208k    1208k        .     684k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
        .        .        .        .      tegra132-norrin            defconfig      tegra132-norrin
   -2760k    2760k        .     952k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
   -1208k    1208k        .     684k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
        .        .        .        .  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
   -2760k    2760k        .     952k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
   -1208k    1208k        .     684k       tegra30-beaver      tegra_defconfig       tegra30-beaver
