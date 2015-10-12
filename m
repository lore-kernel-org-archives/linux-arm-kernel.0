From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 12 Oct 2015 10:29:18 +0100
Subject: Tegra baseline test results for v4.3-rc5
Message-ID: <561B7D6E.609@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.3-rc5.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.3-rc5/20151011113102/


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
(delta in bytes from test_v4.3-rc4 (049e6dde7e57f0054fdc49102e7ef4830c698b46)):
   text     data      bss    total  kernel
  -8312    +5616      -64    -2760  defconfig
  -4629    -1472        0    -6101  multi_v7_defconfig
  -4904    -1544        0    -6448  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.3-rc4 (049e6dde7e57f0054fdc49102e7ef4830c698b46))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
      12k     -12k        .      -4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
      12k     -12k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      12k     -12k        .      -4k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
      12k     -12k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
      12k     -12k        .      -4k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
      12k     -12k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
      12k     -12k        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
      12k     -12k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
