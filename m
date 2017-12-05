From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 5 Dec 2017 14:03:58 +0000
Subject: Tegra baseline test results for v4.15-rc1
Message-ID: <42c00023-110c-9c88-c15d-deacc95ecfb3@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v4.15-rc1.
Logs and other details at:

    https://nvtb.github.io//linux/test_v4.15-rc1/20171204133126/


Test summary - 84% Success
--------------------------

Build: zImage:
    Pass: ( 3/ 3): multi_v7_defconfig, tegra_defconfig,
		   tegra_defconfig%tegra-fw

Build: Image:
    Pass: ( 3/ 3): defconfig, defconfig%jetson-tx2,
		   defconfig%jetson-tx1

Boot to userspace: defconfig:
    Pass: ( 4/ 4): qemu-vexpress64, tegra132-norrin,
		   tegra210-p2371-0000, tegra210-smaug

Boot to userspace: defconfig%jetson-tx1:
    Pass: ( 2/ 2): tegra210-p2371-0000, tegra210-p2371-2180

Boot to userspace: defconfig%jetson-tx2:
    Pass: ( 1/ 1): tegra186-p2771-0000

Boot to userspace: multi_v7_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

Boot to userspace: tegra_defconfig%tegra-fw:
    FAIL: ( 1/ 2): tegra124-nyan-big
    Pass: ( 1/ 2): tegra124-jetson-tk1

PM: System suspend: multi_v7_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig:
    FAIL: ( 1/ 5): tegra124-nyan-big
    Pass: ( 4/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver

PM: System suspend: tegra_defconfig%tegra-fw:
    FAIL: ( 1/ 2): tegra124-nyan-big
    Pass: ( 1/ 2): tegra124-jetson-tk1


vmlinux object size
(delta in bytes from test_v4.14 (bebc6082da0a9f5d47a1ea2edc099bf671058bd4)):
   text     data      bss    total  kernel
+178037  -144968    -8488   +24581  defconfig
+111965  -295324    -1816  -185175  multi_v7_defconfig
 +79872  -300436    -1808  -222372  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v4.14 (bebc6082da0a9f5d47a1ea2edc099bf671058bd4))
    avail    rsrvd     high    freed                board              kconfig                  dtb
      20k     -20k        .     -64k      qemu-vexpress64            defconfig           __internal
    -928k     928k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
    1108k   -1108k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
    -916k     916k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
    1120k   -1120k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
    -916k     916k        .   -2048k    tegra124-nyan-big   multi_v7_defconfig    tegra124-nyan-big
    1124k   -1124k        .   -1024k    tegra124-nyan-big      tegra_defconfig    tegra124-nyan-big
   -2088k    2088k        .     -64k      tegra132-norrin            defconfig      tegra132-norrin
    -932k     932k        .        .    tegra20-trimslice   multi_v7_defconfig    tegra20-trimslice
    1104k   -1104k        .        .    tegra20-trimslice      tegra_defconfig    tegra20-trimslice
      56k     -56k        .     -64k  tegra210-p2371-0000            defconfig  tegra210-p2371-0000
   -2064k    2064k        .     -64k       tegra210-smaug            defconfig       tegra210-smaug
    -920k     920k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
    1116k   -1116k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
--
nvpublic
