From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 21 Dec 2015 14:08:22 +0000
Subject: Tegra baseline test results for v4.4-rc6
Message-ID: <567807D6.2090208@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.4-rc6.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.4-rc6/20151220163104/


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
(delta in bytes from test_v4.4-rc5 (9f9499ae8e6415cefc4fe0a96ad0e27864353c89)):
   text     data      bss    total  kernel
  +4108   +12288        0   +16396  defconfig
  -5144        0        0    -5144  multi_v7_defconfig
  +1748        0        0    +1748  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.4-rc5 (9f9499ae8e6415cefc4fe0a96ad0e27864353c89))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
       8k      -8k        .      -4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        .        .        .      -4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       8k      -8k        .      -4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
        .        .        .      -4k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
       8k      -8k        .      -4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
        .        .        .      -4k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
       8k      -8k        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        .        .        .      -4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
