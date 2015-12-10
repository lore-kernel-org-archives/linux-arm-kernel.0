From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 10 Dec 2015 12:43:34 +0000
Subject: Tegra baseline test results for v4.4-rc1
Message-ID: <56697376.9060406@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.4-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.4-rc1/20151208093330/


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
(delta in bytes from test_v4.3 (6a13feb9c82803e2b815eca72fa7a9f5561d7861)):
   text     data      bss    total  kernel
+272788   +40576    +5824  +319188  defconfig
+260002   +38896     +320  +299218  multi_v7_defconfig
+286258   +14816     +944  +302018  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.3 (6a13feb9c82803e2b815eca72fa7a9f5561d7861))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        .      qemu-vexpress64            defconfig           __internal
    -292k     292k   -8192k      24k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
    -308k     308k   -8192k      12k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
    -292k     292k   -8192k      24k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
    -308k     308k   -8192k      12k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
    -292k     292k   -8192k      24k    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
    -308k     308k   -8192k      12k    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
    -292k     292k   -8192k      24k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
    -308k     308k   -8192k      12k       tegra30-beaver      tegra_defconfig       tegra30-beaver
