From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 10 Dec 2015 13:27:38 +0000
Subject: Tegra baseline test results for v4.4-rc2
Message-ID: <56697DCA.7080408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.4-rc2.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.4-rc2/20151210044354/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 1/ 1): qemu-vexpress64

Boot to userspace: multi_v7_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver


vmlinux object size
(delta in bytes from test_v4.4-rc1 (8005c49d9aea74d382f474ce11afbbc7d7130bec)):
   text     data      bss    total  kernel
    +55        0        0      +55  defconfig
  +6023     +320        0    +6343  multi_v7_defconfig
   +927     +128        0    +1055  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.4-rc1 (8005c49d9aea74d382f474ce11afbbc7d7130bec))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
     -12k      12k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -12k      12k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
     -12k      12k        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
     -12k      12k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
